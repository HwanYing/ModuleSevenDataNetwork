//
//  GenreObject.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/7/7.
//

import Foundation
import RealmSwift

class GenreObject: Object {
    
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var name: String
        
    func toMovieGenre() -> MovieGenre {
        MovieGenre(id: id, name: name)
    }
}
