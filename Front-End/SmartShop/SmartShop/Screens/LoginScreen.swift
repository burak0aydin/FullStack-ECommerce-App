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
            
            message = "Login successful!"
        } catch {
            message = error.localizedDescription
        }
        
        username = ""
        password = ""
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome Back!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)
            
            VStack(spacing: 16) {
                TextField("User name", text: $username)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            }
            .padding(.horizontal)
            
            Button(action: {
                Task {
                    await login()
                }
            }) {
                Text("Login")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFormValid ? Color.blue : Color.gray)
                    .cornerRadius(10)
            }
            .disabled(!isFormValid)
            .padding(.horizontal)
            
            if !message.isEmpty {
                Text(message)
                    .foregroundColor(message.contains("successful") ? .green : .red)
                    .font(.callout)
                    .padding(.top)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle("Login")
    }
}

#Preview {
    NavigationStack {
        LoginScreen()
    }.environment(\.authenticationController, .development)
}
