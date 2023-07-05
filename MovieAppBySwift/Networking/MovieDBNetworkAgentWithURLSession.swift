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
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("\(AppConstants.accessToken)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        session.dataTask(with: urlRequest) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            let successRange = 200..<300
            if successRange.contains(statusCode) {
                let movieList: MovieListResult = try! JSONDecoder().decode(MovieListResult.self, from: data!)
                completion(.success(movieList))
                print(movieList.results?.count ?? 0)
            } else {
                completion(.failure(error!.localizedDescription))
            }
           
            
        }.resume()
    }
    
    func getActorGallery(id: Int, completion: @escaping (MDBResult<ActorInfoResponse>) -> Void) {
       
    }
    
    func getTVCreditsList(id: Int, completion: @escaping (MDBResult<TVCreditsResponse>) -> Void) {
        let url = URL(string: "\(AppConstants.BaseURL)/person/\(id)/tv_credits")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("\(AppConstants.accessToken)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        session.dataTask(with: urlRequest) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            let successRange = 200..<300
            if successRange.contains(statusCode) {
                let creditList: TVCreditsResponse = try! JSONDecoder().decode(TVCreditsResponse.self, from: data!)
                completion(.success(creditList))
                print(creditList.cast?.count ?? 0)
            } else {
                completion(.failure(error!.localizedDescription))
            }
           
        }.resume()
    }
    
    func getActorBio(id: Int, completion: @escaping (MDBResult<ActorDetailsResponse>) -> Void) {
        let url = URL(string: "\(AppConstants.BaseURL)/person/\(id)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("\(AppConstants.accessToken)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        session.dataTask(with: urlRequest) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            let successRange = 200..<300
            if successRange.contains(statusCode) {
                let actorDetailsInfo : ActorDetailsResponse = try! JSONDecoder().decode(ActorDetailsResponse.self, from: data!)
                completion(.success(actorDetailsInfo))
                print(actorDetailsInfo.name ?? "")
            } else {
                completion(.failure(error!.localizedDescription))
            }
        }.resume()
    }
    
    func getMovieTrailerVideo(id: Int, completion: @escaping (MDBResult<MovieTrailerResponse>) -> Void) {
        let url = URL(string: "\(AppConstants.BaseURL)/movie/\(id)/videos")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("\(AppConstants.accessToken)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        session.dataTask(with: urlRequest) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            let successRange = 200..<300
            if successRange.contains(statusCode) {
                let trailer = try! JSONDecoder().decode(MovieTrailerResponse.self, from: data!)
                completion(.success(trailer))
                print(trailer.results!.count)
            } else {
                completion(.failure(error!.localizedDescription))
            }
        }.resume()
    }
    
    func getSimilarMovieList(id: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void) {
        let url = URL(string: "\(AppConstants.BaseURL)/movie/\(id)/similar")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("\(AppConstants.accessToken)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        session.dataTask(with: urlRequest) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            let successRange = 200..<300
            if successRange.contains(statusCode) {
                let movieList : MovieListResult = try! JSONDecoder().decode(MovieListResult.self, from: data!)
                completion(.success(movieList))
                print(movieList.results!.count)
            } else {
                completion(.failure(error!.localizedDescription))
            }
        }.resume()
    }
    
    func getMovieCreditById(id: Int, completion: @escaping (MDBResult<MovieActorResponse>) -> Void) {
        let url = URL(string: "\(AppConstants.BaseURL)/movie/\(id)/credits")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("\(AppConstants.accessToken)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        session.dataTask(with: urlRequest) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            let successRange = 200..<300
            if successRange.contains(statusCode) {
                let actorList: MovieActorResponse = try! JSONDecoder().decode(MovieActorResponse.self, from: data!)
                completion(.success(actorList))
                print(actorList.cast!.count)
            } else {
                completion(.failure(error!.localizedDescription))
            }
        }.resume()
    }
    
    func getSerieDetailById(id: Int, completion: @escaping (MDBResult<MovieDetailsResponse>) -> Void) {
//        let url = URL(string: "\(AppConstants.BaseURL)/person/\(id)/tv_credits")!
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "GET"
//        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
//        urlRequest.addValue("\(AppConstants.accessToken)", forHTTPHeaderField: "Authorization")
//
//        let session = URLSession.shared
//
//        session.dataTask(with: urlRequest) { data, response, error in
//        }.resume()
    }
    
    func getMovieDetailsInfo(id: Int, completion: @escaping (MDBResult<MovieDetailsResponse>) -> Void) {
        let url = URL(string: "\(AppConstants.BaseURL)/movie/\(id)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("\(AppConstants.accessToken)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        session.dataTask(with: urlRequest) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            let successRange = 200..<300
            if successRange.contains(statusCode) {
                let movieInfo: MovieDetailsResponse = try! JSONDecoder().decode(MovieDetailsResponse.self, from: data!)
                completion(.success(movieInfo))
                print(movieInfo.title ?? "undefined")
            } else {
                completion(.failure(error!.localizedDescription))
            }
        }.resume()
    }
    
    func getTopRatedMovieList(page: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void) {
        let url = URL(string: "\(AppConstants.BaseURL)/movie/top_rated?page=\(page)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("\(AppConstants.accessToken)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        session.dataTask(with: urlRequest) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            let successRange = 200..<300
            if successRange.contains(statusCode) {
                let topRatedList : MovieListResult = try! JSONDecoder().decode(MovieListResult.self, from: data!)
                completion(.success(topRatedList))
                print(topRatedList.results!.count)
            } else {
                completion(.failure(error!.localizedDescription))
            }
        }.resume()
    }
    
    func getGenreList(completion: @escaping (MDBResult<MovieGenreList>) -> Void) {
        let url = URL(string: "\(AppConstants.BaseURL)/genre/movie/list?language=en")
        var request = URLRequest(url: url!)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(AppConstants.accessToken)", forHTTPHeaderField: "Authorization")

        request.httpMethod = "GET"
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            let successRange = 200..<300
            if successRange.contains(statusCode) {
                let genreList = try! JSONDecoder().decode(MovieGenreList.self, from: data!)
                completion(.success(genreList))
                print(genreList.genres)
            } else {
                completion(.failure(error!.localizedDescription))
            }

        }
        .resume()
    }
    
    func getPopularTVList(completion: @escaping (MDBResult<MovieListResult>) -> Void) {
//        let url = URL(string: "\(AppConstants.BaseURL)/tv/popular")!
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "GET"
//        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
//        urlRequest.addValue("\(AppConstants.accessToken)", forHTTPHeaderField: "Authorization")
//
//        let session = URLSession.shared
//
//        session.dataTask(with: urlRequest) { data, response, error in
//            let statusCode = (response as! HTTPURLResponse).statusCode
//            let successRange = 200..<300
//            if successRange.contains(statusCode) {
//                let movieList: MovieListResult = try! JSONDecoder().decode(MovieListResult.self, from: data!)
//                completion(.success(movieList))
//                print(movieList.results!.count)
//            } else {
//                completion(.failure(error!.localizedDescription))
//            }
//        }.resume()
    }
    
    func getPopularMovieList(page: Int, completion: @escaping (MDBResult<MovieListResult>) -> Void) {
//        let url = URL(string: "\(AppConstants.BaseURL)/movie/popular?page=\(page)")!
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "GET"
//        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
//        urlRequest.addValue("\(AppConstants.accessToken)", forHTTPHeaderField: "Authorization")
//
//        let session = URLSession.shared
//
//        session.dataTask(with: urlRequest) { data, response, error in
//            let statusCode = (response as! HTTPURLResponse).statusCode
//            let successRange = 200..<300
//            if successRange.contains(statusCode) {
//                let popularList: MovieListResult = try! JSONDecoder().decode(MovieListResult.self, from: data!)
//                completion(.success(popularList))
//                print(popularList.results!.count)
//            } else {
//                completion(.failure(error!.localizedDescription))
//            }
//        }.resume()
    }
    
    func getUpcomingMovieList(page: Int, completion: @escaping (MDBResult<UpcomingMovieList>) -> Void) {
        let url = URL(string: "\(AppConstants.BaseURL)/movie/upcoming?page=\(page)")
        var urlRequest = URLRequest(url: url!)
        urlRequest.addValue("\(AppConstants.accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            let statusCode = (response as! HTTPURLResponse).statusCode
            let successRange = 200..<300
            if successRange.contains(statusCode) {
                if let data = data {
                    let upcomingMovieList = try! JSONDecoder().decode(UpcomingMovieList.self, from: data)
                    completion(.success(upcomingMovieList))
                    print(upcomingMovieList.results?.count ?? "")
                }
            } else {
                completion(.failure(error!.localizedDescription))
            }

        }
        .resume()
    }
    
    func getPeopleList(page: Int = 1, completion: @escaping (MDBResult<ActorListResult>) -> Void) {
//        let url = URL(string: "\(AppConstants.BaseURL)/person/popular?page=\(page)")!
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "GET"
//        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
//        urlRequest.addValue("\(AppConstants.accessToken)", forHTTPHeaderField: "Authorization")
//
//        let session = URLSession.shared
//
//        session.dataTask(with: urlRequest) { data, response, error in
//            let statusCode = (response as! HTTPURLResponse).statusCode
//            let successRange = 200..<300
//            if successRange.contains(statusCode) {
//                let actorList: ActorListResult = try! JSONDecoder().decode(ActorListResult.self, from: data!)
//                completion(.success(actorList))
//                print(actorList.results!.count)
//            } else {
//                completion(.failure(error!.localizedDescription))
//            }
//        }.resume()
    }
    
    func getPeopleListById(id: Int, completion: @escaping (MDBResult<MovieActorResponse>) -> Void) {
//        let url = URL(string: "\(AppConstants.BaseURL)/movie/\(id)/credits")!
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "GET"
//        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
//        urlRequest.addValue("\(AppConstants.accessToken)", forHTTPHeaderField: "Authorization")
//        
//        let session = URLSession.shared
//        
//        session.dataTask(with: urlRequest) { data, response, error in
//            let statusCode = (response as! HTTPURLResponse).statusCode
//            let successRange = 200..<300
//            if successRange.contains(statusCode) {
//                let peopleList : MovieActorResponse = try! JSONDecoder().decode(MovieActorResponse.self, from: data!)
//                completion(.success(peopleList))
//                print(peopleList.cast!.count)
//            } else {
//                completion(.failure(error!.localizedDescription))
//            }
//        }.resume()
    }
    
}
