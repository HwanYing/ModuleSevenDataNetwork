//
//  TVCreditsResponse.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/6/17.
//

import Foundation

// MARK: - TVCreditsResponse
struct TVCreditsResponse: Codable {
    let cast: [TVCast]?
    let crew: [TVCast]?
    let id: Int?
}

// MARK: - Cast
struct TVCast: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originCountry: [String]?
    let originalLanguage, originalName, overview: String?
    let popularity: Double?
    let posterPath, firstAirDate, name: String?
    let voteAverage: Double?
    let voteCount: Int?
    let character, creditID: String?
    let episodeCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case name
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case character
        case creditID = "credit_id"
        case episodeCount = "episode_count"
    }
}
