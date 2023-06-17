//
//  GenreCollectionViewCell.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/4/4.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tabLineView: UIView!
    @IBOutlet weak var genreLabel: UILabel!
    var onTapItem : ((Int)->Void) = { _ in} // Closure
    
    var data: GenreVO?=nil {
        didSet {
            if let genre = data {
                genreLabel.text = genre.name.uppercased()
                (genre.isSelected) ? (tabLineView.isHidden = false) : (tabLineView.isHidden = true)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapItem))
        containerView.addGestureRecognizer(tapGesture)
    }
    @objc func didTapItem() {
        onTapItem(data?.id ?? 0)
    }
}
