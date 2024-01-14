//
//  GroupDetailView.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 14/1/24.
//

import FirebaseAuth
import SwiftUI

struct GroupDetailView: View {
    @EnvironmentObject private var model: Model
    
    let group: Group
    @State private var chatText = ""
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                TextField("Enter a chat message", text: $chatText)
                Button("Send") {
                    Task {
                        do {
                            try await sendMessage()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            .padding()
        }
        .padding()
    }
}

// MARK: - Methods
extension GroupDetailView {
    private func sendMessage() async throws {
        guard let currentUser = Auth.auth().currentUser else {
            print("current user is nil")
            return
        }
        
        let chatMessage = ChatMessage(text: chatText, uid: currentUser.uid, displayName: currentUser.displayName ?? "Guest")
        
        try await model.saveChatMessageToGroup(chatMessage: chatMessage, group: group)
    }
}

#Preview {
    GroupDetailView(group: Group(subject: "Test"))
        .environmentObject(Model())
}
