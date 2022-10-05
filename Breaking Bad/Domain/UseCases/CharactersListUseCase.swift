//
//  CharactersListUseCase.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import Foundation

protocol CharactersListUseCaseProtocol {
    func getCharacters(completion: @escaping (Result<[Character], AppError>) -> Void)
    func searchForCharacters(with name: String, completion: @escaping (Result<[Character], AppError>) -> Void)
    func getMoreCharacters(completion: @escaping (Result<[Character], AppError>) -> Void)
    func canGetMoreCharacters() -> Bool
}

class CharactersListUseCase: CharactersListUseCaseProtocol {

    private let pageSize = 10
    private var offset: Int = 0
    private var hasMore = true

    let repository: CharacterRepositoryProtocol

    init(repository: CharacterRepositoryProtocol) {
        self.repository = repository
    }
    
    func getCharacters(completion: @escaping (Result<[Character], AppError>) -> Void) {
        offset = 0
        repository.getCharacters(with: offset, charactersPerPage: pageSize) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let characters):
                self.hasMore = characters.count == self.pageSize
                completion(.success(characters))
            case .failure(let error):
                let appError = AppError(message: error.message)
                completion(.failure(appError))
            }
        }
    }

    func searchForCharacters(with name: String, completion: @escaping (Result<[Character], AppError>) -> Void) {
        repository.searchForCharacters(with: name) { result in
            switch result {
            case .success(let characters):
                completion(.success(characters))
            case .failure(let error):
                let appError = AppError(message: error.message)
                completion(.failure(appError))
            }
        }
    }

    func getMoreCharacters(completion: @escaping (Result<[Character], AppError>) -> Void) {
        offset += pageSize
        repository.getCharacters(with: offset, charactersPerPage: pageSize) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let characters):
                self.hasMore = characters.count == self.pageSize
                completion(.success(characters))
            case .failure(let error):
                let appError = AppError(message: error.message)
                completion(.failure(appError))
            }
        }
    }

    func canGetMoreCharacters() -> Bool {
        return hasMore
    }
}
