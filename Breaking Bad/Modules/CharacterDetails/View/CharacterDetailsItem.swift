//
//  CharacterDetailsItem.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import Foundation

struct CharacterDetailsItem {
    let name: String
    let nickname: String
    var imageUrl: String?
}

extension CharacterDetailsItem {
    init(character: CharacterDetails) {
        self.name = character.name
        self.nickname = character.nickname
        self.imageUrl = character.imageUrl
    }
}
