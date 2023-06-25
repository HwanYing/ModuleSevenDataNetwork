//
//  NetworkingAgent.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/6/6.
//

import Foundation
import Alamofire

enum MDBResult<T> {
    case success(T)
    case failure(String)
}

protocol MovieDBNetworkAgentProtocol {
    /// Movie Details
    func getMovieTrailerVideo(id: Int, completion: @escaping (MDBResult<MovieTrailerResponse>) -> Void)
    func getSimilarMovieList(id: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void)
    func getMovieCreditById(id: Int, completion: @escaping (MDBResult<MovieActorResponse>) -> Void)
    func getMovieDetailsInfo(id: Int, completion: @escaping (MDBResult<MovieDetailsResponse>) -> Void)

    /// Movies
    func getTopRatedMovieList(page: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void)
    func getGenreList(completion: @escaping (MDBResult<MovieGenreList>) -> Void)
    func getPopularTVList(completion: @escaping (MDBResult<MovieListResult>) -> Void)
    func getPopularMovieList(page: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void)
    func getUpcomingMovieList(page: Int, completion: @escaping (MDBResult<UpcomingMovieList>) -> Void)
    
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

struct MovieDBNetworkAgent : MovieDBNetworkAgentProtocol {
    
    // singleton object
    static let shared = MovieDBNetworkAgent()
    let headers: HTTPHeaders = [
        "Authorization": "\(AppConstants.accessToken)",
        "Accept": "application/json"
    ]
    private init() {}
    
    // search movie
    func searchMovieByKeyword(query: String, page: String ,completion: @escaping (MDBResult<MovieListResult>) -> Void) {
        
        AF.request(MDBEndpoint.searchMovie(page, query)
                   , headers: headers)
        .responseDecodable(of: MovieListResult.self){ resp in
            switch resp.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(resp, error, MDBCommonResponseError.self)))
            }
        }
    }
    func getActorGallery(id: Int, completion: @escaping (MDBResult<ActorInfoResponse>) -> Void) {
        //
    }
    
    func getSerieDetailById(id: Int, completion: @escaping (MDBResult<MovieDetailsResponse>) -> Void) {
        //
    }
    
    func getPopularMovieList(page: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void) {
        AF.request(MDBEndpoint.popularMovie(page)
                   , headers: headers)
        .responseDecodable(of: MovieListResult.self){ resp in
            switch resp.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(resp, error, MDBCommonResponseError.self)))
            }
        }
    }
    // get tv credits for actor info page
    func getTVCreditsList(id: Int, completion: @escaping (MDBResult<TVCreditsResponse>) -> Void) {
        AF.request(MDBEndpoint.actorTVCredits(id)
                   , headers: headers)
        .responseDecodable(of: TVCreditsResponse.self){ resp in
            switch resp.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(resp, error, MDBCommonResponseError.self)))
            }
        }
    }
    
    // get actor bio
    func getActorBio(id: Int, completion: @escaping (MDBResult<ActorDetailsResponse>) -> Void) {
        
        AF.request(MDBEndpoint.actorDetail(id),
                   headers: headers)
        .responseDecodable(of: ActorDetailsResponse.self){ resp in
            switch resp.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(resp, error, MDBCommonResponseError.self)))
            }
        }
    }
    
    // get movie trailer link
    func getMovieTrailerVideo(id: Int, completion: @escaping (MDBResult<MovieTrailerResponse>) -> Void) {
        AF.request(MDBEndpoint.trailerVideo(id),
                   headers: headers)
        .responseDecodable(of: MovieTrailerResponse.self){ resp in
            switch resp.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(resp, error, MDBCommonResponseError.self)))
            }
        }
    }
    
    // get tv series details info
    func getTVSeriesDetailsInfo(id: Int, completion: @escaping (MDBResult<TVSeriesDetailsResponse>) -> Void) {
        AF.request(MDBEndpoint.seriesDetails(id)
                   , headers: headers)
        .responseDecodable(of: TVSeriesDetailsResponse.self){ resp in
            switch resp.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(resp, error, MDBCommonResponseError.self)))
            }
        }
    }
    
    // for similar movie section
    func getSimilarMovieList(id: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void) {
        
        AF.request(MDBEndpoint.similarMovie(id),
                   headers: headers)
        .responseDecodable(of: MovieListResult.self){ resp in
            switch resp.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(resp, error, MDBCommonResponseError.self)))
            }
        }
    }
    // for similar movie section
//    func getSimilarMovieList1(id: Int, completion: @escaping (MovieListResult) -> Void, failure: @escaping (String) -> Void) {
//
//        AF.request(MDBEndpoint.similarMovie(id),
//                   headers: headers)
//        .responseDecodable(of: MovieListResult.self){ resp in
//            switch resp.result {
//            case .success(let data):
//                completion(data)
//            case .failure(let error):
//                failure(error.errorDescription)
//            }
//        }
//    }
    
    // Popular TV List
    func getPopularTVList(completion: @escaping (MDBResult<MovieListResult>) -> Void) {
        // page need
        AF.request(MDBEndpoint.popularTVSeries
                   , headers: headers)
        .responseDecodable(of: MovieListResult.self){ resp in
            switch resp.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(resp, error, MDBCommonResponseError.self)))
            }
        }
    }
    
    // Upcoming Movie list
    func getUpcomingMovieList(page: Int, completion: @escaping (MDBResult<UpcomingMovieList>) -> Void) {
        /**
         1) url
         2) method
         3) headers
         4) body
         */
        
        AF.request(MDBEndpoint.upcomingMovie(page)
                   , headers: headers)
        .responseDecodable(of: UpcomingMovieList.self){ resp in
            switch resp.result {
            case .success(let upcomingMovieList):
                completion(.success(upcomingMovieList))
            case .failure(let error):
                completion(.failure(handleError(resp, error, MDBCommonResponseError.self)))
            }
        }
    }
    
    // get genre list
    func getGenreList(completion: @escaping (MDBResult<MovieGenreList>) -> Void) {
        AF.request(MDBEndpoint.movieGenres, headers: headers)
            .responseDecodable(of: MovieGenreList.self){ resp in
                switch resp.result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure(let error):
                    completion(.failure(handleError(resp, error, MDBCommonResponseError.self)))
                }
            }
    }
    // top rated movie list
    func getTopRatedMovieList(page: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void) {
        
        AF.request(MDBEndpoint.tapRatedMovies(page), headers: headers)
            .responseDecodable(of: MovieListResult.self){ resp in
                switch resp.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(handleError(resp, error, MDBCommonResponseError.self)))
                }
            }
    }
    // popular actor list
    func getPeopleList(page: Int = 1, completion: @escaping (MDBResult<ActorListResult>) -> Void){
        AF.request(MDBEndpoint.popularActors(page), headers: headers)
            .responseDecodable(of: ActorListResult.self){ resp in
                switch resp.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(handleError(resp, error, MDBCommonResponseError.self)))
                }
            }
    }
    // movieActor
    func getPeopleListById(id: Int, completion: @escaping (MDBResult<MovieActorResponse>) -> Void){
        AF.request(MDBEndpoint.movieActors(id), headers: headers)
            .responseDecodable(of: MovieActorResponse.self){ resp in
                switch resp.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(handleError(resp, error, MDBCommonResponseError.self)))
                }
            }
    }
    
    // movie details info
    func getMovieDetailsInfo(id: Int, completion: @escaping (MDBResult<MovieDetailsResponse>) -> Void) {
        
        AF.request(MDBEndpoint.movieDetails(id), headers: headers)
            .responseDecodable(of: MovieDetailsResponse.self){ resp in
                switch resp.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(handleError(resp, error, MDBCommonResponseError.self)))
                }
            }
    }
    // movie actor list
    func getMovieCreditById(id: Int, completion: @escaping (MDBResult<MovieActorResponse>) -> Void) {
        AF.request(MDBEndpoint.movieActors(id), headers: headers)
            .responseDecodable(of: MovieActorResponse.self){ resp in
                switch resp.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(handleError(resp, error, MDBCommonResponseError.self)))
                }
            }
    }
   
    
    /**
     Network Error - Different Scenarios
     
     *JSON Serialization Error
     *Wrong URL path
     *Incorrect method
     *missing credentials
     *4xx
     *5xx
     
     */
    // 3 - Customized Error Body
    fileprivate func handleError<T, E: MDBErrorModel>(
        _ response: DataResponse<T, AFError>,
        _ error: (AFError),
        _ errorBodyType: E.Type) -> String {
            var respBody: String = ""
            var serverErrorMessage: String?
            
            var errorBody: E?
            if let respData = response.data {
                respBody = String(data: respData, encoding: .utf8) ?? "empty response body"
                
                errorBody = try? JSONDecoder().decode(errorBodyType, from: respData)
                serverErrorMessage = errorBody?.message
            }
            
            // 2 - Extract debug info
            let respCode: Int = response.response?.statusCode ?? 0
            let sourcePath = response.request?.url?.absoluteString ?? "no url"
            
            // 1 - Essential debug info
            print(
            """
            ==========================
            URL
            -> \(sourcePath)
            
            Status
            -> \(respCode)
            
            Body
            -> \(respBody)
            
            Underlying Error
            -> \(error.underlyingError!)
            
            Error Description
            -> \(error.errorDescription!)
            ============================
            """
            )
            
            // 4 - Client display
            return serverErrorMessage ?? error.errorDescription ?? "undefined"
        }
}



protocol MDBErrorModel: Decodable {
    var message: String { get }
}

class MDBCommonResponseError: MDBErrorModel {
    var message: String {
        return statusMessage
    }
    
    let statusMessage: String
    let statusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }
}

