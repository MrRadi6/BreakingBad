//
//  CharacterDetailsViewModelTests.swift
//  Breaking BadTests
//
//  Created by Samir on 10/5/22.
//

import XCTest
@testable import Breaking_Bad
import Combine

final class CharacterDetailsViewModelTests: XCTestCase {

    var sut: CharacterDetailsViewModel!
    var useCase: CharacterDetailsUseCaseMock!
    var cancelable: Set<AnyCancellable> = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        useCase = CharacterDetailsUseCaseMock()
        sut = CharacterDetailsViewModel(useCase: useCase)
    }

    override func tearDown() {
        useCase = nil
        sut = nil
        super.tearDown()
    }

    func test_viewDidAppearShouldGetCharacterDetails() {
        // Given
        let character = DataMocks.characterDetails
        let expectation = XCTestExpectation(description: "wait for async call")
        let characterId = "1"
        sut.characterId = characterId
        useCase.error = nil
        // When
        sut.viewDidAppear()
        sut.$characterDetails.sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancelable)
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(character.name, sut.characterDetails?.name)
        XCTAssertEqual(character.nickname, sut.characterDetails?.nickname)
        XCTAssertEqual(character.imageUrl, sut.characterDetails?.imageUrl)
        XCTAssertEqual(useCase.getCharacterDetailsCallCount, 1)
    }

    func test_viewDidAppearShouldFail() {
        // Given
        let expectation = XCTestExpectation(description: "wait for async call")
        let characterId = "1"
        let error = AppError(message: "error message")
        useCase.error = error
        sut.characterId = characterId
        // When
        sut.viewDidAppear()
        sut.$showError
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancelable)
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(sut.appError?.message, error.message)
        XCTAssertEqual(useCase.getCharacterDetailsCallCount, 1)
    }
}
