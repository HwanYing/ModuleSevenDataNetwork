//
//  SpokenLanguageObject.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/7/7.
//

import Foundation
import RealmSwift

class SpokenLanguageObject: Object {
    
    @Persisted(primaryKey: true)
    var name: String?
    
    @Persisted
    var iso639_1: String?
    
    @Persisted
    var englishName: String?
    
    func toSpokenLanguage() -> SpokenLanguage {
        SpokenLanguage(englishName: englishName, iso639_1: iso639_1, name: name)
    }
}
