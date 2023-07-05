//
//  ActorDetailsResponse.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/6/17.
//

import Foundation
import CoreData

// MARK: - ActorDetailsResponse
struct ActorDetailsResponse: Codable {
    let adult: Bool?
    let alsoKnownAs: [String]?
    let biography, birthday: String?
    let deathday: String?
    let gender: Int?
    let homepage: String?
    let id: Int?
    let imdbID, knownForDepartment, name, placeOfBirth: String?
    let popularity: Double?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case alsoKnownAs = "also_known_as"
        case biography, birthday, deathday, gender, homepage, id
        case imdbID = "imdb_id"
        case knownForDepartment = "known_for_department"
        case name
        case placeOfBirth = "place_of_birth"
        case popularity
        case profilePath = "profile_path"
    }
    
    @discardableResult
    func toActorEntity(context: NSManagedObjectContext) -> ActorEntity {
        let entity = ActorEntity(context: context)
        entity.id = Int32(id!)
        entity.adult = adult ?? false
        entity.gender = Int32(gender ?? 0)
        entity.knownForDepartment = knownForDepartment
        entity.alsoKnownAs = alsoKnownAs.map({
            $0
        })?.joined(separator: ",")
        entity.name = name
        entity.popularity = popularity ?? 0.0
        entity.profilePath = profilePath
        entity.biography = biography
        entity.birthday = birthday
        entity.deathday = deathday
        entity.homePage = homepage
        entity.imdbID = imdbID
        entity.placeOfBirth = placeOfBirth
        return entity
    }
}

