//
//  CharacterDetailsUseCase.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import Foundation

protocol CharacterDetailsUseCaseProtocol {
    func getCharacterDetails(with id: String,
                            completion: @escaping (Result<CharacterDetails, AppError>) -> Void)
}

class CharacterDetailsUseCase: CharacterDetailsUseCaseProtocol {
    
    let repository: CharacterRepositoryProtocol

    init(repository: CharacterRepositoryProtocol) {
        self.repository = repository
    }

    func getCharacterDetails(with id: String,
                            completion: @escaping (Result<CharacterDetails, AppError>) -> Void) {
        repository.getCharacterDetails(with: id) { result in
            switch result {
            case .success(let characterDetails):
                completion(.success(characterDetails))
            case .failure(let error):
                let appError = AppError(message: error.message)
                completion(.failure(appError))
            }
        }
    }
}

