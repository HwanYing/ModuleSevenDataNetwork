//
//  ContentTypeRepository.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/6/30.
//

import Foundation
import CoreData

protocol ContentTypeRepository {
    func save(name: String) -> BelongsToTypeEntity
    func getMoviesOrSeries(type: MovieSerieGroupType, completion: @escaping ([MovieResult]) -> Void)
    func getBelongsToTypeEntity(type: MovieSerieGroupType) -> BelongsToTypeEntity
}

class ContentTypeRepositoryImpl: BaseRepository, ContentTypeRepository {
   
    static let shared: ContentTypeRepository = ContentTypeRepositoryImpl()
    
    private var contentTypeMap = [String: BelongsToTypeEntity]()
    
    private override init() {
        super.init()
        
        initializeData()
    }
    
    private func initializeData() {
        /// Process Existing Data
        let fetchRequest: NSFetchRequest<BelongsToTypeEntity> = BelongsToTypeEntity.fetchRequest()
        do {
            let dataSource = try self.coreData.context.fetch(fetchRequest)
            
            if dataSource.isEmpty {
                /// Insert initial data
                MovieSerieGroupType.allCases.forEach {
                    save(name: $0.rawValue)
                }
            } else {
                /// Map existing data
                dataSource.forEach {
                    if let key = $0.name {
                        contentTypeMap[key] = $0
                    }
                }
            }
        } catch {
            print(error)
        }
    }
    @discardableResult
    func save(name: String) -> BelongsToTypeEntity {
        let entity = BelongsToTypeEntity(context: coreData.context)
        entity.name = name
        
        contentTypeMap[name] = entity
        
        coreData.saveContext()
        return entity
    }
    
    func getMoviesOrSeries(type: MovieSerieGroupType, completion: @escaping ([MovieResult]) -> Void) {
        if let entity = contentTypeMap[type.rawValue],
           let movies = entity.movies,
           let itemSet = movies as? Set<MovieEntity> {
            completion(Array(itemSet.sorted(by: { (first, second) -> Bool in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let firstDate = dateFormatter.date(from: first.releaseDate ?? "") ?? Date()
                let secondDate = dateFormatter.date(from: second.releaseDate ?? "") ?? Date()
                
                return firstDate.compare(secondDate) == .orderedDescending
            })).map { MovieEntity.toMovieResult(entity: $0) })
        } else {
            completion([MovieResult]())
        }
    }
    
    func getBelongsToTypeEntity(type: MovieSerieGroupType) -> BelongsToTypeEntity {
        if let entity = contentTypeMap[type.rawValue] {
            return entity
        }
        return save(name: type.rawValue)
    }
}
