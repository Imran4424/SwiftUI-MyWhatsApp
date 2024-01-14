//
//  ChatMessageView.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 14/1/24.
//

import SwiftUI

enum ChatMessageDirection {
    case left
    case right
}

struct ChatMessageView: View {
    
    let chatMessage: ChatMessage
    let direction: ChatMessageDirection
    let color: Color
    
    var body: some View {
        HStack {
            // profile photo
            
            VStack(alignment: .leading, spacing: 5) {
                Text(chatMessage.displayName)
                    .opacity(0.8)
                    .font(.caption)
                    .foregroundStyle(.white)
                
                // attachment photo URL
                Text(chatMessage.text)
                Text(chatMessage.dateCreated, format: .dateTime)
                    .font(.caption)
                    .opacity(0.4)
                    .frame(maxWidth: 200, alignment: .trailing)
            }
            .padding(8)
            .background(color)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            
            // profile photo
        }
        .listRowSeparator(.hidden)
        .overlay(alignment: direction == .left ? .bottomLeading: .bottomTrailing) {
            Image(systemName: "arrowtriangle.down.fill")
                .font(.title)
                .rotationEffect(.degrees(direction == .left ? 45: -45))
                .offset(x: direction == .left ? 30: -30, y: 10)
                .foregroundStyle(color)
        }
    }
}

#Preview {
    ChatMessageView(chatMessage: ChatMessage(documentId: "ABCD", text: "Hi", uid: "QWERTY", dateCreated: Date(), displayName: "Imran"), direction: .left, color: .blue)
}
