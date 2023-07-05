//
//  ViewController.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/4/3.
//

import UIKit

class MainMovieViewController: UIViewController, ActorActionDelegate {
   
    //MARK: - IBOutlet
    @IBOutlet var movieListTableView: UITableView!
    
    //MARK: - Property
//    private let networkAgent = MovieDBNetworkAgent.shared
//    private let movieModel: MovieModel = MovieModelImpl.shared
    
    private let movieModel1: MovieModel1 = MovieModelImpl1.shared
//    private let networkAgent = MovieDBNetworkAgentWithURLSession.shared
    private let actorModel: ActorModel = ActorModelImpl.shared
    
    private var upcomingMovieList : [MovieResult]?
    private var popularMovieList: [MovieResult]?
    private var popularTVList: [MovieResult]?
    private var genreMovieList: [MovieGenre]?
    
    private var showCaseMovieList: [MovieResult]?
    private var bestActorList: [ActorInfoResponse]?
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableViewCell()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "")
        
        fetchUpcomingMovieList()
        fetchPopularMovieList()
        fetchPopularTVSeriesList()
        fetchMovieGenreList()
        
        fetchTopRatedMovieList()
        fetchBestMovieActorList()
    }
    // MARK: - Init View
    private func setUpTableViewCell() {
        movieListTableView.dataSource = self
        movieListTableView.registerForCell(identifier: MovieSliderTableViewCell.identifier)
        movieListTableView.registerForCell(identifier: PopularFilmAndSeriesTableViewCell.identifier)
        movieListTableView.registerForCell(identifier: MoviewShowTimeTableViewCell.identifier)
        movieListTableView.registerForCell(identifier: GenreTableViewCell.identifier)
        movieListTableView.registerForCell(identifier: ShowCaseTableViewCell.identifier)
        movieListTableView.registerForCell(identifier: BestActorsTableViewCell.identifier)
    }
    
   
    func onTapFavourite(isFavourite: Bool) {
        print("onTap favourite")
    }
    
//    func onTapSeeMoreActor(data: ActorListResult) {
//        navigateToViewMoreActorsViewController(data: data)
//    }
    
    @IBAction func clickSearch(_ sender: UIBarButtonItem) {
        navigateToSearchMovieVC()
    }
    
    func onTapActorImage(actorId: Int) {
        navigateToActorDetailsViewController(actorId: actorId)
    }
  
    //MARK: - API Methods
    // upcoming movie
    func fetchUpcomingMovieList() {
        movieModel1.getUpcomingMovieList { (result) in

            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.upcomingMovieList = data
                    self.movieListTableView.reloadSections(IndexSet(integer: MovieType.MOVIE_SLIDER.rawValue), with: .automatic)
                }
            case .failure(let error):
                print(error)
            }
        }
//        movieModel.getUpcomingMovieList(page: 1) { [weak self] (result) in
//            guard let self = self else { return }
//            switch result {
//            case .success(let data):
//                DispatchQueue.main.async {
//                    self.upcomingMovieList = data.convertToMovieListResult()
//                    // UI update
//                    self.movieListTableView.reloadSections(IndexSet(integer: MovieType.MOVIE_SLIDER.rawValue), with: .automatic)
//                }
//
//            case .failure(let error):
//                print(error)
//            }
//
//        }
    }
    // popular movie
    func fetchPopularMovieList() {
        movieModel1.getPopularMovieList { (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.popularMovieList = data
                    self.movieListTableView.reloadSections(IndexSet(integer: MovieType.MOVIE_POPULAR.rawValue), with: .automatic)
                }
            case .failure(let error):
                print(error)
            }
            }
        }
//        movieModel.getPopularMovieList(page: 1) { [weak self] (result) in
//            guard let self = self else { return }
//            switch result {
//            case .success(let data):
//                DispatchQueue.main.async {
//                    self.popularMovieList = data
//                    self.movieListTableView.reloadSections(IndexSet(integer: MovieType.MOVIE_POPULAR.rawValue), with: .automatic)
//                }
//
//            case .failure(let error):
//                print(error)
//            }
//        }

//    }
    // popular tv series
    func fetchPopularTVSeriesList() {
        movieModel1.getPopularSeriesList { (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.popularTVList = data
                    self.movieListTableView.reloadSections(IndexSet(integer: MovieType.SERIES_POPULAR.rawValue), with: .automatic)
                }
            case .failure(let error):
                print(error.description)
            }
        }
//        movieModel.getPopularTVList { [weak self] (result) in
//            guard let self = self else { return }
//            switch result {
//            case .success(let data):
//                DispatchQueue.main.async {
//                    self.popularTVList = data
//                    self.movieListTableView.reloadSections(IndexSet(integer: MovieType.SERIES_POPULAR.rawValue), with: .automatic)
//                }
//            case .failure(let error):
//                print(error.description)
//            }
//
//        }
    }
    // genre list
    func fetchMovieGenreList() {
        movieModel1.getGenreList { (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.genreMovieList = data
                    self.movieListTableView.reloadSections(IndexSet(integer: MovieType.MOVIE_GENRE.rawValue), with: .automatic)
                }
            case .failure(let message):
                print(message)
            }
        }
//        movieModel.getGenreList { [weak self] (result) in
//            guard let self = self else { return }
//            switch result {
//            case .success(let data):
//                DispatchQueue.main.async {
//                    self.genreMovieList = data
//                    self.movieListTableView.reloadSections(IndexSet(integer: MovieType.MOVIE_GENRE.rawValue), with: .automatic)
//                }
//            case .failure(let message):
//                print(message)
//            }
//
//        }
    }
    // top rated
    func fetchTopRatedMovieList() {
        // [MovieResult]
        movieModel1.getTopRatedMovieList(page: 1) { (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.showCaseMovieList = data
                    self.movieListTableView.reloadSections(IndexSet(integer: MovieType.MOVIE_SHOWCASES.rawValue), with: .automatic)
                }
            case .failure(let error):
                print(error)
            }
        }
        
       
//        movieModel.getTopRatedMovieList(page: 1) { [weak self] (result) in
//            guard let self = self else { return }
//            switch result {
//            case .success(let data):
//                DispatchQueue.main.async {
//                    self.showCaseMovieList = data
//                    self.movieListTableView.reloadSections(IndexSet(integer: MovieType.MOVIE_SHOWCASES.rawValue), with: .automatic)
//                }
//            case .failure(let error):
//                print(error)
//            }
//
//        }

    }
    // get best actor
    func fetchBestMovieActorList() {
        actorModel.getPopularPeople(page: 1) { (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.bestActorList = data
                    self.movieListTableView.reloadSections(IndexSet(integer: MovieType.MOVIE_BEST_ACTORS.rawValue), with: .automatic)
                }
            case .failure(let error):
                print(error)
            }        }
      
//        movieModel.getPeopleList(page: 1) { [weak self] (result) in
//            guard let self = self else { return }
//            switch result {
//            case .success(let data):
//                DispatchQueue.main.async {
//                    self.bestActorList = data
//                    self.movieListTableView.reloadSections(IndexSet(integer: MovieType.MOVIE_BEST_ACTORS.rawValue), with: .automatic)
//                }
//            case .failure(let error):
//                print(error)
//            }
//
//        }
    }
   
}
//MARK: - MovieItemDelegate
extension MainMovieViewController: MovieItemDelegate {
    func onTapMovieItem(id: Int) {
        navigateToMovieDetailsVC(movieId: id)
    }
    
//    func onTapViewMore(data: MovieListResult) {
//        self.navigateToMoreTopRatedViewController(data: data)
//    }
    
    func onTapMovie(id: Int, type: VideoType) {
        switch type {
        case .movie:
            navigateToMovieDetailsVC(movieId: id)
        case .series:
            navigateToSeriesDetailsVC(id: id)
        }
    }
}

//MARK: - UITableViewDataSource
extension MainMovieViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case MovieType.MOVIE_SLIDER.rawValue:
            let cell = tableView.dequeueCell(identifier: MovieSliderTableViewCell.identifier, indexPath: indexPath) as MovieSliderTableViewCell
            cell.delegate = self
            // data - 1
            cell.data = upcomingMovieList
            return cell
        case MovieType.MOVIE_POPULAR.rawValue:
            let cell = tableView.dequeueCell(identifier: PopularFilmAndSeriesTableViewCell.identifier, indexPath: indexPath) as PopularFilmAndSeriesTableViewCell
            cell.delegate = self
            cell.data = popularMovieList
            cell.type = VideoType.movie
            cell.titleLabel.text = "popular movies".uppercased()
            // 1....
           
            return cell
        case MovieType.SERIES_POPULAR.rawValue:
            let cell = tableView.dequeueCell(identifier: PopularFilmAndSeriesTableViewCell.identifier, indexPath: indexPath) as PopularFilmAndSeriesTableViewCell
            cell.delegate = self
            cell.titleLabel.text = "popular series".uppercased()
            cell.type = VideoType.series
            // 1....
            cell.data = popularTVList
       
            return cell
        case MovieType.MOVIE_SHOWTIME.rawValue:
            return tableView.dequeueCell(identifier: MoviewShowTimeTableViewCell.identifier, indexPath: indexPath)
        case MovieType.MOVIE_GENRE.rawValue:
            let cell = tableView.dequeueCell(identifier: GenreTableViewCell.identifier, indexPath: indexPath) as GenreTableViewCell
            
            var allMovieList: [MovieResult] = []
//            allMovieList.append(contentsOf: upcomingMovieList?.results ?? [MovieResult]())
//            allMovieList.append(contentsOf: popularMovieList?.results ?? [MovieResult]())
//            allMovieList.append(contentsOf: popularTVList?.results ?? [MovieResult]())
            allMovieList.append(contentsOf: upcomingMovieList ?? [MovieResult]())
            allMovieList.append(contentsOf: popularMovieList ?? [MovieResult]())
            allMovieList.append(contentsOf: popularTVList ?? [MovieResult]())
            cell.allMoviesAndSeries = allMovieList
            
            let resultData: [GenreVO]? = genreMovieList?.map({ movieGenre in
                return movieGenre.convertToGenreVO()
            })
            resultData?.first?.isSelected = true
            cell.genreList = resultData
            cell.onTapGenreMovie = { [weak self] movieId in
                guard let self = self else { return }
                self.onTapMovie(id: movieId, type: .movie)
            }
            return cell
        case MovieType.MOVIE_SHOWCASES.rawValue:
            let cell = tableView.dequeueCell(identifier: ShowCaseTableViewCell.identifier, indexPath: indexPath) as ShowCaseTableViewCell
            cell.data = showCaseMovieList
            cell.onTapViewMore = { data in
//                self.navigateToMoreTopRatedViewController(data: data)
            }
            cell.onTapMovieItem = { movieId in
                self.navigateToMovieDetailsVC(movieId: movieId)
            }
            return cell
        case MovieType.MOVIE_BEST_ACTORS.rawValue:
            let cell = tableView.dequeueCell(identifier: BestActorsTableViewCell.identifier, indexPath: indexPath) as BestActorsTableViewCell
//            cell.delegate = self
            cell.data = bestActorList
            
            cell.onClickActorView = { actorId in
                self.navigateToActorDetailsViewController(actorId: actorId)
            }
            
            cell.onTapViewMore = { data in
                self.navigateToViewMoreActorsViewController(data: ActorListResult(page: 1, results: data, totalPages: self.actorModel.totalPageActorList, totalResults: 20))
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}

