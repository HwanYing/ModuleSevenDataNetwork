//
//  MoviewShowTimeTableViewCell.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/4/4.
//

import UIKit

class MoviewShowTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var viewForShowTime: UIView!
    @IBOutlet weak var seemoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        viewForShowTime.layer.cornerRadius = 8
//        viewForShowTime.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        seemoreLabel.underLineText(text: "SEE MORE")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

