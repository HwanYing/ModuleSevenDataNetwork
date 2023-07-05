//
//  UpcomingMovieList.swift
//  DataAndNetworkLayer
//
//  Created by 梁世仪 on 2023/6/5.
//

import Foundation

// MARK: - UpcomingMovieList
struct UpcomingMovieList: Codable {
    let dates: Dates?
    let page: Int?
    let results: [MovieResult]?
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    func convertToMovieListResult() -> MovieListResult {
        return MovieListResult(page: page, results: results, totalPages: totalPages, totalResults: totalResults)
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String?
}

