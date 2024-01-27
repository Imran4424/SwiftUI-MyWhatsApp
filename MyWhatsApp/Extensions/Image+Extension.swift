//
//  Image+Extension.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 15/1/24.
//

import Foundation
import SwiftUI
import UIKit

extension Image {
    func rounded(width: CGFloat = 100, height: CGFloat = 100) -> some View {
        return self.resizable()
            .frame(width: width, height: height)
            .clipShape(Circle())
    }
}

extension UIImage {
    // source - StackOverflow
    func resize(to size: CGSize = CGSize(width: 300, height: 300)) -> UIImage? {
        let widthRatio = size.width / size.width
        let heightRatio = size.height / size.height
        
        var newSize: CGSize
        
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        let rect = CGRect(origin: .zero, size: newSize)
        
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
//        self.draw(in: rect)
//        let newImage = UIGraphicsGetImageFromCurrentImageContext
//        UIGraphicsEndImageContext()
        
        let format = UIGraphicsImageRendererFormat.default()
        format.opaque = false
        format.scale = 1.0
        let imageRenderer = UIGraphicsImageRenderer(size: newSize, format: format)
        let newImg = imageRenderer.image { _ in
            draw(in: rect)
        }
        
        return newImg
    }
}
