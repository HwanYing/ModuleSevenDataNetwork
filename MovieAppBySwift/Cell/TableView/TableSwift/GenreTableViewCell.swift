//
//  GenreTableViewCell.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/4/4.
//

import UIKit

class GenreTableViewCell: UITableViewCell {

    @IBOutlet var genreCollectionView: UICollectionView!
    @IBOutlet var movieCollectionView: UICollectionView!
//    let genreList = [GenreVO(name: "ACTION", isSelected: true),GenreVO(name: "DRAMA", isSelected: false), GenreVO(name: "HORROR", isSelected: false), GenreVO(name: "TRIlLER", isSelected: false), GenreVO(name: "MAGIC", isSelected: false), GenreVO(name: "ADVENTUREEEEEE", isSelected: false), GenreVO(name: "BIOGRAPHY", isSelected: false)]
    var genreList: [GenreVO]? {
        didSet {
            if let _ = genreList {
                genreCollectionView.reloadData()

                genreList?.removeAll(where: { genreVO -> Bool in
                    let genreID = genreVO.id
                    
                    let results = movieListByGenre.filter { (key, value) -> Bool in
                        genreID == key
                    }
                    
                    return results.count == 0
                })

            }
            onTapGenre(genreId: genreList?.first?.id ?? 0)

        }
    }
    
    var allMoviesAndSeries : [MovieResult]? {
        didSet {
            // computation
            allMoviesAndSeries?.forEach { movieSeries in
                movieSeries.genreIDS?.forEach({ genreId in
                    let key = genreId
                    if var _ = movieListByGenre[key] {
                        movieListByGenre[key]!.insert(movieSeries)
                    } else {
                        movieListByGenre[key] = [movieSeries]
                    }
                })
            }
            onTapGenre(genreId: genreList?.first?.id ?? 0)
        }
    }
    
    private var selectedMovieList: [MovieResult] = [MovieResult]()
    
    private var movieListByGenre: [Int: Set<MovieResult>] = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpCollectionViewCells()
    }
    private func setUpCollectionViewCells() {
        genreCollectionView.dataSource = self
        genreCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        
        genreCollectionView.registerCollectionCell(identifier: GenreCollectionViewCell.identifier)
        movieCollectionView.registerCollectionCell(identifier: PopularFilmAndSeriesCollectionViewCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension GenreTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == movieCollectionView {
            return selectedMovieList.count
        }
        return genreList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == movieCollectionView {
           let cell = collectionView.dequeueCollectionCell(identifier: PopularFilmAndSeriesCollectionViewCell.identifier, indexPath: indexPath) as PopularFilmAndSeriesCollectionViewCell
            // 2...
            
            cell.data = selectedMovieList[indexPath.row]
            return cell
        } else {
            
            let cell = collectionView.dequeueCollectionCell(identifier: GenreCollectionViewCell.identifier, indexPath: indexPath) as GenreCollectionViewCell
            cell.data = genreList?[indexPath.row]
            cell.onTapItem = { genreId in
                self.genreList?.forEach { genreVO in
                    if genreId == genreVO.id {
                        genreVO.isSelected = true
                    } else {
                        genreVO.isSelected = false
                    }
                }
                let movieList = self.movieListByGenre[genreId]
                self.selectedMovieList = movieList?.map({  $0  }) ?? [MovieResult]()
                
                self.genreCollectionView.reloadData()
                self.movieCollectionView.reloadData()
            }
            return cell
        }
    }
    private func onTapGenre(genreId: Int){
        self.genreList?.forEach { genreVO in
            if genreId == genreVO.id {
                genreVO.isSelected = true
            } else {
                genreVO.isSelected = false
            }
        }
        let movieList = self.movieListByGenre[genreId]
        self.selectedMovieList = movieList?.map({  $0  }) ?? [MovieResult]()
        
        self.genreCollectionView.reloadData()
        self.movieCollectionView.reloadData()
    }
    
}
extension GenreTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == movieCollectionView {
            return CGSize(width: 130, height: collectionView.frame.height)
        }
        return CGSize(width: widthOfString(text: genreList?[indexPath.row].name ?? "", font: UIFont(name: "Geeza Pro Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)) + 24, height: 45)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 15
//    }
    
    func widthOfString(text: String, font: UIFont) -> CGFloat {
//        let fontAttributes = [NSAttributedString.Key.font : font]
//        let textSize = text.size(withAttributes: fontAttributes)
//        return textSize.width
        return text.size(withAttributes: [NSAttributedString.Key.font: font]).width

    }
}
