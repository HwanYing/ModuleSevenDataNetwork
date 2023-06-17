//
//  ProductionCollectionViewCell.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/6/7.
//

import UIKit

class ProductionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageViewCompany: UIImageView!
    @IBOutlet weak var labelCompanyName: UILabel!
    
    var data: ProductionCompany? {
        didSet {
            if let data = data {
                let urlStr = "\(AppConstants.baseImageUrl)\(data.logoPath ?? "")"
                imageViewCompany.sd_setImage(with: URL(string: urlStr))
                if data.logoPath == nil || data.logoPath!.isEmpty {
                    labelCompanyName.text = data.name
                } else {
                    labelCompanyName.text = ""
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
