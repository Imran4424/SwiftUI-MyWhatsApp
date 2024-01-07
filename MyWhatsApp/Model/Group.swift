//
//  Group.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 7/1/24.
//

import Foundation

struct Group: Codable, Identifiable {
    var documentId: String? = nil
    let subject: String
    
    var id: String {
        documentId ?? UUID().uuidString
    }
}

// MARK: - methods
extension Group {
    func toDictionary() -> [String: Any] {
        return ["subject": subject]
    }
}
