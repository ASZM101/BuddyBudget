import SwiftUI
import Combine

class AuthenticationViewModel : ObservableObject {
    // Function to perform authentication and obtain bearer token
    func post_bearer(username: String, password: String, completion: @escaping (Bool, Int?, String?) -> Void) {
        print("performing request")
        guard let url =
                URL(string: "http://localhost:8000/key") else {
            completion(false, nil, nil)
            return
        }
        
        // Prepare the URL request with headers
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(username, forHTTPHeaderField: "x-username")
        request.addValue(password, forHTTPHeaderField: "x-password")
        
        print("sending")
        
        // Perform data task for authentication
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let hr = response as? HTTPURLResponse, let rd = data {
                let status = hr.statusCode
                print("status: \(status)")
                if let msg = String(data: rd, encoding: .utf8) {
                    completion(status == 200, status, msg)
                } else {
                    completion(false, status, nil)
                }
            } else {
                completion(false, nil, nil)
            }
        }.resume()
    }
}

struct Login: View {
    // Shared instance of the APIManager
    let apiManager = APIManager.shared
    
    // Original string for hashing
    let originalString = "Hello, World!"
    
    // Computed property to obtain SHA-256 hash of the original string
    var sha256Hash: String {
        return originalString.sha256()
    }
    
    // State object for the AuthenticationViewModel
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    
    // State variables for username, password, and background colors
    @State var username: String = ""
    @State var password: String = ""
    @State var uBkgd = "lightGrey"
    @State var pBkgd = "ligthGrey"
    
    // State variable to track login status
    @State var loggedIn : Bool = false
    var body: some View {
        NavigationView {
            VStack {
                // App icon image
                Image("icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .padding(.top)
                
                // Welcome text
                Text("Welcome to\nBuddyBudget")
                    .font(.largeTitle.weight(.bold))
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                // Text field for username
                TextField("Username", text: $username)
                    .padding()
                    .background(Color("lightGrey"))
                    .cornerRadius(20)
                    .padding()
                    .padding(.leading)
                    .padding(.trailing)
                
                // Text field for password
                TextField("Password", text: $password)
                    .padding()
                    .background(Color("lightGrey"))
                    .cornerRadius(20)
                    .padding()
                    .padding(.leading)
                    .padding(.trailing)
                
                // Navigation link to ContentView upon successful login
                NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true), isActive: $loggedIn) {
                    Button {
                        print("preparing to handle button click")
                        
                        // Check for empty username
                        if(username == "") {
                            uBkgd = "lightRed"
                        } else {
                            uBkgd = "lightGrey"
                        }
                        
                        // Check for empty password
                        if(password == "") {
                            pBkgd = "lightRed"
                        } else {
                            pBkgd = "lightGrey"
                        }
                        
                        // If both username and password are valid, perform authentication
                        if(username != "" && password != ""){
                            let pw_h = password.sha256()
                            let un = username
                            print("received: \(un);\(pw_h)")
                            
                            // Call AuthenticationViewModel to perform authentication
                            authenticationViewModel.post_bearer(username: un, password: pw_h) {
                                success, status, message in
                                print("request done")
                                
                                // Handle authentication success or failure
                                if success, let msg = message {
                                    print("Authentication success")
                                    APIManager.bearer = msg
                                    print("saved bearer: \(APIManager.bearer)")
                                    loggedIn = true
                                } else {
                                    print("Authentication fail")
                                }
                            }
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("Login")
                            Spacer()
                        }
                        .frame(width: 150)
                    }
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(.capsule)
                }
                Spacer()
            }
        }
    }
}

// Preview the Login view
#Preview {
    Login()
}
