//
//  CharacterDTO.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import Foundation

struct CharacterDTO: Decodable {
    let id: Int
    let name: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case id = "char_id"
        case name
        case image = "img"
    }
}

// MARK: - Transfer to domain
extension CharacterDTO {
    func transferToCharacter() -> Character {
        return Character(id: String(id),
                        name: name,
                        imageUrl: image)
    }
}

