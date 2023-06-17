//
//  ShowCaseCollectionViewCell.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/4/4.
//

import UIKit

class ShowCaseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var contentTitle: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var imageViewPoster: UIImageView!
    
    var data: MovieResult? {
        didSet {
            if let data = data {
                let title = data.originalTitle ?? data.originalName
                let backdropPath = "\(AppConstants.baseImageUrl)\(data.backdropPath ?? "")"
                
                contentTitle.text = title
                labelReleaseDate.text = data.releaseDate
                imageViewPoster.sd_setImage(with: URL(string: backdropPath))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
