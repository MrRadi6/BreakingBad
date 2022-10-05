//
//  LoadingView.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import SwiftUI

struct LoadingView: View {
    @Binding var isLoading: Bool

    var body: some View {
        if isLoading {
            ZStack {
                Color(.displayP3, white: 0, opacity: 0.3)
                ProgressView()
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
