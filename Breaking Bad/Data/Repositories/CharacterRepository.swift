//
//  CharacterRepository.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import Foundation

protocol CharacterRepositoryProtocol {
    func getCharacters(with page: Int,
                       charactersPerPage: Int,
                       completion: @escaping (Result<[Character], BaseError>) -> Void)
    func searchForCharacters(with name: String,
                       completion: @escaping (Result<[Character], BaseError>) -> Void)
    func getCharacterDetails(with id: String, completion: @escaping (Result<CharacterDetails, BaseError>) -> Void)
}

struct CharacterRepository: CharacterRepositoryProtocol {
    let remote: CharacterRequester
    
    func getCharacters(with page: Int,
                       charactersPerPage: Int,
                       completion: @escaping (Result<[Character], BaseError>) -> Void) {
        remote.getCharacters(with: page,
                             characterPerPage: charactersPerPage) { result in
            switch result {
            case .success(let charactersDTO):
                let characters = charactersDTO.compactMap({ $0.transferToCharacter() })
                completion(.success(characters))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func searchForCharacters(with name: String, completion: @escaping (Result<[Character], BaseError>) -> Void) {
        remote.searchForCharacters(with: name) { result in
            switch result {
            case .success(let charactersDTO):
                let characters = charactersDTO.compactMap({ $0.transferToCharacter() })
                completion(.success(characters))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getCharacterDetails(with id: String,
                            completion: @escaping (Result<CharacterDetails, BaseError>) -> Void) {
        remote.getCharacterDetails(with: id) { result in
            switch result {
            case .success(let detailsDTO):
                let details = detailsDTO.transferToCharacterDetails()
                completion(.success(details))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
