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
                message = response.message ?? "Registration failed."
            }
        } catch {
            message = error.localizedDescription
        }
        
        username = ""
        password = ""
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create Your Account")
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
                    await register()
                }
            }) {
                Text("Register")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFormValid ? Color.green : Color.gray)
                    .cornerRadius(10)
            }
            .disabled(!isFormValid)
            .padding(.horizontal)
            
            if !message.isEmpty {
                Text(message)
                    .foregroundColor(message.contains("success") ? .green : .red)
                    .font(.callout)
                    .padding(.top)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle("Register")
    }
}

#Preview {
    NavigationStack {
        RegistrationScreen()
    }.environment(\.authenticationController, .development)
}
