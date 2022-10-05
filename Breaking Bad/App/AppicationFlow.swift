//
//  AppicationFlow.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import SwiftUI

struct AppicationFlow {

    func launchApp() -> some View {
        return CharactersListNavigator.createModule()
    }
}
