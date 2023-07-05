//
//  ActorEntityExtensions.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/7/3.
//

import Foundation

extension ActorEntity {
    static func toActorInfoResponse(entity: ActorEntity) -> ActorInfoResponse {
        return ActorInfoResponse(
            adult: entity.adult,
            gender: Int(entity.gender),
            id: Int(entity.id),
            knownFor: [KnownFor(adult: entity.adult, backdropPath: entity.profilePath, genreIDS: [0], id: Int(entity.id), mediaType: MediaType.movie, originalLanguage: "", originalTitle: "", overview: "", posterPath: "", releaseDate: "", title: "", video: true, voteAverage: 0.0, voteCount: 0, firstAirDate: "", name: "", originCountry: [""], originalName: "")],
            knownForDepartment: entity.knownForDepartment,
            name: entity.name,
            popularity: entity.popularity,
            profilePath: entity.profilePath)
    }
    
    static func toMovieCast(entity: ActorEntity) -> MovieCast {
        return MovieCast(
            adult: entity.adult,
            gender: Int(entity.gender),
            id: Int(entity.id),
            knownForDepartment: entity.knownForDepartment,
            name: entity.name,
            originalName: entity.name,
            popularity: entity.popularity,
            profilePath: entity.profilePath,
            castID: Int(entity.id),
            character: "",
            creditID: entity.imdbID,
            order: 0,
            department: entity.birthday,
            job: entity.alsoKnownAs)
    }
}
