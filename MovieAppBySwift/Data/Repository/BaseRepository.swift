//
//  BaseRepository.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/6/30.
//

import Foundation
import CoreData
import RealmSwift

class BaseRepository: NSObject {
    
    var coreData = CoreDataStack.shared
    
    let realmInstance = MovieDBRealm.shared
    
    override init() {
        super.init()
    }
    
//    func handleCoreDataError(_ anError: Error?) -> String {
//        if let anError = anError, (anError as NSError).domain == "NSCocoaErrorDomain" {
//            let nsError = anError as NSError
//
//            var errors: [AnyObject] = []
//
//
//        }
//    }
}
