//
//  CharacterItem.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import SwiftUI

struct CharacterItem: Identifiable {
    let id: String = UUID().uuidString
    let characterId: String
    let name: String
    let imageUrl: String
}

extension CharacterItem {
    init(character: Character) {
        self.characterId = character.id
        self.imageUrl = character.imageUrl
        self.name = character.name
    }
}

extension CharacterItem: Equatable {}
