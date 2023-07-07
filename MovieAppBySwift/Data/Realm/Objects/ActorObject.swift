//
//  ActorObject.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/7/7.
//

import Foundation
import RealmSwift

class ActorObject: Object {
    
    @Persisted
    var id: Int
    
    @Persisted
    var adult: Bool?
    
    @Persisted
    var alsoKnownAs: String?
    
    @Persisted
    var biography: String?
    
    @Persisted
    var birthday: String?
    
    @Persisted
    var deathday: String?
    
    @Persisted
    var gender: Int?
    
    @Persisted
    var homePage: String
    
    @Persisted
    var imdbID: String?
    
    @Persisted
    var insertedAt: Date?
    
    @Persisted
    var knownForDepartment: String?
    
    @Persisted
    var name: String?
    
    @Persisted
    var placeOfBirth: String?
    
    @Persisted
    var popularity: Double?
    
    @Persisted
    var profilePath: String?
    
}
