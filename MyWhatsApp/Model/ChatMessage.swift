//
//  ChatMessage.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 14/1/24.
//

import Foundation

struct ChatMessage: Codable, Identifiable, Equatable {
    var documentId: String?
    let text: String
    let uid: String
    var dateCreated: Date = Date()
    let displayName: String
    
    var id: String {
        documentId ?? UUID().uuidString
    }
}

extension ChatMessage {
    func toDictionary() -> [String: Any] {
        return [
            "text": text,
            "uid": uid,
            "dateCreated": dateCreated,
            "displayName": displayName
        ]
    }
}
