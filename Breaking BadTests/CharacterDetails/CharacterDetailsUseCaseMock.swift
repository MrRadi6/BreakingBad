//
//  CharacterDetailsUseCaseMock.swift
//  Breaking BadTests
//
//  Created by Samir on 10/5/22.
//

import Foundation
@testable import Breaking_Bad

class CharacterDetailsUseCaseMock: CharacterDetailsUseCaseProtocol {
    var getCharacterDetailsCallCount = 0
    var error: AppError?

    func getCharacterDetails(with id: String, completion: @escaping (Result<CharacterDetails, AppError>) -> Void) {
        getCharacterDetailsCallCount += 1
        if let error {
            completion(.failure(error))
        } else {
            completion(.success(DataMocks.characterDetails))
        }
    }
}
