//
//  AddNewGroupView.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 30/12/23.
//

import SwiftUI

struct AddNewGroupView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var groupSubject = ""
    
    private var isFormValid: Bool {
        return !groupSubject.isEmptyOrWhiteSpace
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Group Subject", text: $groupSubject)
                }
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("New Group")
                        .bold()
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Create") {
                        saveGroup()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
}

// MARK: - Methods
extension AddNewGroupView {
    private func saveGroup() {
        let group = Group(subject: )
    }
}

#Preview {
    AddNewGroupView()
}
