//
//  Storage+Extensions.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 24/1/24.
//

import FirebaseStorage
import Foundation

enum FirebaseStorageBuckets: String {
    case photos
    case attachments
}

extension Storage {
    func uploadData(for key: String, data: Data, bucket: FirebaseStorageBuckets) async throws -> URL {
        
        let storageRef = Storage.storage().reference()
        let photosRef = storageRef.child("\(bucket.rawValue)/\(key)")
        
        let _ = try await photosRef.putDataAsync(data)
        let downloadURL = try await photosRef.downloadURL()
        return downloadURL
    }
}
