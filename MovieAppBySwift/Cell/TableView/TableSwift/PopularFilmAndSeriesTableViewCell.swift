//
//  PopularFilmAndSeriesTableViewCell.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/4/4.
//

import UIKit

class PopularFilmAndSeriesTableViewCell: UITableViewCell {
  
    @IBOutlet weak var popularCollectionView: UICollectionView!
    var delegate: MovieItemDelegate?=nil
    @IBOutlet weak var titleLabel : UILabel!
    // 2....
    var data: MovieListResult? {
        didSet {
            if let _ = data {
                popularCollectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        popularCollectionView.dataSource = self
        popularCollectionView.delegate = self
        popularCollectionView.registerCollectionCell(identifier: PopularFilmAndSeriesCollectionViewCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
extension PopularFilmAndSeriesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCollectionCell(identifier: PopularFilmAndSeriesCollectionViewCell.identifier, indexPath: indexPath) as PopularFilmAndSeriesCollectionViewCell
        cell.data = data?.results?[indexPath.row]
        return cell
        
    }
}
extension PopularFilmAndSeriesTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 130, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = data?.results?[indexPath.row]
        delegate?.onTapMovieItem(id: item?.id ?? 0)
    }
}