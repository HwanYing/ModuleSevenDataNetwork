//
//  BaseRepository.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/6/30.
//

import Foundation
import CoreData

class BaseRepository: NSObject {
    
    override init() {
        super.init()
    }
    
    var coreData = CoreDataStack.shared
    
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
