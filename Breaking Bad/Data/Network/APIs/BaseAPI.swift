//
//  BaseAPI.swift
//  Breaking Bad
//
//  Created by Samir on 10/5/22.
//

import Alamofire

protocol BaseAPI {
    func makeRequest<T: Decodable>(request: URLRequestConvertible,
                                   completion: @escaping (Result<T, BaseError>) -> Void)
}

extension BaseAPI {
    func makeRequest<T: Decodable>(request: URLRequestConvertible,
                                   completion: @escaping (Result<T, BaseError>) -> Void) {

        alamofireRequest(request: request) { (response: DataResponse<T, AFError>) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                dLog(error)
                completion(.failure(.unknown))
            }
        }
    }
}

extension BaseAPI {
    private func alamofireRequest<T: Decodable>(request: URLRequestConvertible,
                                                completion: @escaping (DataResponse<T, AFError>) -> Void) {
        AF.request(request)
            .validate()
            .validate(contentType: [Network.ContentType.json])
            .responseDecodable(of: T.self) { response in
                if let requestURL = response.request?.url?.absoluteString {
                    dLog("Request - \(requestURL)")
                }
                completion(response)
            }
    }
}

