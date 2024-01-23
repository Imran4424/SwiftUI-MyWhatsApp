//
//  SettingsView.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 15/1/24.
//

import FirebaseAuth
import FirebaseStorage
import SwiftUI

struct SettingsConfig {
    var showPhotoOptions: Bool = false
    var sourceType: UIImagePickerController.SourceType?
    var selectedImage: UIImage?
    var displayName: String = ""
}

struct SettingsView: View {
    @EnvironmentObject private var model: Model
    @State private var settingsConfig = SettingsConfig()
    @State private var currentPhotoURL: URL? = Auth.auth().currentUser!.photoURL
    
    @FocusState var isEditing: Bool
    
    var displayName: String {
        guard let currentUser = Auth.auth().currentUser else {
            return "Guest"
        }
        
        return currentUser.displayName ?? "Guest"
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: currentPhotoURL) { image in
                image.rounded()
            } placeholder: {
                Image(systemName: "person.crop.circle.fill")
                    .rounded()
            }
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
        .sheet(item: $settingsConfig.sourceType, content: { sourceType in
            ImagePicker(image: $settingsConfig.selectedImage, sourceType: sourceType)
        })
        .onChange(of: settingsConfig.selectedImage) { oldImage, newImage in
            // resize the image
            guard let image = newImage,
                  let resizedImage = image.resize(),
                  let imageData = resizedImage.pngData() else {
                print("setting image resizing failed")
                return
            }
            
            // upload the image to Firebase Storage to get the url
            Task {
                guard let currentUser = Auth.auth().currentUser else {
                    print("current user is nil")
                    return
                }
                
                let filename = "\(currentUser.uid).png"
                
                do {
                    let url = try await Storage.storage().uploadData(for: filename, data: imageData, bucket: .photos)
                    try await model.updatePhotoURL(for: currentUser, photoURL: url)
                    currentPhotoURL = url
                    print(url)
                } catch {
                    print(error.localizedDescription)
                }
            }
            
        }
        .onAppear {
            settingsConfig.displayName = displayName
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(Model())
}
