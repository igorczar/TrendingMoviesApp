//
//  MovieList.swift
//  MovieDBAPI
//
//  Created by Igor Czarev on 27.12.2022.
//

import Foundation

public struct MovieList: Decodable {
    public let page: Int
    public let results: [MovieModel]
    public let totalPages: Int
    public let totalResults: Int
}
