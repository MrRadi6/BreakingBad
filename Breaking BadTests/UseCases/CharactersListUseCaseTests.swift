//
//  CharactersListUseCaseTests.swift
//  Breaking BadTests
//
//  Created by Samir on 10/5/22.
//

import XCTest
@testable import Breaking_Bad

final class CharactersListUseCaseTests: XCTestCase {

    var sut: CharactersListUseCase!
    var repository: CharacterRepositoryMock!

    override func setUp() {
        super.setUp()
        repository = CharacterRepositoryMock()
        sut = CharactersListUseCase(repository: repository)
    }

    override func tearDown() {
        repository = nil
        sut = nil
        super.tearDown()
    }

    func test_getCharactersShouldGetListOfCharacters() {
        // Given
        var returnedCharacters: [Character]?
        repository.error = nil
        let expectation = expectation(description: "wait for async call")
        // When
        sut.getCharacters { result in
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
        XCTAssertEqual(returnedCharacters?.count, 1)
        XCTAssertEqual(repository.getCharactersCallCount, 1)
    }

    func test_getCharactersShouldfail() {
        // Given
        var returnedError: AppError?
        repository.error = .unknown
        let expectation = expectation(description: "wait for async call")
        // When
        sut.getCharacters { result in
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
        XCTAssertEqual(repository.getCharactersCallCount, 1)
    }

    func test_searchForCharactersShouldGetListOfCharacters() {
        // Given
        var returnedCharacters: [Character]?
        repository.error = nil
        let expectation = expectation(description: "wait for async call")
        // When
        sut.searchForCharacters(with: "Peter") { result in
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
        XCTAssertEqual(returnedCharacters?.count, 1)
        XCTAssertEqual(repository.searchForCharactersCallCount, 1)
    }

    func test_searchForCharactersShouldfail() {
        // Given
        var returnedError: AppError?
        repository.error = .unknown
        let expectation = expectation(description: "wait for async call")
        // When
        sut.searchForCharacters(with: "Peter") { result in
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
        XCTAssertEqual(repository.searchForCharactersCallCount, 1)
    }

    func test_getMoreCharactersShouldGetListOfCharacters() {
        // Given
        var returnedCharacters: [Character]?
        repository.error = nil
        let expectation = expectation(description: "wait for async call")
        // When
        sut.getMoreCharacters { result in
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
        XCTAssertEqual(returnedCharacters?.count, 1)
        XCTAssertEqual(repository.getCharactersCallCount, 1)
    }

    func test_getMoreCharactersShouldfail() {
        // Given
        var returnedError: AppError?
        repository.error = .unknown
        let expectation = expectation(description: "wait for async call")
        // When
        sut.getMoreCharacters { result in
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
        XCTAssertEqual(repository.getCharactersCallCount, 1)
    }

    func test_canGetMoreCharactersShouldReturnTrueWhenNoCharactersLoadedYet() {
        // When
        let canGetMore = sut.canGetMoreCharacters()
        // Then
        XCTAssertTrue(canGetMore)
    }

    func test_canGetMoreCharactersShouldReturnFalseWhenReturnCharactersLessThan10Characters() {
        // Given
        let expectation = expectation(description: "wait for async call")
        repository.error = nil
        // When
        sut.getCharacters { _ in
            expectation.fulfill()
        }
        let canGetMore = sut.canGetMoreCharacters()
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertFalse(canGetMore)
    }
}
