//
//  CharacterDetailsNavigator.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import SwiftUI

struct CharacterDetailsNavigator {
    static func createModule(with id: String) -> CharacterDetailsView {
        let api = CharacterAPI()
        let repository = CharacterRepository(remote: api)
        let useCase = CharacterDetailsUseCase(repository: repository)
        let viewModel = CharacterDetailsViewModel(useCase: useCase)
        let view = CharacterDetailsView(viewModel: viewModel)
        viewModel.characterId = id
        return view
    }
}
