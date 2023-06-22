//
//  MovieDBNetworkAgentWithURLSession.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/6/19.
//

import Foundation

class MovieDBNetworkAgentWithURLSession: MovieDBNetworkAgentProtocol {
    
    static let shared = MovieDBNetworkAgentWithURLSession()
    
    private init() { }
    
    func searchMovieByKeyword(query: String, page: String, completion: @escaping (MDBResult<MovieListResult>) -> Void) {
        let url = URL(string: "\(AppConstants.BaseURL)/search/movie")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = ["key1": "value1", "key2": "value2"]
        urlRequest.setValue("value3", forHTTPHeaderField: "key3")
        
        let session = URLSession.shared
        
        session.dataTask(with: urlRequest) { data, response, error in
            let genreList: MovieGenreList = try! JSONDecoder().decode(MovieGenreList.self, from: data!)
            print(genreList.genres.count)
            
        }.resume()
    }
    
    func getActorGallery(id: Int, completion: @escaping (MDBResult<ActorInfoResponse>) -> Void) {
        //
    }
    
    func getTVCreditsList(id: Int, completion: @escaping (MDBResult<TVCreditsResponse>) -> Void) {
        //
    }
    
    func getActorBio(id: Int, completion: @escaping (MDBResult<ActorDetailsResponse>) -> Void) {
        //
    }
    
    func getMovieTrailerVideo(id: Int, completion: @escaping (MDBResult<MovieTrailerResponse>) -> Void) {
        
    }
    
    func getSimilarMovieList(id: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void) {
        
    }
    
    func getMovieCreditById(id: Int, completion: @escaping (MDBResult<MovieActorResponse>) -> Void) {
        
    }
    
    func getSerieDetailById(id: Int, completion: @escaping (MDBResult<MovieDetailsResponse>) -> Void) {
        
    }
    
    func getMovieDetailsInfo(id: Int, completion: @escaping (MDBResult<MovieDetailsResponse>) -> Void) {
        
    }
    
    func getPeopleList(page: Int, completion: @escaping (MDBResult<ActorListResult>) -> Void) {
        
    }
    
    func getTopRatedMovieList(page: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void) {
        
    }
    
    func getGenreList(completion: @escaping (MDBResult<MovieGenreList>) -> Void) {
        let url = URL(string: "\(AppConstants.BaseURL)/genre/movie/list?language=en")
        var request = URLRequest(url: url!)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(AppConstants.accessToken)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            let genreList = try! JSONDecoder().decode(MovieGenreList.self, from: data!)
            print(genreList.genres)
        }
        .resume()
    }
    
    func getPopularTVList(completion: @escaping (MDBResult<MovieListResult>) -> Void) {
        
    }
    
    func getPopularMovieList(page: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void) {
        
    }
    
    func getUpcomingMovieList(page: Int, completion: @escaping (MDBResult<UpcomingMovieList>) -> Void) {
        let url = URL(string: "\(AppConstants.BaseURL)/movie/upcoming?language=en-US&page=\(page)&region=")
        var urlRequest = URLRequest(url: url!)
        urlRequest.addValue("\(AppConstants.accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                let upcomingMovieList = try! JSONDecoder().decode(UpcomingMovieList.self, from: data)
                print(upcomingMovieList.results?.count ?? "")
            }
        }
        .resume()
    }
    
   
}
