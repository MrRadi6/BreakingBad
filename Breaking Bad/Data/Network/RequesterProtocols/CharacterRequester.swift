//
//  CharacterRequester.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import Foundation

protocol CharacterRequester {
    func getCharacters(with offset: Int,
                       characterPerPage: Int,
                       completion: @escaping (Result<[CharacterDTO], BaseError>) -> Void)
    func searchForCharacters(with name: String,
                       completion: @escaping (Result<[CharacterDTO], BaseError>) -> Void)
    func getCharacterDetails(with id: String, completion: @escaping (Result<CharacterDetailsDTO, BaseError>) -> Void)
}
