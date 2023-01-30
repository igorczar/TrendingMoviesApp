//
//  MoviesRepo.swift
//  TrendingMoviesApp
//
//  Created by Igor Czarev on 27.12.2022.
//

import MovieNetworking
import UIKit

protocol MoviesRepoProtocol {
    func numberOfItems() -> Int
    func model(for indexPath: IndexPath) -> MovieModel?
    func fetchMoviesList()
    func fetchMovieDetails(with movieId: String, completion: @escaping (Result<MovieModel, Error>) -> Void)
}

final class MoviesRepo: MoviesRepoProtocol {
    private let api = MovieAPI(authKey: "c9856d0cb57c3f14bf75bdc6c063b8f3")
    var onError: ((Error) -> Void)?
    var onSuccess: (() -> Void)?
    private var list: MovieList?
    
    func fetchMoviesList() {
        api.getMoviesList { [weak self] result in
            switch result {
            case .failure(let error):
                self?.onError?(error)
            case .success(let list):
                self?.list = list
                self?.onSuccess?()
            }
        }
    }
    
    func fetchMovieDetails(with movieId: String, completion: @escaping (Result<MovieModel, Error>) -> Void) {
        api.getMovieDetails(movieId: movieId, completion: completion)
    }
    
    func numberOfItems() -> Int {
        return list?.results.count ?? 0
    }
    
    func model(for indexPath: IndexPath) -> MovieModel? {
        return list?.results[indexPath.row]
    }
}
