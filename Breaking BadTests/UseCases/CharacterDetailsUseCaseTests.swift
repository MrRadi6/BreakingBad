//
//  CharacterDetailsUseCaseTests.swift
//  Breaking BadTests
//
//  Created by Samir on 10/5/22.
//

import XCTest
@testable import Breaking_Bad

final class CharacterDetailsUseCaseTests: XCTestCase {

    var sut: CharacterDetailsUseCase!
    var repository: CharacterRepositoryMock!

    override func setUp() {
        super.setUp()
        repository = CharacterRepositoryMock()
        sut = CharacterDetailsUseCase(repository: repository)
    }

    override func tearDown() {
        repository = nil
        sut = nil
        super.tearDown()
    }

    func test_getCharacterDetailsShouldGetCharacterDetails() {
        // Given
        var returnedCharacters: CharacterDetails?
        repository.error = nil
        let expectation = expectation(description: "wait for async call")
        // When
        sut.getCharacterDetails(with: DataMocks.character.id) { result in
            switch result {
            case .success(let characters):
                returnedCharacters = characters
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(returnedCharacters, DataMocks.characterDetails)
        XCTAssertEqual(repository.getCharacterDetailsCallCount, 1)
    }

    func test_getCharacterDetailsShouldfail() {
        // Given
        var returnedError: AppError?
        repository.error = .unknown
        let expectation = expectation(description: "wait for async call")
        // When
        sut.getCharacterDetails(with: DataMocks.character.id) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                returnedError = error
            }
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(returnedError?.message, BaseError.unknown.message)
        XCTAssertEqual(repository.getCharacterDetailsCallCount, 1)
    }
}
