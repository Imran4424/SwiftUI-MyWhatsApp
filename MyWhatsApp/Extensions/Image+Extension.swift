//
//  Image+Extension.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 15/1/24.
//

import Foundation
import SwiftUI

extension Image {
    func rounded(width: CGFloat = 100, height: CGFloat = 100) -> some View {
        return self.resizable()
            .frame(width: width, height: height)
            .clipShape(Circle())
    }
}
