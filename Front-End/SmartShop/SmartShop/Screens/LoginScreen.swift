//
//  LoginScreen.swift
//  SmartShop
//
//  Created by Burak Aydın on 22.03.2025.
//
import SwiftUI

struct LoginScreen: View {
    
    @Environment(\.authenticationController) private var authenticationController
    @State private var showingRegistration = false
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var message: String = ""
    @State private var isLoading: Bool = false
    
    @AppStorage("userId") private var userId: Int?
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhitespace && !password.isEmptyOrWhitespace
    }
    
    private func login() async {
        isLoading = true
        do {
            let response = try await authenticationController.login(username: username, password: password)
            
            guard let token = response.token,
                  let userId = response.userId, response.success else {
                message = response.message ?? "Request cannot be completed."
                isLoading = false
                return
            }
            
            // set the token in keychain
            Keychain.set(token, forKey: "jwttoken")
            
            // set userId in user defaults
            self.userId = userId
            
            message = "Login successful!"
        } catch {
            message = error.localizedDescription
        }
        
        isLoading = false
    }
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.blue.opacity(0.3)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 25) {
                    // Logo/Image placeholder
                    Image(systemName: "cart.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .foregroundColor(.blue)
                        .padding(.top, 40)
                    
                    Text("Welcome Back!")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Text("Log in to your account")
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
                                TextField("Enter your username", text: $username)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(username.isEmpty ? Color.gray.opacity(0.3) : Color.blue, lineWidth: 1)
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
                                SecureField("Enter your password", text: $password)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(password.isEmpty ? Color.gray.opacity(0.3) : Color.blue, lineWidth: 1)
                                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemBackground)))
                            )
                        }
                    }
                    .padding(.horizontal)
                    
                    // Message display
                    if !message.isEmpty {
                        Text(message)
                            .foregroundColor(message.contains("successful") ? .green : .red)
                            .font(.callout)
                            .padding(.top, 5)
                    }
                    
                    // Login button
                    Button {
                        Task {
                            await login()
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(isFormValid ? Color.blue : Color.gray.opacity(0.5))
                                .frame(height: 55)
                                .shadow(color: isFormValid ? Color.blue.opacity(0.3) : Color.clear, radius: 5, x: 0, y: 3)
                            
                            if isLoading {
                                ProgressView()
                                    .tint(.white)
                            } else {
                                Text("Sign In")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .disabled(!isFormValid || isLoading)
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // Create account button
                    NavigationLink(destination: RegistrationScreen(), isActive: $showingRegistration) {
                        EmptyView()
                    }
                    
                    Button {
                        showingRegistration = true
                    } label: {
                        HStack(spacing: 4) {
                            Text("Don't have an account?")
                                .foregroundColor(.secondary)
                            Text("Sign Up")
                                .foregroundColor(.blue)
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
        .navigationTitle("Login")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        LoginScreen()
    }.environment(\.authenticationController, .development)
}
