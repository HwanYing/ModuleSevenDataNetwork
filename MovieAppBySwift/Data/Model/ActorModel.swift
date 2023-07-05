//
//  ActorModel.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/7/1.
//

import Foundation

protocol ActorModel {
    var totalPageActorList: Int { get set }
    
    func getPopularPeople(page: Int, completion: @escaping (MDBResult<[ActorInfoResponse]>) -> Void)
    func getActorGallery(id: Int, completion: @escaping (MDBResult<ActorInfoResponse>) -> Void)
    func getActorDetails(id: Int, completion: @escaping (MDBResult<ActorDetailsResponse>) -> Void)
    func getTVCredits(id: Int, completion: @escaping (MDBResult<TVCreditsResponse>) -> Void)
 
}

class ActorModelImpl: BaseModel, ActorModel {
    
    static let shared: ActorModelImpl = ActorModelImpl()
    
    private override init() {
        
    }
    
    private let actorRepository: ActorRepository = ActorRepositoryImpl.shared
    private let movieRepository: MovieRepository = MovieRepositoryImpl.shared
    
    var totalPageActorList: Int = 1
    
    func getActorGallery(id: Int, completion: @escaping (MDBResult<ActorInfoResponse>) -> Void) {
        networkAgent.getActorGallery(id: id, completion: completion)
    }
    
    func getActorDetails(id: Int, completion: @escaping (MDBResult<ActorDetailsResponse>) -> Void) {
        networkAgent.getActorBio(id: id) { (result) in
            switch result {
            case .success(let data):
                self.actorRepository.saveDetails(data: data)
                completion(.success(data))
            case .failure(let error):
                print("\(#function) \(error)")
            }
            
        }
        self.actorRepository.getDetails(id: id) { data in
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure("Couldn't find actor with id \(id)"))
            }
        }
    }
    
    func getTVCredits(id: Int, completion: @escaping (MDBResult<TVCreditsResponse>) -> Void) {
        networkAgent.getTVCreditsList(id: id, completion: completion)
    }
    
    func getPopularPeople(page: Int, completion: @escaping (MDBResult<[ActorInfoResponse]>) -> Void) {
        
        var networkResult = [ActorInfoResponse]()
        networkAgent.getPeopleList(page: page) { (result) in
            switch result {
            case .success(let data):
                networkResult = data.results ?? [ActorInfoResponse]()
                self.actorRepository.save(list: data.results ?? [ActorInfoResponse]())
                self.totalPageActorList = data.totalPages ?? 1
            case .failure(let error):
                print("\(#function) \(error)")
            }
            
            self.actorRepository.getList(page: page, type: .popularActors) {
                completion(.success($0))
            }
            
            if networkResult.isEmpty {
                /// Update Total Pages available to fetch
                self.actorRepository.getTotalPageActorList {
                    self.totalPageActorList = $0
                }
            }
        }
        
    }
    
}
