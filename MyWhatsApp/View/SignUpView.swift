//
//  SignUpView.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 25/12/23.
//

import FirebaseAuth
import SwiftUI

struct SignUpView: View {
    @EnvironmentObject private var model: Model
    @EnvironmentObject private var appState: AppState
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var displayName: String = ""
    @State private var errorMessage: String = ""
    
    private var isFormValid: Bool {
        if email.isEmptyOrWhiteSpace {
            return false
        } else if password.isEmptyOrWhiteSpace {
            return false
        } else if displayName.isEmptyOrWhiteSpace {
            return false
        }
        
        return true
    }
    
    var body: some View {
        VStack {
            Form {
                TextField("Display name", text: $displayName)
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                SecureField("Password", text: $password)
                    .textInputAutocapitalization(.never)
                
                HStack {
                    Spacer()
                    
                    Button("Log In") {
                        // take user to login view
                        appState.routes.append(.login)
                    }
                    
                    Spacer()
                    
                    Button("Sign Up") {
                        Task {
                            await signUp()
                        }
                    }
                    .disabled(!isFormValid)
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

// MARK: - methods
extension SignUpView {
    private func signUp() async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            try await model.updateDisplayName(for: result.user, displayName: displayName)
            appState.routes.append(.login)
        } catch {
            errorMessage = error.localizedDescription
            print(error)
        }
    }
}

#Preview {
    SignUpView()
        .environmentObject(Model())
        .environmentObject(AppState())
}
