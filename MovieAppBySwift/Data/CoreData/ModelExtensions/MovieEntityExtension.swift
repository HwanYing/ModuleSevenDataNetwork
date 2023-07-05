//
//  MovieEntityExtension.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/7/1.
//

import Foundation
import CoreData

extension MovieEntity {
    
    static func toMovieResult(entity: MovieEntity) -> MovieResult {
        return MovieResult(
            adult: entity.adult,
            backdropPath: entity.backdropPath,
            genreIDS: entity.genreIDs?.components(separatedBy: ",").compactMap({
                Int($0.trimmingCharacters(in: .whitespaces))
            }),
            id: Int(entity.id),
            originalLanguage: entity.originalLanguage,
            originalName: entity.originalName,
            originalTitle: entity.originalTitle,
            overview: entity.overview,
            popularity: entity.popularity,
            posterPath: entity.posterPath,
            releaseDate: entity.releaseDate,
            firstAirDate: entity.firstAirDate,
            title: entity.title,
            video: entity.video,
            voteAverage: entity.voteAverage,
            voteCount: Int(entity.voteCount))
    }
    
    static func toMovieDetailResponse(entity: MovieEntity) -> MovieDetailsResponse {
        MovieDetailsResponse(
            adult: entity.adult,
            backdropPath: entity.backdropPath,
            belongsToCollection: entity.belongsToCollection.map({
                BelongsToCollection(id: Int($0.id), name: $0.name, posterPath: $0.posterPath, backdropPath: $0.backdropPath)
            }),
            budget: Int(entity.budget),
            genres: Array(entity.genres as! Set<MovieGenre>).map({ genre in
                MovieGenre(id: Int(genre.id), name: genre.name)
            }),
            homepage: entity.homePage,
            id: Int(entity.id),
            imdbID: entity.imdbID,
            originalLanguage: entity.originalLanguage,
            originalTitle: entity.originalTitle,
            overview: entity.overview,
            popularity: entity.popularity,
            posterPath: entity.posterPath,
            productionCompanies: Array(entity.productionCompany as! Set<ProductionCompany>).map({ 
                ProductionCompany(id: Int($0.id ?? 0), logoPath: $0.logoPath, name: $0.name, originCountry: $0.originCountry)
            }),
            productionCountries: Array(entity.productionCountries as! Set<ProductionCountry>).map({
                ProductionCountry(iso3166_1: $0.iso3166_1, name: $0.name)
            }),
            releaseDate: entity.releaseDate, firstAirDate: entity.firstAirDate,
            
            revenue: Int(entity.revenu),
            runtime: Int(entity.runTime),
            spokenLanguages: Array(entity.spokenLanguage as! Set<SpokenLanguage>).map({
                SpokenLanguage(englishName: $0.englishName, iso639_1: $0.iso639_1, name: $0.name)
            }),
            status: entity.status,
            tagline: entity.tagline,
            title: entity.title,
            video: entity.video,
            voteAverage: entity.voteAverage,
            voteCount: Int(entity.voteCount))
    }
}
