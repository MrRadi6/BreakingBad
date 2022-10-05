//
//  CharactersListUseCaseMock.swift
//  Breaking BadTests
//
//  Created by Samir on 10/5/22.
//

import Foundation
@testable import Breaking_Bad

class CharactersListUseCaseMock: CharactersListUseCaseProtocol {

    var getCharactersCallCount = 0
    var searchForCharactersCallCount = 0
    var getMoreCharactersCallCount = 0
    var canGetMoreCharactersCallCount = 0
    var hasMore = false
    var error: AppError?

    func getCharacters(completion: @escaping (Result<[Character], AppError>) -> Void) {
        getCharactersCallCount += 1
        if let error {
            completion(.failure(error))
        } else {
            completion(.success([DataMocks.character]))
        }
    }

    func searchForCharacters(with name: String, completion: @escaping (Result<[Character], AppError>) -> Void) {
        searchForCharactersCallCount += 1
        if let error {
            completion(.failure(error))
        } else {
            completion(.success([DataMocks.character]))
        }
    }

    func getMoreCharacters(completion: @escaping (Result<[Character], AppError>) -> Void) {
        getMoreCharactersCallCount += 1
        if let error {
            completion(.failure(error))
        } else {
            completion(.success([DataMocks.character]))
        }
    }

    func canGetMoreCharacters() -> Bool {
        canGetMoreCharactersCallCount += 1
        return hasMore
    }
}
