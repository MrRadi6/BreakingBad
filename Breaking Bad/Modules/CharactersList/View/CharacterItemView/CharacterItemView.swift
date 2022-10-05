//
//  CharacterItemView.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import SwiftUI

struct CharacterItemView: View {
    private let imageCornerRadius: CGFloat = 5
    let character: CharacterItem

    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            CharacterImage(imageURL: character.imageUrl)
                .frame(width: 60, height: 60)
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: imageCornerRadius))
                .padding(.trailing, 5)
            Text(character.name)
                .fontWeight(.regular)
                .lineLimit(1)
            Spacer()
        }
    }
}
