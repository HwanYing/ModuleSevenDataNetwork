//
//  NetworkingAgent.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/6/6.
//

import Foundation
import Alamofire

struct MovieDBNetworkAgent {
    // singleton object
    static let shared = MovieDBNetworkAgent()
    let headers: HTTPHeaders = [
        "Authorization": "\(AppConstants.accessToken)",
        "Accept": "application/json"
    ]
    private init() {}
    
    // get tv credits for actor info page
    func getTVCreditsList(id: Int, success: @escaping (TVCreditsResponse) -> Void, failure: @escaping (String) -> Void) {
        let url = URL(string: "\(AppConstants.BaseURL)/person/\(id)/tv_credits?language=en-US")!
        AF.request(url, headers: headers).responseDecodable(of: TVCreditsResponse.self){ resp in
            switch resp.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    
    // get actor bio
    func getActorBio(actorId: Int, success: @escaping (ActorDetailsResponse) -> Void, failure: @escaping (String) -> Void) {
        let url = URL(string: "\(AppConstants.BaseURL)/person/\(actorId)?language=en-US")!
        AF.request(url, headers: headers).responseDecodable(of: ActorDetailsResponse.self){ resp in
            switch resp.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    
    // get movie trailer link
    func getMovieTrailerVideo(id: Int, success: @escaping (MovieTrailerResponse) -> Void, failure: @escaping (String) -> Void) {
        let url = URL(string: "\(AppConstants.BaseURL)/movie/\(id)/videos?language=en-US")!
        AF.request(url, headers: headers).responseDecodable(of: MovieTrailerResponse.self){ resp in
            switch resp.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    
    // get tv series details info
    func getTVSeriesDetailsInfo(id: Int, success: @escaping (TVSeriesDetailsResponse) -> Void, failure: @escaping (String) -> Void) {
        let url = URL(string: "\(AppConstants.BaseURL)/tv/\(id)?append_to_response=&language=en-US")!
        AF.request(url, headers: headers).responseDecodable(of: TVSeriesDetailsResponse.self){ resp in
            switch resp.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    
    // for similar movie section
    func getSimilarMovieList(id: Int, success: @escaping (MovieListResult) -> Void, failure: @escaping (String) -> Void) {
        let url = URL(string: "\(AppConstants.BaseURL)/movie/\(id)/similar?language=en-US&page=1")!
        
        AF.request(url, headers: headers).responseDecodable(of: MovieListResult.self){ resp in
            switch resp.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    
    // Popular Movie list
    func getPopularMovieList(success: @escaping (MovieListResult) -> Void, failure: @escaping (String) -> Void) {
        let url = URL(string: "\(AppConstants.BaseURL)/movie/popular?language=en-US&page=1&region=")!
        
        AF.request(url, headers: headers).responseDecodable(of: MovieListResult.self){ resp in
            switch resp.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    
    // Popular TV List
    func getPopularTVList(success: @escaping (MovieListResult) -> Void, failure: @escaping (String) -> Void) {
        let url = URL(string: "\(AppConstants.BaseURL)/tv/popular?language=en-US&page=1&region=")!
        
        AF.request(url, headers: headers).responseDecodable(of: MovieListResult.self){ resp in
            switch resp.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    
    // Upcoming Movie list
    func getUpcomingMovieList(success: @escaping (UpcomingMovieList) -> Void, failure: @escaping (String) -> Void) {
        /**
         1) url
         2) method
         3) headers
         4) body
         */
        let url = URL(string: "\(AppConstants.BaseURL)/movie/upcoming?language=en-US&page=1&region=")!
        
        AF.request(url, headers: headers).responseDecodable(of: UpcomingMovieList.self){ resp in
            switch resp.result {
            case .success(let upcomingMovieList):
                success(upcomingMovieList)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }

    // get genre list
    func getGenreList(success: @escaping (MovieGenreList) -> Void, failure: @escaping (String) -> Void) {
        let url = URL(string: "\(AppConstants.BaseURL)/genre/movie/list")!
        AF.request(url, headers: headers).responseDecodable(of: MovieGenreList.self){ resp in
            switch resp.result {
            case .success(let genreList):
                success(genreList)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    // top rated movie list
    func getTopRatedMovieList(success: @escaping (MovieListResult) -> Void, failure: @escaping (String) -> Void) {
        let url = URL(string: "\(AppConstants.BaseURL)/movie/top_rated?language=en-US&page=1")!
        AF.request(url, headers: headers).responseDecodable(of: MovieListResult.self){ resp in
            switch resp.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    // best actor list
    func getPeopleList(page: Int = 1, success: @escaping (ActorListResult) -> Void, failure: @escaping (String) -> Void){
        //{{baseUrl}}/3/person/popular?language=en-US&page=1
        let url = URL(string: "\(AppConstants.BaseURL)/person/popular?page=\(page)&language=en-US&page=1")!
        AF.request(url, headers: headers).responseDecodable(of: ActorListResult.self){ resp in
            switch resp.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    // best actor list by Id
    func getPeopleListById(id: Int, success: @escaping (MovieActorResponse) -> Void, failure: @escaping (String) -> Void){
        //{{baseUrl}}/3/person/popular?language=en-US&page=1
        let url = URL(string: "\(AppConstants.BaseURL)/movie/\(id)/credits?language=en-US")!
        AF.request(url, headers: headers).responseDecodable(of: MovieActorResponse.self){ resp in
            switch resp.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    
    // movie details info
    func getMovieDetailsInfo(id: Int, success: @escaping (MovieDetailsResponse) -> Void, failure: @escaping (String) -> Void) {
//        let url = URL(string: "\(AppConstants.BaseURL)/movie/:movie_id?append_to_response=&language=en-US")

        let url = URL(string: "\(AppConstants.BaseURL)/movie/\(id)?language=en-US")!
        AF.request(url, headers: headers).responseDecodable(of: MovieDetailsResponse.self){ resp in
            switch resp.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    // movie actor list
    func getMovieCreditById(id: Int, success: @escaping (MovieActorResponse) -> Void, failure: @escaping (String) -> Void) {
        let url = URL(string: "\(AppConstants.BaseURL)/movie/\(id)/credits?language=en-US")!
        AF.request(url, headers: headers).responseDecodable(of: MovieActorResponse.self){ resp in
            switch resp.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
}
