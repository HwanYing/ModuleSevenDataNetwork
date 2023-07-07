//
//  BelongToTypeObject.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/7/7.
//

import Foundation
import RealmSwift

class BelongsToTypeObject: Object {
    
    @Persisted(primaryKey: true)
    var name: String
    
    @Persisted(originProperty: "belongsToType")
    var movies: LinkingObjects<MovieObject>
}
