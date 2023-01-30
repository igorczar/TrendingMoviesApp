//
//  APIResponseValidator.swift
//  MovieDBAPI
//
//  Created by Igor Czarev on 27.12.2022.
//

import Foundation

func APIResponseValidator<T: Decodable>(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<T, Error>) -> Void) {
    if let error = error {
        completion(.failure(error))
        return
    }
    guard let urlResponse = response as? HTTPURLResponse else { return completion(.failure(NetworkError.invalidResponse)) }
    if !(200..<300).contains(urlResponse.statusCode) {
        return completion(.failure(NetworkError.invalidStatusCode(urlResponse.statusCode)))
    }
    
    guard let data = data else { return }
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let model = try decoder.decode(T.self, from: data)
        completion(.success(model))
    } catch {
        completion(.failure(error))
    }
}
