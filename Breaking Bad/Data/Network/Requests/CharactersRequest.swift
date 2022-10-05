//
//  CharactersRequest.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import Alamofire

enum CharactersRequest: BaseReqeust {
    case list(offset: Int, characters: Int)
    case search(name: String)
    case details(id: String)

    var method: HTTPMethod {
        switch self {
        case .list, .details, .search:
            return .get
        }
    }

    var path: String {
        switch self {
        case .list, .search:
            return "\(Path.characters)"
        case .details(let id):
            return "\(Path.characters)/\(id)"
        }
    }

    var parameters: Parameters? {
        switch self {
        case .list(let offset, let characters):
            return [Parameter.charactersPerPage: characters, Parameter.offset: offset]
        case .search(let name):
            return [Parameter.name: name]
        case .details:
            return nil
        }
    }
}

// MARK: - Constants
extension CharactersRequest {
    enum Path {
        static let characters = "characters"
    }
    enum Parameter {
        static let name = "name"
        static let offset = "offset"
        static let charactersPerPage = "limit"
    }
}
