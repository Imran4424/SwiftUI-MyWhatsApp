//
//  ChatMessageListView.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 14/1/24.
//

import FirebaseAuth
import SwiftUI

struct ChatMessageListView: View {
    
    let chatMessages: [ChatMessage]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(chatMessages) { chatMessage in
                    VStack {
                        if isChatMessageFromCurrentUser(chatMessage) {
                            HStack {
                                Spacer()
                                ChatMessageView(chatMessage: chatMessage, direction: .right, color: .blue)
                            }
                        } else {
                            HStack {
                                ChatMessageView(chatMessage: chatMessage, direction: .left, color: .gray)
                                Spacer()
                            }
                        }
                        
                        Spacer()
                            .frame(height: 20)
                            .id(chatMessage.id)
                    }
                    .listRowSeparator(.hidden)
                }
            }
        }
        .padding([.bottom], 60)
    }
}

// MARK: - methods
extension ChatMessageListView {
    private func isChatMessageFromCurrentUser(_ chatMessage: ChatMessage) -> Bool {
        guard let currentUser = Auth.auth().currentUser else {
            return false
        }
        
        return currentUser.uid == chatMessage.uid
    }
}

#Preview {
    ChatMessageListView(chatMessages: [])
}
