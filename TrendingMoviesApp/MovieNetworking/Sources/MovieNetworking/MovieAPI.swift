//
//  MovieAPI.swift
//  MovieDBAPI
//
//  Created by Igor Czarev on 26.12.2022.
//

import Foundation

public protocol MovieAPIProtocol {
    func getMoviesList(completion: @escaping (Result<MovieList, Error>) -> Void)
}

public class MovieAPI: MovieAPIProtocol {
    
    private lazy var networkManager: NetworkManager = .shared
    private let authKey: String
    
    let baseURL = "https://api.themoviedb.org/3/"
    
    public init(authKey: String) {
        self.authKey = authKey
    }

    public func getMoviesList(completion: @escaping (Result<MovieList, Error>) -> Void) {
        generateURLAndSendRequest(for: baseURL + Constants.moviesListPath, completion: completion)
    }
    
    public func getMovieDetails(movieId: String, completion: @escaping (Result<MovieModel, Error>) -> Void) {
        generateURLAndSendRequest(for: baseURL + Constants.movieDetailsPath + movieId, completion: completion)
    }
    
    private func generateURLAndSendRequest<T: Decodable>(for link: String, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let url = try generateURL(for: link)
            networkManager.request(fromURL: url, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    private func generateURL(for link: String) throws -> URL {
        guard var url = URL(string: link) else { throw NetworkError.invalidLink }
        url.append(queryItems: [URLQueryItem(name: "api_key", value: authKey)])
        return url
    }
}

struct Constants {
    static let moviesListPath  = "discover/movie"
    static let movieDetailsPath = "movie/"
}
