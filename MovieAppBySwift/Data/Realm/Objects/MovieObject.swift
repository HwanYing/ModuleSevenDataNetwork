//
//  MovieObject.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/7/7.
//

import Foundation
import RealmSwift

class MovieObject: Object {
    
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var adult: Bool?
    
    @Persisted
    var backdropPath: String?
    
    @Persisted
    var budget: Int?
    
    @Persisted
    var firstAirDate: String?
    
    @Persisted
    var genreIDs: String?
    
    @Persisted
    var homePage: String?
    
    @Persisted
    var imdbID: String?
    
    @Persisted
    var lastAirDate: String?
    
    @Persisted
    var originalLanguage: String?
    
    @Persisted
    var originalName: String?
    
    @Persisted
    var originalTitle: String?
    
    @Persisted
    var overview: String?
    
    @Persisted
    var popularity: Double?
    
    @Persisted
    var posterPath: String?
    
    @Persisted
    var releaseDate:String?
    
    @Persisted
    var revenu: Int?
    
    @Persisted
    var runTime: Int?
    
    @Persisted
    var status: String?
    
    @Persisted
    var tagline: String?
    
    @Persisted
    var title: String?
    
    @Persisted
    var video: Bool?
    
    @Persisted
    var voteAverage: Double?
    
    @Persisted
    var voteCount: Int?
    
    @Persisted
    var belongsToCollection: BelongsToCollectionObject?
    
    @Persisted
    var belongsToType: List<BelongsToTypeObject>
    
    @Persisted
    var casts: List<ActorObject>
    
    @Persisted
    var genres: List<GenreObject>
    
    @Persisted
    var productionCompany: List<ProductionCompanyObject>
    
    @Persisted
    var productionCountries: List<ProductionCountryObject>
    
    @Persisted
    var spokenLanguage: List<SpokenLanguageObject>
    
    @Persisted
    var similarMovies: List<MovieObject>
    
    func toMovieResult() -> MovieResult {
        return MovieResult(
            adult: adult,
            backdropPath: backdropPath,
            genreIDS: genreIDs?.components(separatedBy: ",").compactMap({
                Int($0)
            }),
            id: Int(id),
            originalLanguage: originalLanguage,
            originalName: originalName,
            originalTitle: originalTitle,
            overview: overview,
            popularity: popularity,
            posterPath: posterPath,
            releaseDate: releaseDate,
            firstAirDate: firstAirDate,
            title: title,
            video: video,
            voteAverage: voteAverage,
            voteCount: voteCount)
    }
    
    func toMovieDetailResponse() -> MovieDetailsResponse {
        MovieDetailsResponse(
            adult: adult,
            backdropPath: backdropPath,
            belongsToCollection: nil,
            budget: 0,
            genres: genres.map({
                $0.toMovieGenre()
            }),
            homepage: homePage,
            id: Int(id),
            imdbID: "\(String(describing: imdbID))",
            originalLanguage: originalLanguage,
            originalTitle: originalTitle,
            overview: overview,
            popularity: popularity,
            posterPath: posterPath,
            productionCompanies: productionCompany.map({
                $0.toProductionCompany()
            }),
            productionCountries: productionCountries.map({
                $0.toProductionCountry()
            }),
            releaseDate: releaseDate,
            firstAirDate: firstAirDate,
            revenue: revenu,
            runtime: runTime,
            spokenLanguages: spokenLanguage.map({
                $0.toSpokenLanguage()
            }),
            status: status,
            tagline: tagline,
            title: title,
            video: video,
            voteAverage: voteAverage,
            voteCount: voteCount)
    }
}
