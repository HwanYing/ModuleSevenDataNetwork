//
//  ViewController.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/4/3.
//

import UIKit

class MainMovieViewController: UIViewController, MovieItemDelegate, ActorActionDelegate {
   
    @IBOutlet var movieListTableView: UITableView!
    
    private let networkAgent = MovieDBNetworkAgent.shared
    
    private var upcomingMovieList : UpcomingMovieList?
    private var popularMovieList: MovieListResult?
    private var popularTVList: MovieListResult?
    private var genreMovieList: MovieGenreList?
    
    private var showCaseMovieList: MovieListResult?
    private var bestActorList: ActorListResult?
    
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
  
    
    // upcoming movie
    func fetchUpcomingMovieList() {
        networkAgent.getUpcomingMovieList { data in
            self.upcomingMovieList = data
            // UI update
            self.movieListTableView.reloadSections(IndexSet(integer: MovieType.MOVIE_SLIDER.rawValue), with: .automatic)
            
        } failure: { error in
            print(error.description)
        }
    }
    // popular movie
    func fetchPopularMovieList() {
        networkAgent.getPopularMovieList { data in
            
            self.popularMovieList = data
            self.movieListTableView.reloadSections(IndexSet(integer: MovieType.MOVIE_POPULAR.rawValue), with: .automatic)

        } failure: { error in
            print(error.description)
        }

    }
    // popular tv series
    func fetchPopularTVSeriesList() {
        networkAgent.getPopularTVList { data in
            
            self.popularTVList = data
            self.movieListTableView.reloadSections(IndexSet(integer: MovieType.SERIES_POPULAR.rawValue), with: .automatic)
            
        } failure: { error in
            print(error.description)
        }
    }
    // genre list
    func fetchMovieGenreList() {
        networkAgent.getGenreList { data in
            
            self.genreMovieList = data
            self.movieListTableView.reloadSections(IndexSet(integer: MovieType.MOVIE_GENRE.rawValue), with: .automatic)
            
        } failure: { error in
            print(error.description)
        }
    }
    // top rated
    func fetchTopRatedMovieList() {
        networkAgent.getTopRatedMovieList { data in
            self.showCaseMovieList = data
            self.movieListTableView.reloadSections(IndexSet(integer: MovieType.MOVIE_SHOWCASES.rawValue), with: .automatic)
        } failure: { error in
            print(error.description)
        }

    }
    // get best actor
    func fetchBestMovieActorList() {
        networkAgent.getPeopleList { data in
            self.bestActorList = data
            self.movieListTableView.reloadSections(IndexSet(integer: MovieType.MOVIE_BEST_ACTORS.rawValue), with: .automatic)
        } failure: { error in
            print(error.description)
        }

    }
   
}
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

            return cell
        case MovieType.MOVIE_SHOWCASES.rawValue:
            let cell = tableView.dequeueCell(identifier: ShowCaseTableViewCell.identifier, indexPath: indexPath) as ShowCaseTableViewCell
            cell.data = showCaseMovieList
            return cell
        case MovieType.MOVIE_BEST_ACTORS.rawValue:
            let cell = tableView.dequeueCell(identifier: BestActorsTableViewCell.identifier, indexPath: indexPath) as BestActorsTableViewCell
            cell.delegate = self
            cell.data = bestActorList
            return cell
        default:
            return UITableViewCell()
        }
    }
}

