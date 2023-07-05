//
//  ActorRepository.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/6/30.
//

import Foundation
import CoreData

protocol ActorRepository {
    func getList(page: Int, type: ActorGroupType, completion: @escaping ([ActorInfoResponse]) -> Void)
    func save(list: [ActorInfoResponse])
    func saveDetails(data: ActorDetailsResponse)
    func getDetails(id: Int, completion: @escaping (ActorDetailsResponse?) -> Void)
    func getTotalPageActorList(completiion: @escaping (Int) -> Void)
}

class ActorRepositoryImpl: BaseRepository, ActorRepository {
    
    static let shared: ActorRepository = ActorRepositoryImpl()
    
    private override init() { }
    
    let contentTypeRepo: ContentTypeRepository = ContentTypeRepositoryImpl.shared
    var pageSize: Int = 20

    func save(list: [ActorInfoResponse]) {
        list.forEach {
            let _ = $0.toActorEntity(context: coreData.context, contentTypeRepo: contentTypeRepo)
        }
        self.coreData.saveContext()
    }
    
    func saveDetails(data: ActorDetailsResponse) {
        let _ = data.toActorEntity(context: coreData.context)
        coreData.saveContext()
    }
    
    func getDetails(id: Int, completion: @escaping (ActorDetailsResponse?) -> Void) {
        
    }
    
    func getTotalPageActorList(completiion: @escaping (Int) -> Void) {
        
    }
    
    func getList(page: Int, type: ActorGroupType, completion: @escaping ([ActorInfoResponse]) -> Void) {
        
        let fetchRequest: NSFetchRequest<ActorEntity> = ActorEntity.fetchRequest()
        fetchRequest.sortDescriptors = [
        NSSortDescriptor(key: "insertedAt", ascending: false),
        NSSortDescriptor(key: "popularity", ascending: false),
        NSSortDescriptor(key: "name", ascending: true),
        ]
        
        fetchRequest.fetchLimit = pageSize
        fetchRequest.fetchOffset = (pageSize * page) - pageSize
        
        do {
            let items = try coreData.context.fetch(fetchRequest)
            completion(items.map({ ActorEntity.toActorInfoResponse(entity: $0)
            }))
        } catch {
            print("\(#function) \(error.localizedDescription)")
            completion([ActorInfoResponse]())
        }
    }
}
