//
//  MovieDetailModel.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/7/1.
//

import Foundation

protocol MovieDetailModel {
    func getMovieTrailers(id: Int, completion: @escaping (MDBResult<MovieTrailerResponse>) -> Void)
    func getSimilarMovies(id: Int, completion: @escaping (MDBResult<[MovieResult]>) -> Void)
    func getMovieCreditById(id: Int, completion: @escaping (MDBResult<[MovieCast]>) -> Void)
    func getMovieDetailById(id: Int, completion: @escaping (MDBResult<MovieDetailsResponse>) -> Void)
    func getSerieDetailById(id: Int, completion: @escaping (MDBResult<MovieDetailsResponse>) -> Void)
}

class MovieDetailModelImpl: BaseModel, MovieDetailModel {
    
    static let shared : MovieDetailModelImpl = MovieDetailModelImpl()
    
    private override init() {
        
    }
    
    private let movieRepository: MovieRepository = MovieRepositoryImpl.shared
    
    func getMovieTrailers(id: Int, completion: @escaping (MDBResult<MovieTrailerResponse>) -> Void) {
        networkAgent.getMovieTrailerVideo(id: id, completion: completion)
    }
    
    func getSimilarMovies(id: Int, completion: @escaping (MDBResult<[MovieResult]>) -> Void) {
        networkAgent.getSimilarMovieList(id: id) { (result) in
            switch result {
            case .success(let data):
                self.movieRepository.saveSimilarContent(id: id, data: data.results ?? [MovieResult]())
                completion(.success(data.results ?? [MovieResult]()))
            case .failure(let error):
                print("\(#function) \(error)")
            }
           
        }
        self.movieRepository.getSimilarContent(id: id) {
            completion(.success($0))
        }
    }
    
    func getMovieCreditById(id: Int, completion: @escaping (MDBResult<[MovieCast]>) -> Void) {
        // Movie Id
        networkAgent.getPeopleListById(id: id) { (result) in
            switch result {
            case .success(let data):
                self.movieRepository.saveCasts(id: id, data: data.cast ?? [MovieCast]())
                completion(.success(data.cast ?? [MovieCast]()))
            case .failure(let error):
                print("\(#function) \(error)")
            }
            
        }
        self.movieRepository.getCasts(id: id) {
            completion(.success($0))
        }
    }
    
    func getMovieDetailById(id: Int, completion: @escaping (MDBResult<MovieDetailsResponse>) -> Void) {
        networkAgent.getMovieDetailsInfo(id: id) { (result) in
            switch result {
            case .success(let data):
                self.movieRepository.saveDetail(data: data)
                completion(.success(data))
            case .failure(let error):
                print("\(#function) \(error)")
            }
        
        }
        self.movieRepository.getDetail(id: id) { (item) in
            if let item = item {
                completion(.success(item))
            } else {
                completion(.failure("Failed to get detail with id \(id)"))
            }
        }
    }
    
    func getSerieDetailById(id: Int, completion: @escaping (MDBResult<MovieDetailsResponse>) -> Void) {
        networkAgent.getSerieDetailById(id: id) { (result) in
            switch result {
            case .success(let data):
                self.movieRepository.saveDetail(data: data)
            case .failure(let error):
                print("\(#function) \(error)")
            }
            
            self.movieRepository.getDetail(id: id) { (item) in
                if let item = item {
                    completion(.success(item))
                } else {
                    completion(.failure("Failed to get detail with id \(id)"))
                }
            }
        }
    }
    
    
}
