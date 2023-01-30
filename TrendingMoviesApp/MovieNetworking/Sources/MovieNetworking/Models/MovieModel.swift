//
//  MovieModel.swift
//  MovieDBAPI
//
//  Created by Igor Czarev on 27.12.2022.
//

import Foundation

let dateDecoder: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter
}()

public struct MovieModel: Decodable {
    public let id: Int
    public let title: String
    public let overview: String
    public let posterPath: String?
    public let backdropPath: String?
    public let releaseDate: Date?
    public let voteAverage: Double
    public let voteCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath
        case backdropPath
        case releaseDate
        case voteAverage
        case voteCount
    }
    
    public init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           id = try container.decode(Int.self, forKey: .id)
           title = try container.decode(String.self, forKey: .title)
           overview = try container.decode(String.self, forKey: .overview)
           posterPath = try? container.decode(String.self, forKey: .posterPath)
           backdropPath = try? container.decode(String.self, forKey: .backdropPath)
           let releaseDateString = try container.decode(String.self, forKey: .releaseDate)
           self.releaseDate = dateDecoder.date(from: releaseDateString)
           voteAverage = try container.decode(Double.self, forKey: .voteAverage)
           voteCount = try container.decode(Int.self, forKey: .voteCount)
       }
}
