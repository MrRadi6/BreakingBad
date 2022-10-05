//
//  CharacterDetailsDTO.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import Foundation

struct CharacterDetailsDTO: Decodable {
    let name: String
    let nickname: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case name
        case nickname
        case image = "img"
    }
}

// MARK: - Transfer to domain
extension CharacterDetailsDTO {
    func transferToCharacterDetails() -> CharacterDetails {
        return CharacterDetails(name: name,
                                nickname: nickname,
                                imageUrl: image)
    }
}
