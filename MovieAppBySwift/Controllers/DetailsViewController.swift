//
//  DetailsViewController.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/4/6.
//

import UIKit

class DetailsViewController: UIViewController {
    
    let networkAgent = MovieDBNetworkAgent.shared

    @IBOutlet weak var ivBack: UIImageView!
    
    @IBOutlet weak var rateMovieButton: UIButton!
    
    @IBOutlet weak var similarMovieCollectionView: UICollectionView!
    @IBOutlet weak var moreCreatorsLabel: UILabel!
    @IBOutlet weak var collectionViewActors: UICollectionView!
    @IBOutlet weak var productionCompanyCollectionView: UICollectionView!
    
    let genreLists = ["Family", "Fantasy", "Adventure"]
    
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    @IBOutlet weak var imageViewMoviePoster: UIImageView!
    @IBOutlet weak var labelReleasedYear: UILabel!
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var viewRatingCount: RatingControl!
    @IBOutlet weak var labelVoteCount: UILabel!
    
    @IBOutlet weak var labelAboutMovieTitle: UILabel!
    @IBOutlet weak var labelGenreString: UILabel!
    @IBOutlet weak var labelProductionCountries: UILabel!
    @IBOutlet weak var labelMovieDescription: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    
    @IBOutlet weak var btnPlayTrailer: UIButton!
    
    // story line
    @IBOutlet weak var storyContentLabel: UILabel!
    private var productionCompanies : [ProductionCompany] = []
    
    var movieDetailsInfo: MovieDetailsResponse?
    var actorData: MovieActorResponse?
    var actorList: [Cast] = []
    var genreList: [String] = []
    var similarMovieList: [MovieResult] = []
    var movieID: Int = -1
    private var movieTrailers: [MovieTrailer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
        print("details for this movie id>>>>", movieID)
        // movie details
        fetchMovieDetailsInfo(id: movieID)
        fetchMovieActorData(id: movieID)
        fetchSimilarMovies(id: movieID)
        fetchMovieTrailer(id: movieID)
    }
    
    private func initView() {
        setUpCollectionViewCells()
        addGestureRecognizers()
        
        rateMovieButton.layer.cornerRadius = 20
        rateMovieButton.layer.borderColor = UIColor.white.cgColor
        rateMovieButton.layer.borderWidth = 2
        
        self.btnPlayTrailer.isHidden = true
    }
    
    private func setUpCollectionViewCells() {
        collectionViewActors.delegate = self
        collectionViewActors.dataSource = self
        collectionViewActors.registerCollectionCell(identifier: BestActorsCollectionViewCell.identifier)
        
        productionCompanyCollectionView.delegate = self
        productionCompanyCollectionView.dataSource = self
        productionCompanyCollectionView.registerCollectionCell(identifier: ProductionCollectionViewCell.identifier)
        
        similarMovieCollectionView.dataSource = self
        similarMovieCollectionView.delegate = self
        similarMovieCollectionView.registerCollectionCell(identifier: PopularFilmAndSeriesCollectionViewCell.identifier)
        
        genreCollectionView.dataSource = self
        genreCollectionView.delegate = self
        genreCollectionView.registerCollectionCell(identifier: DetailsGenreCollectionViewCell.identifier)
        
    }
    
    private func addGestureRecognizers() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onTapBack))
        ivBack.isUserInteractionEnabled = true
        ivBack.addGestureRecognizer(gesture)
    }
    // movie Trailer
    private func fetchMovieTrailer(id: Int) {
        networkAgent.getMovieTrailerVideo(id: id) { data in
            
            self.movieTrailers = data.results ?? []
            self.btnPlayTrailer.isHidden = self.movieTrailers.isEmpty
            
        } failure: { error in
            
            print(error.description)
        }

    }
    // similar movie data
    private func fetchSimilarMovies(id: Int) {
        networkAgent.getSimilarMovieList(id: id) { data in
            self.similarMovieList = data.results ?? []
            self.similarMovieCollectionView.reloadData()
        } failure: { error in
            print(error.description)
        }

    }
    // movie details
    private func fetchMovieDetailsInfo(id: Int){
        networkAgent.getMovieDetailsInfo(id: id) { data in
            self.bindData(data: data)
        } failure: { error in
            print(error.description)
        }
    }
    // movie actor
    private func fetchMovieActorData(id: Int) {
        networkAgent.getPeopleListById(id: id) { data in
            self.actorData = data
            self.actorList = data.cast ?? []
            self.collectionViewActors.reloadData()
            print("Actor count>>>>>", self.actorList.count)
        } failure: { error in
            print(error.description)
        }

    }
    @IBAction func onClickPlayTrailer(_ sender: UIButton) {
        // play trailer
        let item = movieTrailers.first
        let youtubeVdoKey = item?.key
        let playerVC = YoutubePlayerViewController()
        playerVC.youtubeId = youtubeVdoKey
        self.present(playerVC, animated: true)
    }
    // bind data
    private func bindData(data: MovieDetailsResponse) {
        productionCompanies = data.productionCompanies ?? [ProductionCompany]()
        productionCompanyCollectionView.reloadData()
        
        let posterPath = "\(AppConstants.baseImageUrl)\(data.backdropPath ?? "")"
        imageViewMoviePoster.sd_setImage(with: URL(string: posterPath))
        
        labelReleasedYear.text = String(data.releaseDate?.split(separator: "-")[0] ?? "")
        labelMovieTitle.text = data.originalTitle
        
        let runtimeHour = Int((data.runtime ?? 0) / 60)
        let runtimeMinute = Int((data.runtime ?? 0) % 60)
        
        labelDuration.text = "\(runtimeHour)hr \(runtimeMinute)mins"
        
        labelRating.text = String(data.voteAverage ?? 0)
        viewRatingCount.rating = Int((data.voteAverage ?? 0.0) * 0.5)
        labelVoteCount.text = "\(data.voteCount ?? 0) votes"
        
        labelAboutMovieTitle.text = data.originalTitle
        
        var genrelistStr = ""
        data.genres?.map { genreName in
            genrelistStr += genreName.name + ", "
            genreList.append(genreName.name)
        }
        genrelistStr.removeLast()
        genrelistStr.removeLast()

        genreCollectionView.reloadData()
        
        // data.genres?.map({ $0.name }).reduce(""){ "\($0 ?? ""), \($1)"}
        labelGenreString.text = genrelistStr
        
        var countrylist = ""
        data.productionCountries?.map { item in
            countrylist += "\(item.name ?? ""), "
        }
        if !countrylist.isEmpty {
            countrylist.removeLast()
            countrylist.removeLast()
        }

        labelProductionCountries.text = countrylist
        labelMovieDescription.text = data.overview
        labelReleaseDate.text = data.releaseDate
        
        // storyline
        storyContentLabel.text = data.overview
    }
    @objc func onTapBack() {
        dismiss(animated: true, completion: nil)
    }
    func onTapFavourite(isFavourite: Bool) {
        print("Tap for favourite list.....\(isFavourite)")
    }
}
extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == genreCollectionView {
            return genreList.count
        } else if collectionView == productionCompanyCollectionView{
            return productionCompanies.count
        } else if collectionView == collectionViewActors {
            return actorList.count
        } else if collectionView == similarMovieCollectionView {
            return similarMovieList.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == genreCollectionView {
            let cell = collectionView.dequeueCollectionCell(identifier: DetailsGenreCollectionViewCell.identifier, indexPath: indexPath) as DetailsGenreCollectionViewCell
            cell.data = genreList[indexPath.row]
            return cell
        } else if collectionView == productionCompanyCollectionView {
            let cell = collectionView.dequeueCollectionCell(identifier: ProductionCollectionViewCell.identifier, indexPath: indexPath) as ProductionCollectionViewCell
            cell.data = productionCompanies[indexPath.row]
            return cell
        } else if collectionView == collectionViewActors {
            let cell = collectionView.dequeueCollectionCell(identifier: BestActorsCollectionViewCell.identifier, indexPath: indexPath) as BestActorsCollectionViewCell
//            cell.delegate = self
            cell.data = actorData?.cast?[indexPath.row]
            return cell
        } else if collectionView == similarMovieCollectionView {
            let cell = collectionView.dequeueCollectionCell(identifier: PopularFilmAndSeriesCollectionViewCell.identifier, indexPath: indexPath) as PopularFilmAndSeriesCollectionViewCell
            cell.data = similarMovieList[indexPath.row]
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == genreCollectionView {
            return CGSize(width: widthOfString(text: genreList[indexPath.row], font: UIFont(name: "Geeza Pro Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)) + 24, height: 30)
        
        } else if collectionView == collectionViewActors {
            
            return CGSize(width: 130, height: collectionView.frame.height)
            
        } else if collectionView == productionCompanyCollectionView {
            
            let itemWidth : CGFloat = 100
            let itemHeight = itemWidth
            return CGSize(width: itemWidth, height: itemHeight)
            
        } else if collectionView == similarMovieCollectionView {
            
            return CGSize(width: 130, height: collectionView.frame.height)
            
        } else {
            return CGSize.zero
        }
    }
    func widthOfString(text: String, font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font : font]
        let textSize = text.size(withAttributes: fontAttributes)
        return textSize.width
    }
}

