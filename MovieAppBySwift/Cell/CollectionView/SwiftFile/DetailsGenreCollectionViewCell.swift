//
//  DetailsGenreCollectionViewCell.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/4/7.
//

import UIKit

class DetailsGenreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var genreLabel: UILabel!
    
    var data: String?=nil {
        didSet {
            if let list = data {
                genreLabel.text = list
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
