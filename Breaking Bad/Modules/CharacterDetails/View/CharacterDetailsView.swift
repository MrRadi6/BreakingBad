//
//  CharacterDetailsView.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import SwiftUI

struct CharacterDetailsView: View {

    private let imageHeight: CGFloat = 250

    @StateObject var viewModel: CharacterDetailsViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if let characterDetails = viewModel.characterDetails {
                CharacterImageView(imageURL: characterDetails.imageUrl)
                    .frame(height: imageHeight)
                    .padding()
                CharacterDetailsItemView(title: "character_details_name_title".localized,
                                        description: characterDetails.name)
                    .padding()
                CharacterDetailsItemView(title: "character_details_nickname_title".localized,
                                        description: characterDetails.nickname)
                    .padding()
                Spacer()
            }
        }
        .onAppear {
            viewModel.viewDidAppear()
        }
        .navigationTitle("character_details_title".localized)
        .navigationBarTitleDisplayMode(.large)
    }
}


private struct CharacterImageView: View {
    private let imageCornerRadius: CGFloat = 5
    var imageURL: String?

    var body: some View {
        CharacterImage(imageURL: imageURL)
            .clipShape(RoundedRectangle(cornerRadius: imageCornerRadius))
            .shadow(radius: imageCornerRadius)
    }
}

private struct CharacterDetailsItemView: View {
    let title: String
    let description: String

    var body: some View {
        HStack {
            Text(title)
                .frame(width: 80, alignment: .leading)
                .padding(.trailing, 10)
            Text(description)
            Spacer()
        }
    }
}
