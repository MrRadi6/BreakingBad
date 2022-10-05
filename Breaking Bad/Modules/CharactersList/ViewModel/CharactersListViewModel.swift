//
//  CharactersListViewModel.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import SwiftUI
import Combine

protocol CharactersListViewModelProtocol: BaseViewModel {
    func reloadCharacters()
    func searchCharacter(name: String)
    func viewWillShow(item: CharacterItem)
}

class CharactersListViewModel: BaseViewModel {

    private let useCase: CharactersListUseCaseProtocol
    private var subscription: Set<AnyCancellable> = []

    @Published var characters: [CharacterItem] = []
    @Published var filteredCharacters: [CharacterItem] = []
    @Published var showPageLoader: Bool = false

    init(useCase: CharactersListUseCaseProtocol) {
        self.useCase = useCase
        super.init()
        getCharacters(name: nil, showLoading: true)
    }

    private func getCharacters(name: String?, showLoading: Bool) {
        isLoading = true && showLoading
        useCase.getCharacters() { [weak self] result in
            guard let self else { return }
            self.isLoading = false
            switch result {
            case .success(let characters):
                self.appError = nil
                self.characters = characters.map({ CharacterItem(character: $0)})
                self.filteredCharacters = []
            case .failure(let error):
                self.appError = error
            }
        }
    }
}

// MARK: - Conforming to CharactersListViewModelProtocol
extension CharactersListViewModel: CharactersListViewModelProtocol {
    
    func reloadCharacters() {
        getCharacters(name: nil, showLoading: false)
    }

    func searchCharacter(name: String) {
        guard !name.isEmpty else {
            reloadCharacters()
            return
        }
        useCase.searchForCharacters(with: name) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let characters):
                self.appError = nil
                self.filteredCharacters = characters.map({ CharacterItem(character: $0)})
            case .failure(let error):
                self.appError = error
            }
        }
    }

    func viewWillShow(item: CharacterItem) {
        guard item == characters.last else { return }
        guard useCase.canGetMoreCharacters() else { return }
        showPageLoader = true
        useCase.getMoreCharacters() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let characters):
                let characterItems = characters.map({ CharacterItem(character: $0)})
                self.showPageLoader = false
                self.characters.append(contentsOf: characterItems)
            case .failure(let error):
                self.appError = error
            }
        }
    }
}
