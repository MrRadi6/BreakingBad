//
//  CharacterRepositoryMock.swift
//  Breaking BadTests
//
//  Created by Samir on 10/5/22.
//

import Foundation
@testable import Breaking_Bad

class CharacterRepositoryMock: CharacterRepositoryProtocol {
    var getCharactersCallCount = 0
    var searchForCharactersCallCount = 0
    var getCharacterDetailsCallCount = 0

    var error: BaseError?
    func getCharacters(with page: Int,
                       charactersPerPage: Int,
                       completion: @escaping (Result<[Character], BaseError>) -> Void) {
        getCharactersCallCount += 1
        if let error {
            completion(.failure(error))
        } else {
            completion(.success([DataMocks.character]))
        }
    }

    func searchForCharacters(with name: String,
                             completion: @escaping (Result<[Character], BaseError>) -> Void) {
        searchForCharactersCallCount += 1
        if let error {
            completion(.failure(error))
        } else {
            completion(.success([DataMocks.character]))
        }
    }

    func getCharacterDetails(with id: String,
                             completion: @escaping (Result<CharacterDetails, BaseError>) -> Void) {
        getCharacterDetailsCallCount += 1
        if let error {
            completion(.failure(error))
        } else {
            completion(.success(DataMocks.characterDetails))
        }
    }


}
