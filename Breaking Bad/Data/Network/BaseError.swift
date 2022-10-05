//
//  BaseError.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import Foundation

enum BaseError: Error {
    case systemError(message: String)
    case unknown

    var message: String {
        switch self {
        case .systemError(let message):
            return message
        case .unknown:
            return "global_unkown_network_error".localized
        }
    }
}
