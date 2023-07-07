//
//  MovieActorResponse.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/6/7.
//

import Foundation
import CoreData

// MARK: - MovieActorResponse
struct MovieActorResponse: Codable {
    let id: Int?
    let cast, crew: [MovieCast]?
    let totalPages, totalResults: Int?
}
// MARK: - Cast
struct MovieCast: Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment: String?
    let name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character, creditID: String?
    let order: Int?
    let department: String?
    let job: String?
    
    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
    
    @discardableResult
    func toActorEntity(context: NSManagedObjectContext, movieId: Int, groupType: BelongsToTypeEntity) -> ActorEntity {
        let entity = ActorEntity(context: context)
        entity.id = Int32(id!)
        entity.name = name
        entity.profilePath = profilePath
        entity.imdbID = "\(String(describing: castID))"
        entity.popularity = popularity ?? 0.0
        entity.knownForDepartment = knownForDepartment
        entity.adult = adult!
        entity.gender = Int32(gender!)
    
        return entity
    }
}
