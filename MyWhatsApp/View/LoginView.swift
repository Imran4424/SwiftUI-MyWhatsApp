//
//  LoginView.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 30/12/23.
//

import FirebaseAuth
import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    
    private var isFormValid: Bool {
        if email.isEmptyOrWhiteSpace {
            return false
        } else if password.isEmptyOrWhiteSpace {
            return false
        }
        
        return true
    }
    
    var body: some View {
        VStack {
            Form {
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                SecureField("Password", text: $password)
                    .textInputAutocapitalization(.never)
                
                HStack {
                    Spacer()
                    
                    Button("Log In") {
                        // take user to login view
                    }
                    .disabled(!isFormValid)
                    .buttonStyle(.borderless)
                    
                    Spacer()
                    
                    Button("Sign Up") {
                        Task {
                            
                        }
                    }
                    .buttonStyle(.borderless)
                    
                    Spacer()
                }
            }
            
            Text(errorMessage)
                .foregroundStyle(.red)
            
            Spacer()
            Spacer()
        }
    }
}

// MARK: - Methods
extension LoginView {
    private func login() async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
                // go to the main screen
        } catch {
            print(error.localizedDescription)
        }
        
    }
}


#Preview {
    LoginView()
}
