//
//  MovieModel.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/6/23.
//

import Foundation


//protocol MovieModel {
//    func getTopRatedMovieList(page: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void)
//    func getGenreList(completion: @escaping (MDBResult<MovieGenreList>) -> Void)
//    func getPopularTVList(completion: @escaping (MDBResult<MovieListResult>) -> Void)
//    func getPopularMovieList(page: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void)
//    func getUpcomingMovieList(page: Int, completion: @escaping (MDBResult<UpcomingMovieList>) -> Void)
//
//    /// Movie Details
//    func getMovieTrailerVideo(id: Int, completion: @escaping (MDBResult<MovieTrailerResponse>) -> Void)
//    func getSimilarMovieList(id: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void)
//    func getMovieCreditById(id: Int, completion: @escaping (MDBResult<MovieActorResponse>) -> Void)
//    func getMovieDetailsInfo(id: Int, completion: @escaping (MDBResult<MovieDetailsResponse>) -> Void)
//
//    /// Series
//    func getSerieDetailById(id: Int, completion: @escaping (MDBResult<MovieDetailsResponse>) -> Void)
//
//    /// Search
//    func searchMovieByKeyword(query: String, page: String, completion: @escaping (MDBResult<MovieListResult>) -> Void)
//
//    /// Actor
//    func getActorGallery(id: Int, completion: @escaping (MDBResult<ActorInfoResponse>) -> Void)
//    func getTVCreditsList(id: Int, completion: @escaping (MDBResult<TVCreditsResponse>) -> Void)
//    func getActorBio(id: Int, completion: @escaping (MDBResult<ActorDetailsResponse>) -> Void)
//    func getPeopleList(page: Int, completion: @escaping (MDBResult<ActorListResult>) -> Void)
//    func getPeopleListById(id: Int, completion: @escaping (MDBResult<MovieActorResponse>) -> Void) // movie actor
//}

protocol MovieModel1 {
    /// Movies
    func getTopRatedMovieList(page: Int, completion: @escaping (MDBResult<[MovieResult]>) -> Void)
    func getPopularMovieList(completion: @escaping (MDBResult<[MovieResult]>) -> Void)
    func getUpcomingMovieList(completion: @escaping (MDBResult<[MovieResult]>) -> Void)
    func getGenreList(completion: @escaping (MDBResult<[MovieGenre]>) -> Void)
    func getPopularSeriesList(completion: @escaping (MDBResult<[MovieResult]>) -> Void)
  
}

//class MovieModelImpl: BaseModel, MovieModel {
//   
//    static let shared: MovieModelImpl = MovieModelImpl()
//    
//    private override init() { }
//    
//    func getMovieTrailerVideo(id: Int, completion: @escaping (MDBResult<MovieTrailerResponse>) -> Void) {
//        networking.getMovieTrailerVideo(id: id, completion: completion)
//    }
//    
//    func getSimilarMovieList(id: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void) {
//        networking.getSimilarMovieList(id: id, completion: completion)
//    }
//    
//    func getMovieCreditById(id: Int, completion: @escaping (MDBResult<MovieActorResponse>) -> Void) {
//        networking.getMovieCreditById(id: id, completion: completion)
//    }
//    
//    func getMovieDetailsInfo(id: Int, completion: @escaping (MDBResult<MovieDetailsResponse>) -> Void) {
//        networking.getMovieDetailsInfo(id: id, completion: completion)
//    }
//    
//    func getSerieDetailById(id: Int, completion: @escaping (MDBResult<MovieDetailsResponse>) -> Void) {
//        networking.getSerieDetailById(id: id, completion: completion)
//    }
//    
//    func searchMovieByKeyword(query: String, page: String, completion: @escaping (MDBResult<MovieListResult>) -> Void) {
//        networking.searchMovieByKeyword(query: query, page: page, completion: completion)
//    }
//    
//    func getActorGallery(id: Int, completion: @escaping (MDBResult<ActorInfoResponse>) -> Void) {
//        networking.getActorGallery(id: id, completion: completion)
//    }
//    
//    func getTVCreditsList(id: Int, completion: @escaping (MDBResult<TVCreditsResponse>) -> Void) {
//        networking.getTVCreditsList(id: id, completion: completion)
//    }
//    
//    func getActorBio(id: Int, completion: @escaping (MDBResult<ActorDetailsResponse>) -> Void) {
//        networking.getActorBio(id: id, completion: completion)
//    }
//    
//    func getPeopleList(page: Int, completion: @escaping (MDBResult<ActorListResult>) -> Void) {
//        networking.getPeopleList(page: page, completion: completion)
//    }
//    
//    func getPeopleListById(id: Int, completion: @escaping (MDBResult<MovieActorResponse>) -> Void) {
//        networking.getPeopleListById(id: id, completion: completion)
//    }
//   
//    func getTopRatedMovieList(page: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void) {
//        networking.getTopRatedMovieList(page: page, completion: completion)
//    }
//    
//    func getGenreList(completion: @escaping (MDBResult<MovieGenreList>) -> Void) {
//        networking.getGenreList(completion: completion)
//
//    }
//    
//    func getPopularTVList(completion: @escaping (MDBResult<MovieListResult>) -> Void) {
//        networking.getPopularTVList(completion: completion)
//    }
//    
//    func getPopularMovieList(page: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void) {
//        networking.getPopularMovieList(page: page, completion: completion)
//    }
//    
//    func getUpcomingMovieList(page: Int, completion: @escaping (MDBResult<UpcomingMovieList>) -> Void) {
//        networking.getUpcomingMovieList(page: page, completion: completion)
//    }
//}

class MovieModelImpl1: BaseModel, MovieModel1 {
    
    static let shared: MovieModelImpl1 = MovieModelImpl1()
    
    private override init() {
        
    }
    
    private let movieRepository: MovieRepository = MovieRepositoryImpl.shared
    private let contentTypeRepository: ContentTypeRepository = ContentTypeRepositoryImpl.shared
    private let genreRepository: GenreRepository = GenreRepositoryImpl.shared
    
    func getTopRatedMovieList(page: Int, completion: @escaping (MDBResult<[MovieResult]>) -> Void) {
        let contentType: MovieSerieGroupType = .topRatedMovies
        
        networkAgent.getTopRatedMovieList(page: page) { (result) in
            switch result {
            case .success(let data):
                self.movieRepository.saveList(type: contentType, data: data)
                completion(.success(data.results ?? [MovieResult]()))
            case .failure(let error):
                print("\(#function) \(error)")
            }
            
        }
        self.contentTypeRepository.getMoviesOrSeries(type: contentType) {
            completion(.success($0))
        }
    }
    
    func getPopularMovieList(completion: @escaping (MDBResult<[MovieResult]>) -> Void) {
        
        networkAgent.getPopularMovieList(page: 1) { (result) in
            switch result {
            case .success(let data):
                self.movieRepository.saveList(type: .popularMovies, data: data)
                completion(.success(data.results ?? [MovieResult]()))
            case .failure(let error):
                print(error)
            }
        }
        self.contentTypeRepository.getMoviesOrSeries(type: .popularMovies) {
            completion(.success($0))
        }
    }
    
    func getUpcomingMovieList(completion: @escaping (MDBResult<[MovieResult]>) -> Void) {
        networkAgent.getUpcomingMovieList(page: 1) { (result) in
            switch result {
            case .success(let data):
                self.movieRepository.saveList(type: .upcomingMovies, data: data.convertToMovieListResult())
                completion(.success(data.results ?? [MovieResult]()))
            case .failure(let error):
                print(error)
            }
           
        }
        self.contentTypeRepository.getMoviesOrSeries(type: .upcomingMovies) {
            completion(.success($0))
        }
    }
    
    func getGenreList(completion: @escaping (MDBResult<[MovieGenre]>) -> Void) {
        /// Fetch from Network
        networkAgent.getGenreList { (result) in
            switch result {
            case .success(let data):
                /// Save to Database
                self.genreRepository.save(data: data)
                completion(.success(data.genres))
            case .failure(let error):
                print("\(#function) \(error)")
            }
            
        }
        /// Fetch inserted data from Database
        self.genreRepository.get {
            completion(.success($0))
        }
    }
    
    func getPopularSeriesList(completion: @escaping (MDBResult<[MovieResult]>) -> Void) {
        networkAgent.getPopularTVList { (result) in
            switch result {
            case .success(let data):
                self.movieRepository.saveList(type: .popularSeries, data: data)
                completion(.success(data.results ?? [MovieResult]()))
            case .failure(let error):
                print("\(#function) \(error)")
            }
            
        }
        self.contentTypeRepository.getMoviesOrSeries(type: .popularSeries) {
            completion(.success($0))
        }
    }
    
}
