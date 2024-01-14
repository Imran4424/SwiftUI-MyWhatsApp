//
//  ChatMessageListView.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 14/1/24.
//

import SwiftUI

struct ChatMessageListView: View {
    
    let chatMessages: [ChatMessage]
    
    var body: some View {
        List(chatMessages) { chatMessage in
            Text(chatMessage.text)
        }
    }
}

#Preview {
    ChatMessageListView(chatMessages: [])
}
