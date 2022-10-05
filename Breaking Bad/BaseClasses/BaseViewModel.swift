//
//  BaseViewModel.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import SwiftUI

class BaseViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false

    var appError: AppError? {
        didSet {
            guard appError != nil else { return }
            showError = true
        }
    }
}
