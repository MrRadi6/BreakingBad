//
//  DataMocks.swift
//  Breaking BadTests
//
//  Created by Samir on 10/5/22.
//

import Foundation
@testable import Breaking_Bad

enum DataMocks {
    static let character = Character(id: "1", name: "Peter", imageUrl: "google.com/image/peter")
    static let character2 = Character(id: "2", name: "Parker", imageUrl: "google.com/image/parker")
    static let characterDetails = CharacterDetails(name: "peter", nickname: "spidy", imageUrl: "google.com/image/peter")
}
