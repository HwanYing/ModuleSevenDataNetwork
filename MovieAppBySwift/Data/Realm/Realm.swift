//
//  Realm.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/7/7.
//

import Foundation
import RealmSwift

class MovieDBRealm: NSObject {
    
    static let shared = try! Realm()
    
}
