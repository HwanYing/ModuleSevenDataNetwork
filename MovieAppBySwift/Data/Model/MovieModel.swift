//
//  MovieModel.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/6/23.
//

import Foundation


protocol MovieModel {
    func getTopRatedMovieList(page: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void)
    func getGenreList(completion: @escaping (MDBResult<MovieGenreList>) -> Void)
    func getPopularTVList(completion: @escaping (MDBResult<MovieListResult>) -> Void)
    func getPopularMovieList(page: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void)
    func getUpcomingMovieList(page: Int, completion: @escaping (MDBResult<UpcomingMovieList>) -> Void)
    /// Movie Details
    func getMovieTrailerVideo(id: Int, completion: @escaping (MDBResult<MovieTrailerResponse>) -> Void)
    func getSimilarMovieList(id: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void)
    func getMovieCreditById(id: Int, completion: @escaping (MDBResult<MovieActorResponse>) -> Void)
    func getMovieDetailsInfo(id: Int, completion: @escaping (MDBResult<MovieDetailsResponse>) -> Void)
    /// Series
    func getSerieDetailById(id: Int, completion: @escaping (MDBResult<MovieDetailsResponse>) -> Void)
    
    /// Search
    func searchMovieByKeyword(query: String, page: String, completion: @escaping (MDBResult<MovieListResult>) -> Void)
    
    /// Actor
    func getActorGallery(id: Int, completion: @escaping (MDBResult<ActorInfoResponse>) -> Void)
    func getTVCreditsList(id: Int, completion: @escaping (MDBResult<TVCreditsResponse>) -> Void)
    func getActorBio(id: Int, completion: @escaping (MDBResult<ActorDetailsResponse>) -> Void)
    func getPeopleList(page: Int, completion: @escaping (MDBResult<ActorListResult>) -> Void)
    func getPeopleListById(id: Int, completion: @escaping (MDBResult<MovieActorResponse>) -> Void) // movie actor
}

class MovieModelImpl: BaseModel, MovieModel {
    
    
    static let shared = MovieModelImpl()
    
    private override init() { }
    
    
    func getMovieTrailerVideo(id: Int, completion: @escaping (MDBResult<MovieTrailerResponse>) -> Void) {
        networking.getMovieTrailerVideo(id: id, completion: completion)
    }
    
    func getSimilarMovieList(id: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void) {
        networking.getSimilarMovieList(id: id, completion: completion)
    }
    
    func getMovieCreditById(id: Int, completion: @escaping (MDBResult<MovieActorResponse>) -> Void) {
        networking.getMovieCreditById(id: id, completion: completion)
    }
    
    func getMovieDetailsInfo(id: Int, completion: @escaping (MDBResult<MovieDetailsResponse>) -> Void) {
        networking.getMovieDetailsInfo(id: id, completion: completion)
    }
    
    func getSerieDetailById(id: Int, completion: @escaping (MDBResult<MovieDetailsResponse>) -> Void) {
        networking.getSerieDetailById(id: id, completion: completion)
    }
    
    func searchMovieByKeyword(query: String, page: String, completion: @escaping (MDBResult<MovieListResult>) -> Void) {
        networking.searchMovieByKeyword(query: query, page: page, completion: completion)
    }
    
    func getActorGallery(id: Int, completion: @escaping (MDBResult<ActorInfoResponse>) -> Void) {
        networking.getActorGallery(id: id, completion: completion)
    }
    
    func getTVCreditsList(id: Int, completion: @escaping (MDBResult<TVCreditsResponse>) -> Void) {
        networking.getTVCreditsList(id: id, completion: completion)
    }
    
    func getActorBio(id: Int, completion: @escaping (MDBResult<ActorDetailsResponse>) -> Void) {
        networking.getActorBio(id: id, completion: completion)
    }
    
    func getPeopleList(page: Int, completion: @escaping (MDBResult<ActorListResult>) -> Void) {
        networking.getPeopleList(page: page, completion: completion)
    }
    
    func getPeopleListById(id: Int, completion: @escaping (MDBResult<MovieActorResponse>) -> Void) {
        networking.getPeopleListById(id: id, completion: completion)
    }
   
    func getTopRatedMovieList(page: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void) {
        networking.getTopRatedMovieList(page: page, completion: completion)
    }
    
    func getGenreList(completion: @escaping (MDBResult<MovieGenreList>) -> Void) {
        networking.getGenreList(completion: completion)
    }
    
    func getPopularTVList(completion: @escaping (MDBResult<MovieListResult>) -> Void) {
        networking.getPopularTVList(completion: completion)
    }
    
    func getPopularMovieList(page: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void) {
        networking.getPopularMovieList(page: page, completion: completion)
    }
    
    func getUpcomingMovieList(page: Int, completion: @escaping (MDBResult<UpcomingMovieList>) -> Void) {
        networking.getUpcomingMovieList(page: page, completion: completion)
    }
}
