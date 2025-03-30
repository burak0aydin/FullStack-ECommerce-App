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
    @State private var confirmPassword: String = ""
    @State private var message: String = ""
    @State private var isLoading: Bool = false
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhitespace && 
        !password.isEmptyOrWhitespace && 
        !confirmPassword.isEmptyOrWhitespace &&
        password == confirmPassword
    }
    
    private var passwordsMatch: Bool {
        password.isEmpty || confirmPassword.isEmpty || password == confirmPassword
    }
    
    private func register() async {
        isLoading = true
        do {
            let response = try await authenticationController.register(username: username, password: password)
            
            if response.success {
                message = "Registration successful! You can now login."
                // Automatically go back to login after successful registration
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    dismiss()
                }
            } else {
                message = response.message ?? "Registration failed."
            }
        } catch {
            message = error.localizedDescription
        }
        
        isLoading = false
    }
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.green.opacity(0.1), Color.green.opacity(0.3)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 25) {
                    // Logo/Image placeholder
                    Image(systemName: "person.crop.circle.badge.plus")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .foregroundColor(.green)
                        .padding(.top, 40)
                    
                    Text("Create Account")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Text("Join SmartShop and start shopping")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 15)
                    
                    // Form Fields
                    VStack(spacing: 20) {
                        // Username field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Username")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            HStack {
                                Image(systemName: "person")
                                    .foregroundColor(.gray)
                                TextField("Choose a username", text: $username)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(username.isEmpty ? Color.gray.opacity(0.3) : Color.green, lineWidth: 1)
                                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemBackground)))
                            )
                        }
                        
                        // Password field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            HStack {
                                Image(systemName: "lock")
                                    .foregroundColor(.gray)
                                SecureField("Create a password", text: $password)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(password.isEmpty ? Color.gray.opacity(0.3) : Color.green, lineWidth: 1)
                                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemBackground)))
                            )
                        }
                        
                        // Confirm Password field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Confirm Password")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            HStack {
                                Image(systemName: "lock.shield")
                                    .foregroundColor(.gray)
                                SecureField("Confirm your password", text: $confirmPassword)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(
                                        confirmPassword.isEmpty ? Color.gray.opacity(0.3) : 
                                            (passwordsMatch ? Color.green : Color.red), 
                                        lineWidth: 1
                                    )
                                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemBackground)))
                            )
                            
                            if !confirmPassword.isEmpty && !passwordsMatch {
                                Text("Passwords don't match")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .padding(.top, 5)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Message display
                    if !message.isEmpty {
                        Text(message)
                            .foregroundColor(message.contains("success") ? .green : .red)
                            .font(.callout)
                            .padding(.top, 5)
                    }
                    
                    // Register button
                    Button {
                        Task {
                            await register()
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(isFormValid ? Color.green : Color.gray.opacity(0.5))
                                .frame(height: 55)
                                .shadow(color: isFormValid ? Color.green.opacity(0.3) : Color.clear, radius: 5, x: 0, y: 3)
                            
                            if isLoading {
                                ProgressView()
                                    .tint(.white)
                            } else {
                                Text("Sign Up")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .disabled(!isFormValid || isLoading)
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // Return to login button
                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: 4) {
                            Text("Already have an account?")
                                .foregroundColor(.secondary)
                            Text("Sign In")
                                .foregroundColor(.green)
                                .fontWeight(.semibold)
                        }
                        .font(.subheadline)
                    }
                    .padding(.top, 15)
                    
                    Spacer(minLength: 50)
                }
                .padding()
            }
        }
        .navigationTitle("Register")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        RegistrationScreen()
    }.environment(\.authenticationController, .development)
}
