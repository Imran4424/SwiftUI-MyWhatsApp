//
//  String+Extensions.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 25/12/23.
//

import Foundation

extension String {
    var isEmptyOrWhiteSpace: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
