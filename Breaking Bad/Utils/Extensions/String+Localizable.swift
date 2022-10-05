//
//  String+Localizable.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
