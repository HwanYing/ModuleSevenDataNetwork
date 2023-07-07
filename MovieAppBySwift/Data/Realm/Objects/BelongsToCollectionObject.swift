//
//  BelongsToCollectionObject.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/7/7.
//

import Foundation
import RealmSwift

class BelongsToCollectionObject: Object {
    
    @Persisted(primaryKey: true)
    var id: Int
    
    
    @Persisted
    var name: String?
    
    @Persisted
    var posterPath: String?
    
    @Persisted
    var backdropPath: String?
    
    func toBelongsToCollection() -> BelongsToCollection {
        BelongsToCollection(id: id,
                            name: name,
                            posterPath: posterPath,
                            backdropPath: backdropPath)
    }
}
