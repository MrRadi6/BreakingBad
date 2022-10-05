//
//  CharactersListView.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import SwiftUI

struct CharactersListView: View {
    @StateObject var viewModel: CharactersListViewModel
    @State private var name = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("characters_list_View_character_search".localized, text: $name)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .onChange(of: name) { newValue in
                        viewModel.searchCharacter(name: newValue)
                    }
                if !viewModel.filteredCharacters.isEmpty {
                    CharactersSearchList(viewModel: viewModel)
                } else {
                    CharactersList(viewModel: viewModel)
                }
                if viewModel.showPageLoader {
                    LoadMoreCharacters()
                }
            }
            .alert(viewModel.appError?.title ?? "",
                   isPresented: $viewModel.showError,
                   actions: {
                Button("global_ok_action".localized, role: .cancel) {}
            },message: {
                Text(viewModel.appError?.message ?? "")
            })
            .navigationTitle("characters_list_View_characters_title".localized)
            .navigationBarTitleDisplayMode(.large)
            .overlay(content: {
                LoadingView(isLoading: $viewModel.isLoading)
            })
        }
    }
}

// MARK: - Characters List View
private struct CharactersList: View {
    @ObservedObject var viewModel: CharactersListViewModel

    var body: some View {
        List(viewModel.characters) { character in
            NavigationLink {
                CharacterDetailsNavigator.createModule(with: character.characterId)
            } label: {
                CharacterItemView(character: character)
            }
            .onAppear {
                viewModel.viewWillShow(item: character)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .refreshable {
            viewModel.reloadCharacters()
        }
    }
}

// MARK: - Characters Search List View
private struct CharactersSearchList: View {
    @ObservedObject var viewModel: CharactersListViewModel

    var body: some View {
        List(viewModel.filteredCharacters) { character in
            NavigationLink {
                CharacterDetailsNavigator.createModule(with: character.characterId)
            } label: {
                CharacterItemView(character: character)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

// MARK: - Load more Characters View
private struct LoadMoreCharacters: View {
    var body: some View {
        HStack {
            Spacer()
            ProgressView("characters_list_loading_more_characters".localized)
            Spacer()
        }
    }
}
