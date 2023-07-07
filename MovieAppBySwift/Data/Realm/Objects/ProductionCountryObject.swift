//
//  ProductionCountryObject.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/7/7.
//

import Foundation
import RealmSwift

class ProductionCountryObject: Object {
    
    @Persisted
    var iso3166_1: String?
    
    @Persisted(primaryKey: true)
    var name: String?
        
    func toProductionCountry() -> ProductionCountry {
        ProductionCountry(iso3166_1: iso3166_1, name: name)
    }
}

