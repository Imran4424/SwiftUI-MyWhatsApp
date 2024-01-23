//
//  UIImagePickerController+Extensions.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 23/1/24.
//

import Foundation
import UIKit

extension UIImagePickerController.SourceType: Identifiable {
    public var id: Int {
        switch self {
        case .photoLibrary:
            return 2
        case .camera:
            return 1
        case .savedPhotosAlbum:
            return 3
        @unknown default:
            return 4
        }
    }
}
