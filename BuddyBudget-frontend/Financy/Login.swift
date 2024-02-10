//
//  Login.swift
//  Financy
//
//  Created by Adriana Zambrano on 1/27/24.
//

import SwiftUI
import Combine

class AuthenticationViewModel : ObservableObject {
    func post_bearer(username: String, password: String, completion: @escaping (Bool, Int?, String?) -> Void) {
        print("performing request")
        guard let url =
                URL(string: "http://localhost:8000/key") else {
            completion(false, nil, nil)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(username, forHTTPHeaderField: "x-username")
        request.addValue(password, forHTTPHeaderField: "x-password")
        
        print("sending")
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
    let apiManager = APIManager.shared
    let originalString = "Hello, World!"
    var sha256Hash: String {
        return originalString.sha256()
    }
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    @State var username: String = ""
    @State var password: String = ""
    @State var uBkgd = "lightGrey"
    @State var pBkgd = "ligthGrey"
    @State var loggedIn : Bool = false
    //    @State var uph: String
    //    @State var pph: String
    var body: some View {
        NavigationView {
            VStack {
                Image("icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                    .padding(.top)
                Text("Welcome to\nFinancy")
                    .font(.largeTitle.weight(.bold))
                    .multilineTextAlignment(.center)
                    .padding()
                TextField("Username", text: $username)
                    .padding()
                    .background(Color("lightGrey"))
                    .cornerRadius(20)
                    .padding()
                TextField("Password", text: $password)
                    .padding()
                    .background(Color("lightGrey"))
                    .cornerRadius(20)
                    .padding()
                NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true), isActive: $loggedIn) {
                    Button {
                        print("preparing to handle button click")
                        if(username == "") {
                            uBkgd = "lightRed"
                        } else {
                            uBkgd = "lightGrey"
                        }
                        if(password == "") {
                            pBkgd = "lightRed"
                        } else {
                            pBkgd = "lightGrey"
                        }
                        if(username != "" && password != ""){
                            let pw_h = password.sha256()
                            let un = username
                            print("received: \(un);\(pw_h)")
                            authenticationViewModel.post_bearer(username: un, password: pw_h) {
                                success, status, message in
                                print("request done")
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
    //        .onAppear() {
    //            uph = username != "" ?? username : ""
    //            pph = password != "" ?? password, password: ""
    //        }
}

#Preview {
    Login()
}
