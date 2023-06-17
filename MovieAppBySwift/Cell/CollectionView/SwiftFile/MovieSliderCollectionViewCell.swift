//
//  MovieSliderCollectionViewCell.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/4/4.
//

import UIKit
import SDWebImage

class MovieSliderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var contentTitle: UILabel!
    @IBOutlet weak var imageViewBackDrop: UIImageView!
    
    var data: MovieResult? {
        didSet {
            if let data = data {
                let title = data.originalTitle
                let backDropPath = "\(AppConstants.baseImageUrl)\(data.backdropPath ?? "")"
                
                contentTitle.text = title
                
                imageViewBackDrop.sd_setImage(with: URL(string: backDropPath))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
