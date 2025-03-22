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
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhitespace && !password.isEmptyOrWhitespace
    }
    
    private func login() async {
        
        do {
           
            
            
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
            
        }.navigationTitle("Register")
    }
}

#Preview {
    NavigationStack {
        LoginScreen()
    }.environment(\.authenticationController, .development)
}
