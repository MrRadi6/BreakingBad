//
//  CharacterImage.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import SwiftUI
import Kingfisher

struct CharacterImage: View {
    var imageURL: String?
    
    var body: some View {
        if let imageURL = imageURL {
            KFImage.url(URL(string: imageURL))
                .onFailureImage(.characterPlaceholder)
                .processingQueue(.dispatch(.global()))
                .cacheMemoryOnly()
                .fade(duration: 0.3)
                .cacheMemoryOnly()
                .resizable()
        } else {
            Image.characterPlaceholder
                .resizable()
        }
    }
}
