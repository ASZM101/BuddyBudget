// External crates and modules
#[macro_use] extern crate rocket;

use std::fmt::Display;
use std::rc::Rc;
use rand::prelude::*;
use rocket::data::{FromData, Outcome, ToByteUnit};
use rocket::{Data, Request};
use std::fs::File;
use std::io::{Read, Write};
use std::path::{Path, PathBuf};
use rocket::fs::NamedFile;
use rocket::http::Status;
use rocket::response::status;
use rocket::response::status::NotFound;

// Struct representing a key used for authentication
struct Key {
    val: String,
    expiry: u64,
    for_user_uuid: String
}

// Struct representing a financial transaction
struct Transaction {
    for_user: String,
    name: String,
    time: u64,
    amount: f64
}

// Struct representing a user
struct User {
    username: String,
    transaction: Vec<Rc<Transaction>>,
    password_hash: String
}

// Struct representing the information sent in the key transaction request
struct KeyTransaction {
    for_user: String,
    expires: u64
}

// Struct representing the information sent in the sign-up request
struct SignUp {
    username: String,
    password: String
}

// Static vector to store authentication keys
static mut KEYS: Vec<Key> = Vec::new();

// Static vector to store user information
static mut USERS: Vec<User> = Vec::new();

// Function to search for a user by username
fn search_for_user(username: String) -> bool {
    unsafe {
        for user in &USERS {
            if user.username == username {
                return true;
            }
        }
    }
    false
}

// Function to get the current Unix timestamp
fn get_unix() -> u64 {
    use std::time::{SystemTime, UNIX_EPOCH};
    let now = SystemTime::now();
    let since_the_epoch = now.duration_since(UNIX_EPOCH).expect("Time went backwards");
    since_the_epoch.as_secs()
}

// Function to check if a key is valid
fn key_valid(k: &String) -> bool {
    unsafe {
        for key in &KEYS {
            if key.val == *k {
                return if (key.expiry - get_unix()) > 0 {
                    true
                } else {
                    KEYS.retain(|x| x.val != *k);
                    false
                }
            }
        }
    }
    false
}

// Function to retrieve a key from the existing keys
fn get_key(k: String) -> Option<&'static Key> {
    unsafe {
        for key in &KEYS {
            if key.val == k {
                return Some(*Rc::new(key));
            }
        }
    }
    None
}

// Implementation of the FromData trait for KeyTransaction
#[async_trait]
impl<'a> FromData<'a> for KeyTransaction {
    type Error = ();

    async fn from_data(req: &'a Request<'_>, _data: Data<'a>) -> Outcome<'a, Self> {
        // Get headers from the request
        let header = req.headers();
        if !header.contains("x-username") || !header.contains("x-password") {
            return Outcome::Error((Status::BadRequest, ()));
        }
        let username = header.get_one("x-username").unwrap().to_string();
        let password = header.get_one("x-password").unwrap().to_string();

        // Set the expiry time for the key (one day from now)
        let one_day_from_now = get_unix() + 86400;
        let key = key_valid(&username);
        if !key {
            // Check if the user exists
            if !search_for_user(username.clone()) {
                return Outcome::Error((Status::Unauthorized, ()));
            }
            // Check if the password is correct
            unsafe {
                for user in &USERS {
                    if user.username == username && user.password_hash != password {
                        return Outcome::Error((Status::Unauthorized, ()));
                    }
                }
            }
            // Generate a new key and add it to the KEYS vector
            let mut rng = thread_rng();
            let mut val = String::from("bearer_");
            for _ in 0..32 {
                val.push(rng.gen_range(0..9).to_string().chars().next().unwrap());
            }
            let val_clone = val.clone();
            unsafe {
                KEYS.push(Key {
                    val: val_clone,
                    expiry: one_day_from_now,
                    for_user_uuid: username.clone()
                });
            }
            Outcome::Success(KeyTransaction {
                for_user: username,
                expires: one_day_from_now
            })
        } else {
            // If the key already exists, return it with a new expiry time
            Outcome::Success(KeyTransaction {
                for_user: username,
                expires: one_day_from_now
            })
        }
    }
}

// Implementation of the FromData trait for Transaction
#[async_trait]
impl<'a> FromData<'a> for Transaction {
    type Error = ();

    async fn from_data(req: &'a Request<'_>, data: Data<'a>) -> Outcome<'a, Self> {
        // Read the key from the header
        let header = req.headers();
        if !header.contains("x-bearer") {
            return Outcome::Error((Status::Unauthorized, ()));
        }
        let key = header.get_one("x-bearer").unwrap().to_string();
        if !key_valid(&key) {
            return Outcome::Error((Status::Unauthorized, ()));
        }
        // Get the user UUID from the key
        let user = get_key(key).unwrap().for_user_uuid.clone();
        // Read data from the request and parse it into a Transaction struct
        let inner = data.open(2048.mebibytes()).into_string().await.unwrap().into_inner();
        let mut split = inner.split(';');
        let name = split.next().unwrap().to_string();
        let result = split.next().unwrap().to_string();

        Outcome::Success(Transaction {
            for_user: user,
            name,
            time: get_unix(),
            amount: result.parse().unwrap_or(0.0)
        })
    }
}

// Implementation of the FromData trait for SignUp
#[async_trait]
impl<'a> FromData<'a> for SignUp {
    type Error = ();

    async fn from_data(_req: &'a Request<'_>, data: Data<'a>) -> Outcome<'a, Self> {
        // Read data from the request and parse it into a SignUp struct
        let inner = data.open(2048.mebibytes()).into_string().await.unwrap().into_inner();
        let result = inner.trim();
        let mut split = result.split(';');
        let username = split.next().unwrap().to_string();
        let password = split.next().unwrap().to_string();
        // Check if the user already exists
        if search_for_user(username.clone()) {
            return Outcome::Error((Status::Unauthorized, ()));
        }
        Outcome::Success(SignUp {
            username,
            password
        })
    }
}

// Implementation of the Display trait for Transaction
impl Display for Transaction {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        let formatted = format!("{}:{}:{}", self.time, self.name, self.amount);
        write!(f, "{}", formatted)
    }
}

// Rocket endpoint to generate and return a new authentication key
#[get("/key", data = "<key>")]
fn key(key: KeyTransaction) -> String {
    let mut rng = thread_rng();
    let mut val = String::from("bearer_");
    for _ in 0..32 {
        val.push(rng.gen_range(0..9).to_string().chars().next().unwrap());
    }
    let val_clone = val.clone();
    unsafe {
        KEYS.push(Key {
            val: val_clone,
            expiry: key.expires,
            for_user_uuid: key.for_user
        });
    }
    val
}

// Rocket endpoint to handle financial transactions
#[post("/transact", data="<transact>")]
fn transact(transact: Transaction) -> String {
    unsafe {
        for user in &mut USERS {
            if user.username == transact.for_user {
                user.transaction.push(Rc::new(transact));
                return String::from("OK");
            }
        }
    }
    String::from("Unable to find user")
}

// Rocket endpoint to retrieve the total balance for a user
#[get("/balance/<bearer>")]
fn balance(bearer: String) -> status::Custom<String> {
    let mut total = 0.0;
    if !key_valid(&bearer) {
        return status::Custom(Status::Unauthorized, String::from("Unauthorized"));
    }
    let u = get_key(bearer).unwrap().for_user_uuid.clone();
    unsafe {
        for user in &USERS {
            if user.username == u {
                for transaction in &user.transaction {
                    total += transaction.amount;
                }
            }
        }
    }
    status::Custom(Status::Ok, total.to_string())
}

// Rocket endpoint to retrieve all transactions for a user
#[get("/transactions/<bearer>")]
fn get_transactions(bearer: String) -> status::Custom<String> {
    if !key_valid(&bearer) {
        return status::Custom(Status::Unauthorized, String::from("Unauthorized"));
    }
    let u = get_key(bearer).unwrap().for_user_uuid.clone();
    let mut transactions = String::new();
    unsafe {
        for user in &USERS {
            if user.username == u {
                for transaction in &user.transaction {
                    transactions.push_str(&transaction.to_string());
                    transactions.push('\n');
                }
            }
        }
    }
    status::Custom(Status::Ok, transactions)
}

// Rocket endpoint to delete all transactions for a user
#[post("/dump/<bearer>")]
fn delete_all(bearer: String) -> status::Custom<String> {
    if !key_valid(&bearer) {
        return status::Custom(Status::Unauthorized, String::from("Unauthorized"));
    }
    let u = get_key(bearer).unwrap().for_user_uuid.clone();
    unsafe {
        for user in &mut USERS {
            if user.username == u {
                user.transaction.clear();
            }
        }
    }
    status::Custom(Status::Ok, String::from("OK"))
}

// Rocket endpoint to serve static files
#[get("/<file..>")]
async fn files(file: PathBuf) -> Result<NamedFile, NotFound<String>> {
    let path = Path::new("static/").join(file);
    NamedFile::open(&path).await.map_err(|e| NotFound(e.to_string()))
}

// Rocket endpoint to handle user sign-up
#[post("/create", data="<form>")]
fn sign_up(form: SignUp) -> Result<String, status::Custom<String>> {
    let mut file = File::open("users").unwrap();
    // Write new user information to the "users" file
    file.write(format!("{};{};\n", form.username, form.password).as_bytes()).map_err(|e| status::Custom(Status::InternalServerError, e.kind().to_string()))?;
    unsafe {
        // Add the new user to the USERS vector
        USERS.push(User {
            username: form.username.clone(),
            password_hash: form.password.clone(),
            transaction: Vec::new()
        });
    }
    Ok(String::from("Success"))
}

// Rocket application setup
#[launch]
async fn rocket() -> _ {
    // Read user information from the "users" file and populate the USERS vector
    let mut file = File::open("users").unwrap();
    let mut contents = String::new();
    file.read_to_string(&mut contents).unwrap();
    let split = contents.split('\n');
    for line in split {
        let line = line.trim();
        let mut split = line.split(';');
        unsafe {
            USERS.push(User {
                username: split.next().unwrap().parse().unwrap(),
                password_hash: split.next().unwrap().parse().unwrap(),
                transaction: Vec::new()
            });
        }
    }
    println!("Parsed {} users", unsafe { USERS.len() });
    // Return the configured Rocket instance
    rocket::build()
        .mount("/", routes![files, key, transact, balance, get_transactions, sign_up, delete_all])
}