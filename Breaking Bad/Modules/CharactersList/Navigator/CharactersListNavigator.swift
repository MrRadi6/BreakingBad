//
//  CharactersListNavigator.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import SwiftUI

struct CharactersListNavigator {

    static func createModule() -> CharactersListView {
        let remoteAPI = CharacterAPI()
        let repository = CharacterRepository(remote: remoteAPI)
        let useCase = CharactersListUseCase(repository: repository)
        let viewModel = CharactersListViewModel(useCase: useCase)
        let view = CharactersListView(viewModel: viewModel)
        return view
    }
}
