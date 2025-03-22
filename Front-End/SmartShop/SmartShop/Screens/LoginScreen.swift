//
//  LoginScreen.swift
//  SmartShop
//
//  Created by Burak Aydın on 22.03.2025.
//

import SwiftUI

struct LoginScreen: View {
    
    @Environment(\.authenticationController) private var authenticationController
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var message: String = ""
    
    @AppStorage("userId") private var userId: Int?
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhitespace && !password.isEmptyOrWhitespace
    }
    
    private func login() async {
        
        do {
           
            let response = try await authenticationController.login(username: username, password: password)
            
            guard let token = response.token,
                  let userId = response.userId, response.success else {
                message = response.message ?? "Request cannot be completed."
                return
            }
            
            print(token)
            
            // set the token in keychain
            Keychain.set(token, forKey: "jwttoken")
            
            // set userId in user defaults
            self.userId = userId
            
            
        } catch {
            message = error.localizedDescription
        }
        
        username = ""
        password = ""
        
    }
    
    var body: some View {
        Form {
            TextField("User name", text: $username)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
            Button("Login") {
                Task {
                    await login()
                }
            }.disabled(!isFormValid)
            
            Text(message)
            
        }
        .navigationDestination(item: $userId, destination: { _ in
            Text("Home Screen")
        })
        
        .navigationTitle("Login")
    }
}

#Preview {
    NavigationStack {
        LoginScreen()
    }.environment(\.authenticationController, .development)
}
