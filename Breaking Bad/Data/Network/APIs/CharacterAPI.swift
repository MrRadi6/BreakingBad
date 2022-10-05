//
//  CharacterAPI.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import Foundation

struct CharacterAPI: BaseAPI, CharacterRequester {

    func getCharacters(with offset: Int,
                       characterPerPage: Int,
                       completion: @escaping (Result<[CharacterDTO], BaseError>) -> Void) {
        makeRequest(request: CharactersRequest.list(offset: offset, characters: characterPerPage)) {
            (result: Result<[CharacterDTO], BaseError>) in
            switch result {
            case .success(let characters):
                completion(.success(characters))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func searchForCharacters(with name: String,
                             completion: @escaping (Result<[CharacterDTO], BaseError>) -> Void) {
        makeRequest(request: CharactersRequest.search(name: name)) {
            (result: Result<[CharacterDTO], BaseError>) in
            switch result {
            case .success(let characters):
                completion(.success(characters))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getCharacterDetails(with id: String, completion: @escaping (Result<CharacterDetailsDTO, BaseError>) -> Void) {
        makeRequest(request: CharactersRequest.details(id: id)) { (result: Result<[CharacterDetailsDTO],BaseError>) in
            switch result {
            case .success(let characterDetails):
                if let details = characterDetails.first {
                    completion(.success(details))
                } else {
                    completion(.failure(.unknown))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
