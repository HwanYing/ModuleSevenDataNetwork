//
//  ProductionCompanyObject.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/7/7.
//

import Foundation
import RealmSwift

class ProductionCompanyObject: Object {
    
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var logoPath: String?
    
    @Persisted
    var name: String?
    
    @Persisted
    var originalCountry: String?
    
    func toProductionCompany() -> ProductionCompany {
        ProductionCompany(id: id, logoPath: logoPath, name: name, originCountry: originalCountry)
    }
}
