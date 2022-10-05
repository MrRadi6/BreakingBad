//
//  CharacterDetailsViewModel.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import SwiftUI

protocol CharacterDetailsViewModelProtocol {
    func viewDidAppear()
}

class CharacterDetailsViewModel: BaseViewModel {

    private let useCase: CharacterDetailsUseCaseProtocol

    @Published var characterDetails: CharacterDetailsItem? = nil
    var characterId: String?

    init(useCase: CharacterDetailsUseCaseProtocol) {
        self.useCase = useCase
    }
}

// MARK: - Conforming to CharacterDetailsViewModelProtocol
extension CharacterDetailsViewModel: CharacterDetailsViewModelProtocol {
    func viewDidAppear() {
        guard let characterId else { return }
        isLoading = true
        
        useCase.getCharacterDetails(with: characterId) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let characterDetails):
                self.characterDetails = CharacterDetailsItem(character: characterDetails)
            case .failure(let error):
                self.appError = error
            }
        }
    }
}
