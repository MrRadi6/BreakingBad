//
//  CharactersListViewModelTests.swift
//  Breaking BadTests
//
//  Created by Samir on 10/5/22.
//

import XCTest
@testable import Breaking_Bad
import Combine

final class CharactersListViewModelTests: XCTestCase {

    var sut: CharactersListViewModel!
    var useCase: CharactersListUseCaseMock!
    var cancelable: Set<AnyCancellable> = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        useCase = CharactersListUseCaseMock()
        sut = CharactersListViewModel(useCase: useCase)
    }

    override func tearDown() {
        useCase = nil
        sut = nil
        super.tearDown()
    }

    func test_reloadCharactersWhenListScreenLoaded_shouldReturnCharacters() {
        // Given
        let expectation = expectation(description: "wait for async call")
        useCase.error = nil
        // When
        sut.reloadCharacters()
        sut.$characters.sink { _ in
            expectation.fulfill()
        }.store(in: &cancelable)
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(sut.characters.count, 1)
        XCTAssertEqual(sut.characters.first?.characterId, DataMocks.character.id)
        XCTAssertEqual(sut.characters.first?.name, DataMocks.character.name)
        XCTAssertEqual(sut.characters.first?.imageUrl, DataMocks.character.imageUrl)
        XCTAssertEqual(useCase.getCharactersCallCount, 2)
    }

    func test_reloadCharactersWhenListScreenLoaded_shouldfail() {
        // Given
        let expectation = expectation(description: "wait for async call")
        let error = AppError(message: "error message")
        useCase.error = error
        // When
        sut.reloadCharacters()
        sut.$showError
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancelable)
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(sut.appError?.message, error.message)
        XCTAssertEqual(useCase.getCharactersCallCount, 2)
    }

    func test_searchCharacterShouldReturnListWhenNameEntered() {
        // Given
        let expectation = expectation(description: "wait for async call")
        useCase.error = nil
        // When
        sut.searchCharacter(name: DataMocks.character.name)
        sut.$filteredCharacters.sink { _ in
            expectation.fulfill()
        }.store(in: &cancelable)
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(sut.filteredCharacters.count, 1)
        XCTAssertEqual(sut.filteredCharacters.first?.characterId, DataMocks.character.id)
        XCTAssertEqual(sut.filteredCharacters.first?.name, DataMocks.character.name)
        XCTAssertEqual(sut.filteredCharacters.first?.imageUrl, DataMocks.character.imageUrl)
        XCTAssertEqual(useCase.searchForCharactersCallCount, 1)
    }

    func test_searchCharacterShouldNotReturnListWhenEmptyNameEntered() {
        // Given
        let expectation = expectation(description: "wait for async call")
        useCase.error = nil
        // When
        sut.searchCharacter(name: "")
        sut.$filteredCharacters.sink { _ in
            expectation.fulfill()
        }.store(in: &cancelable)
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(sut.filteredCharacters.count, 0)
        XCTAssertEqual(useCase.searchForCharactersCallCount, 0)
    }

    func test_searchCharacterShouldFail() {
        // Given
        let expectation = expectation(description: "wait for async call")
        let error = AppError(message: "error message")
        useCase.error = error
        // When
        sut.searchCharacter(name: "Peter")
        sut.$showError
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancelable)
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(sut.appError?.message, error.message)
        XCTAssertEqual(useCase.searchForCharactersCallCount, 1)
    }

    func test_viewWillShowShouldFetchMoreWhenMoreCharactersAvaialbe() {
        // Given
        let expectation = expectation(description: "wait for async call")
        let characters: [CharacterItem] = [.init(character: DataMocks.character2)]
        useCase.error = nil
        useCase.hasMore = true
        sut.characters = characters
        // When
        sut.viewWillShow(item: characters[0])
        sut.$characters.sink { _ in
            expectation.fulfill()
        }.store(in: &cancelable)
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(useCase.getMoreCharactersCallCount, 1)
    }

    func test_viewWillShowShouldFetchMoreWhenNoMoreCharactersAvaialbe() {
        // Given
        let expectation = expectation(description: "wait for async call")
        let characters: [CharacterItem] = [.init(character: DataMocks.character2)]
        useCase.error = nil
        useCase.hasMore = false
        sut.characters = characters
        // When
        sut.viewWillShow(item: characters[0])
        sut.$characters.sink { _ in
            expectation.fulfill()
        }.store(in: &cancelable)
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(useCase.getMoreCharactersCallCount, 0)
    }

    func test_viewWillShowShouldFetchMoreFail() {
        // Given
        let expectation = expectation(description: "wait for async call")
        let characters: [CharacterItem] = [.init(character: DataMocks.character2)]
        let error = AppError(message: "error message")
        useCase.error = error
        useCase.hasMore = true
        sut.characters = characters
        // When
        sut.viewWillShow(item: characters[0])
        sut.$showError
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancelable)
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(sut.appError?.message, error.message)
        XCTAssertEqual(useCase.getMoreCharactersCallCount, 1)
    }
}
