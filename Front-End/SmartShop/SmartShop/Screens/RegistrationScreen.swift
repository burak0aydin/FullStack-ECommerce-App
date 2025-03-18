//
//  RegistrationScreen.swift
//  SmartShop
//
//  Created by Burak Aydın on 19.03.2025.
//

import SwiftUI

struct RegistrationScreen: View {
    
    @Environment(\.authenticationController) private var authenticationController
    @Environment(\.dismiss) private var dismiss
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var message: String = ""
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhitespace && !password.isEmptyOrWhitespace
    }
    
    private func register() async {
        
        do {
            let response = try await authenticationController.register(username: username, password: password)
            
            if response.success {
                dismiss()
            } else {
                message = response.message ?? ""
            }
            
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
            Button("Register") {
                Task {
                    await register()
                }
            }.disabled(!isFormValid)
            
            Text(message)
            
        }.navigationTitle("Register")
    }
}

#Preview {
    NavigationStack {
        RegistrationScreen()
    }.environment(\.authenticationController, .development)
}
