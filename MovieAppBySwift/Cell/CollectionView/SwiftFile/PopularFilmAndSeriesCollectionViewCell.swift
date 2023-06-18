//
//  PopularFilmAndSeriesCollectionViewCell.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/4/4.
//

import UIKit

class PopularFilmAndSeriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var contentTitle: UILabel!
    @IBOutlet weak var imageViewBackdrop: UIImageView!
    @IBOutlet weak var ratingStar: RatingControl!
    @IBOutlet weak var labelRating: UILabel!
    var onTapItem : ((Int)->Void) = { _ in} // Closure

    var data: MovieResult? {
        didSet {
            if let data = data {
                let title = data.originalTitle ?? data.originalName
                let posterPath = "\(AppConstants.baseImageUrl)\(data.posterPath ?? "")"
                
                contentTitle.text = title
                imageViewBackdrop.sd_setImage(with: URL(string: posterPath))
                
                let voteAverage = data.voteAverage ?? 0.0
                let floorValue = floor(voteAverage * 10) / 10.0
                labelRating.text = "\(floorValue)" // api max - 10, me max - 5
                ratingStar.rating = Int(voteAverage * 0.5)
            }
        }
    }
    
    var tvCreditsList : TVCast? {
        didSet {
            if let tvCreditsList = tvCreditsList {
                let title = tvCreditsList.name ?? tvCreditsList.originalName
                let posterPath = "\(AppConstants.baseImageUrl)\(tvCreditsList.posterPath ?? "")"
                
                contentTitle.text = title
                imageViewBackdrop.sd_setImage(with: URL(string: posterPath))
                
                let voteAverage = tvCreditsList.voteAverage ?? 0.0
                labelRating.text = "\(voteAverage)" // api max - 10, me max - 5
                ratingStar.rating = Int(voteAverage * 0.5)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
