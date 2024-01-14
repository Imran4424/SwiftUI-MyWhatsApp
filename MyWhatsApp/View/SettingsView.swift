//
//  SettingsView.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 15/1/24.
//

import FirebaseAuth
import SwiftUI

struct SettingsConfig {
    var showPhotoOptions: Bool = false
    var sourceType: UIImagePickerController.SourceType?
    var selectedImage: UIImage?
    var displayName: String = ""
}

struct SettingsView: View {
    @State private var settingsConfig = SettingsConfig()
    @FocusState var isEditing: Bool
    
    var displayName: String {
        guard let currentUser = Auth.auth().currentUser else {
            return "Guest"
        }
        
        return currentUser.displayName ?? "Guest"
    }
    
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle.fill")
                .rounded()
                .onTapGesture {
                    settingsConfig.showPhotoOptions.toggle()
                }
                .confirmationDialog("Select", isPresented: $settingsConfig.showPhotoOptions) {
                    Button("Camera") {
                        settingsConfig.sourceType = .camera
                    }
                    
                    Button("Photo Library") {
                        settingsConfig.sourceType = .photoLibrary
                    }
                }
            
            TextField(settingsConfig.displayName, text: $settingsConfig.displayName)
                .textFieldStyle(.roundedBorder)
                .focused($isEditing)
                .textInputAutocapitalization(.never)
            
            Spacer()
            
            Button("Signout") {
                
            }
        }
        .padding()
        .onAppear {
            settingsConfig.displayName = displayName
        }
    }
}

#Preview {
    SettingsView()
}
