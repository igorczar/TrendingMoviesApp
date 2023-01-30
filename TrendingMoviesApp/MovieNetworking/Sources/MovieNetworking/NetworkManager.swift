//
//  NetworkManager.swift
//  MovieDBAPI
//
//  Created by Igor Czarev on 27.12.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case invalidStatusCode(Int)
    case invalidLink
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    enum HTTPMethod: String {
        case get
        case post
    }
    
    func request<T: Decodable>(fromURL url: URL, httpMethod: HTTPMethod = .get, completion: @escaping (Result<T, Error>) -> Void) {
        
        let completionOnMain: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
            APIResponseValidator(data: data, response: response, error: error, completion: completionOnMain)
        }
        urlSession.resume()
    }
}
