//
//  MovieRepository.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/6/30.
//

import Foundation
import CoreData

protocol MovieRepository {
    func getDetail(id: Int, completion: @escaping (MovieDetailsResponse?) -> Void)
    func saveDetail(data: MovieDetailsResponse)
    func saveList(type: MovieSerieGroupType, data: MovieListResult)
    func saveSimilarContent(id: Int, data: [MovieResult])
    func getSimilarContent(id: Int, completion: @escaping ([MovieResult]) -> Void)
    func saveCasts(id: Int, data: [MovieCast])
    func getCasts(id: Int, completion: @escaping ([MovieCast]) -> Void)
}

class MovieRepositoryImpl: BaseRepository, MovieRepository {
    
    static let shared: MovieRepository = MovieRepositoryImpl()
    
    private override init() { }
    
        private var contentTypeMap = [String: BelongsToTypeEntity]()
        let contentTypeRepo: ContentTypeRepository = ContentTypeRepositoryImpl.shared
    
    func getDetail(id: Int, completion: @escaping (MovieDetailsResponse?) -> Void) {
        let fetchRequest : NSFetchRequest<MovieEntity> = getMovieFetchRequestById(id)
        
        if let items = try? coreData.context.fetch(fetchRequest),
           let firstItem = items.first {
            completion(MovieEntity.toMovieDetailResponse(entity: firstItem))
        } else {
            completion(nil)
        }
    }
    
    func saveDetail(data: MovieDetailsResponse) {
        
        let _ = data.toMovieEntity(context: coreData.context)
        coreData.saveContext()
    }
    
    func saveSimilarContent(id: Int, data: [MovieResult]) {
        
    }
    
    func getSimilarContent(id: Int, completion: @escaping ([MovieResult]) -> Void) {
        
    }
    
    func saveCasts(id: Int, data: [MovieCast]) {
//        data.forEach {
//            $0.toMovieEntity(context: self.coreData.context, movieId: id, groupType: contentTypeRepo.getBelongsToTypeEntity(type: .actorCredits))
//        }
//        self.coreData.saveContext()
    }
    
    func getCasts(id: Int, completion: @escaping ([MovieCast]) -> Void) {
        let fetchRequest: NSFetchRequest<ActorEntity> = getMovieCastsFetchRequestByID(id)
        let items = try? coreData.context.fetch(fetchRequest)
        items?.forEach({ entity in
            var movieCasts : [MovieCast] = []
            movieCasts.append(ActorEntity.toMovieCast(entity: entity))
            completion(movieCasts)
        })
        
    }
    
    func saveList(type: MovieSerieGroupType, data: MovieListResult) {
        
        data.results?.forEach({
            $0.toMovieEntity(
                context: self.coreData.context,
                groupType: contentTypeRepo.getBelongsToTypeEntity(type: type)
            )
        })
        self.coreData.saveContext()
    }
    
    private func getMovieFetchRequestById(_ id: Int) -> NSFetchRequest<MovieEntity> {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K = %@", "id", "\(id)")
        fetchRequest.sortDescriptors = [
        NSSortDescriptor(key: "popularity", ascending: false)
        ]
        return fetchRequest
    }
    private func getMovieCastsFetchRequestByID(_ movieId: Int) -> NSFetchRequest<ActorEntity> {
        let fetchRequest: NSFetchRequest<ActorEntity> = ActorEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K = %@", "id", "\(movieId)")
        return fetchRequest
    }
}
