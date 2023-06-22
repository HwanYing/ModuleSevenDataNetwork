//
//  ViewController.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/4/3.
//

import UIKit

class MainMovieViewController: UIViewController, MovieItemDelegate, ActorActionDelegate {
   
    //MARK: - IBOutlet
    @IBOutlet var movieListTableView: UITableView!
    
    //MARK: - Property
    private let networkAgent = MovieDBNetworkAgent.shared
    
    private var upcomingMovieList : UpcomingMovieList?
    private var popularMovieList: MovieListResult?
    private var popularTVList: MovieListResult?
    private var genreMovieList: MovieGenreList?
    
    private var showCaseMovieList: MovieListResult?
    private var bestActorList: ActorListResult?
    
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
    
    func onTapMovieItem(id: Int) {
        navigateToMovieDetailsVC(movieId: id)
    }
    
    func onTapFavourite(isFavourite: Bool) {
        print("onTap favourite")
    }
    
    func onTapSeeMoreActor(data: ActorListResult) {
        navigateToViewMoreActorsViewController(data: data)
    }
    
    @IBAction func clickSearch(_ sender: UIBarButtonItem) {
        navigateToSearchMovieVC()
    }
    
    func onTapActorImage(actorId: Int) {
        navigateToActorDetailsViewController(actorId: actorId)
    }
  
    //MARK: - API Methods
    // upcoming movie
    func fetchUpcomingMovieList() {
        networkAgent.getUpcomingMovieList(page: 1) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.upcomingMovieList = data
                // UI update
                self.movieListTableView.reloadSections(IndexSet(integer: MovieType.MOVIE_SLIDER.rawValue), with: .automatic)
            case .failure(let error):
                print(error)
            }
           
        }
    }
    // popular movie
    func fetchPopularMovieList() {
        networkAgent.getPopularMovieList(page: 1) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.popularMovieList = data
                self.movieListTableView.reloadSections(IndexSet(integer: MovieType.MOVIE_POPULAR.rawValue), with: .automatic)
            case .failure(let error):
                print(error)
            }
        }

    }
    // popular tv series
    func fetchPopularTVSeriesList() {
        networkAgent.getPopularTVList { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.popularTVList = data
                self.movieListTableView.reloadSections(IndexSet(integer: MovieType.SERIES_POPULAR.rawValue), with: .automatic)
            case .failure(let error):
                print(error.description)
            }
           
        }
    }
    // genre list
    func fetchMovieGenreList() {
        networkAgent.getGenreList { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.genreMovieList = data
                self.movieListTableView.reloadSections(IndexSet(integer: MovieType.MOVIE_GENRE.rawValue), with: .automatic)
            case .failure(let message):
                print(message)
            }
        
        }
    }
    // top rated
    func fetchTopRatedMovieList() {
        networkAgent.getTopRatedMovieList(page: 1) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.showCaseMovieList = data
                self.movieListTableView.reloadSections(IndexSet(integer: MovieType.MOVIE_SHOWCASES.rawValue), with: .automatic)
            case .failure(let error):
                print(error)
            }
            
        }

    }
    // get best actor
    func fetchBestMovieActorList() {
        networkAgent.getPeopleList { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.bestActorList = data
                self.movieListTableView.reloadSections(IndexSet(integer: MovieType.MOVIE_BEST_ACTORS.rawValue), with: .automatic)
            case .failure(let error):
                print(error)
            }
            
        }
    }
   
}
//MARK: - MovieItemDelegate
//extension MainMovieViewController: MovieItemDelegate {
//    func onTapViewMore(data: MovieListResult) {
//        self.navigateToViewMoreActorsViewController(data: data)
//    }
//
//    func onTapMovie(id: Int, type: VideoType) {
//        switch type {
//        case .movie:
//            navigateToMovieDetailsVC(movieId: id)
//        case .series:
//            navigateToSeriesDetailsVC(id: id)
//        }
//    }
//}

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
            cell.titleLabel.text = "popular movies".uppercased()
            // 1....
            cell.data = popularMovieList
            return cell
        case MovieType.SERIES_POPULAR.rawValue:
            let cell = tableView.dequeueCell(identifier: PopularFilmAndSeriesTableViewCell.identifier, indexPath: indexPath) as PopularFilmAndSeriesTableViewCell
            cell.delegate = self
            cell.titleLabel.text = "popular series".uppercased()
            // 1....
            cell.data = popularTVList
            return cell
        case MovieType.MOVIE_SHOWTIME.rawValue:
            return tableView.dequeueCell(identifier: MoviewShowTimeTableViewCell.identifier, indexPath: indexPath)
        case MovieType.MOVIE_GENRE.rawValue:
            let cell = tableView.dequeueCell(identifier: GenreTableViewCell.identifier, indexPath: indexPath) as GenreTableViewCell
            
            var allMovieList: [MovieResult] = []
            allMovieList.append(contentsOf: upcomingMovieList?.results ?? [MovieResult]())
            allMovieList.append(contentsOf: popularMovieList?.results ?? [MovieResult]())
            allMovieList.append(contentsOf: popularTVList?.results ?? [MovieResult]())
            cell.allMoviesAndSeries = allMovieList
            
            let resultData: [GenreVO]? = genreMovieList?.genres.map({ movieGenre in
                return movieGenre.convertToGenreVO()
            })
            resultData?.first?.isSelected = true
            cell.genreList = resultData
//            cell.onTapGenreMovie = { [weak self] movieId in
//                guard let self = self else { return }
//                self.onTapMovieItem(id: movieId, type: .movie)
//            }
            return cell
        case MovieType.MOVIE_SHOWCASES.rawValue:
            let cell = tableView.dequeueCell(identifier: ShowCaseTableViewCell.identifier, indexPath: indexPath) as ShowCaseTableViewCell
            cell.data = showCaseMovieList
            return cell
        case MovieType.MOVIE_BEST_ACTORS.rawValue:
            let cell = tableView.dequeueCell(identifier: BestActorsTableViewCell.identifier, indexPath: indexPath) as BestActorsTableViewCell
            cell.delegate = self
            cell.data = bestActorList
            
//            cell.onClickActorView = { actorId in
//                self.navigateToActorDetailsViewController(actorId: actorId)
//            }
//            cell.onClickViewMore = { data in
//                self.navigateToViewMoreActorsViewController(data: data)
//            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}

