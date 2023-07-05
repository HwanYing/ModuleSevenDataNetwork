//
//  MovieSliderTableViewCell.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/4/4.
//

import UIKit

class MovieSliderTableViewCell: UITableViewCell {

    @IBOutlet weak var sliderPageControl: UIPageControl!
    @IBOutlet weak var mainSliderCollectionView: UICollectionView!
    var delegate: MovieItemDelegate?=nil
    
    var data: [MovieResult]? { // For upcoming movie result
        didSet {
            if let data = data {
                sliderPageControl.numberOfPages = data.count
                mainSliderCollectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mainSliderCollectionView.dataSource = self
        mainSliderCollectionView.delegate = self
        
        mainSliderCollectionView.registerCollectionCell(identifier: MovieSliderCollectionViewCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension MovieSliderTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCollectionCell(identifier: MovieSliderCollectionViewCell.identifier, indexPath: indexPath) as MovieSliderCollectionViewCell
        /// data
        cell.data = data?[indexPath.row]
        
        return cell
    }
}

extension MovieSliderTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 220)
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        sliderPageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        sliderPageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = data?[indexPath.row]
        delegate?.onTapMovieItem(id: item?.id ?? 0)
    }
}
