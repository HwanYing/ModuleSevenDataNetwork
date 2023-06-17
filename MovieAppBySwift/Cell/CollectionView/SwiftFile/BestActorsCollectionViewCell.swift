//
//  BestActorsCollectionViewCell.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/4/5.
//

import UIKit

class BestActorsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var heartImage: UIImageView!
    
    @IBOutlet weak var heartFullImage: UIImageView!
    @IBOutlet weak var labelActorName: UILabel!
    @IBOutlet weak var labelVotePopularity: UILabel!
    @IBOutlet weak var imageViewActorProfile: UIImageView!
    
    var delegate: ActorActionDelegate?=nil
    // from main view controller
    var mainActorData: ActorInfoResponse? {
        didSet {
            if let mainActorData = mainActorData {
                let nameTitle = mainActorData.name ?? "undefined"
                let backdropPath = "\(AppConstants.baseImageUrl)\(mainActorData.profilePath ?? "")"
                
                labelActorName.text = nameTitle
                labelVotePopularity.text = "You Like \(Int(mainActorData.popularity ?? 0)) Movies".uppercased()
                imageViewActorProfile.sd_setImage(with: URL(string: backdropPath))
            }
        }
    }
    // cast for movie result
    var data: Cast? {
        didSet {
            if let data = data {
                let nameTitle = data.name ?? "undefined"
                let backdropPath = "\(AppConstants.baseImageUrl)\(data.profilePath ?? "")"

                labelActorName.text = nameTitle
                labelVotePopularity.text = "You Like \(Int(data.popularity ?? 0)) Movies".uppercased()
                imageViewActorProfile.sd_setImage(with: URL(string: backdropPath))
            }
        }
    }
    
    var data1: ActorInfoResponse? {
        didSet {
            if let data1 = data1 {
                let nameTitle = data1.name ?? "undefined"
                let backdropPath = "\(AppConstants.baseImageUrl)\(data1.profilePath ?? "")"
                
                labelActorName.text = nameTitle
                labelVotePopularity.text = "You Like \(Int(data1.popularity ?? 0)) Movies".uppercased()
                imageViewActorProfile.sd_setImage(with: URL(string: backdropPath))
            }
        }
    }
    // movie creator
    var creatorData: SimilarMovie? {
        didSet {
            if let creatorData = creatorData {
                let nameTitle = creatorData.title ?? "undefined"
                let backdropPath = "\(AppConstants.baseImageUrl)\(creatorData.posterPath ?? "")"
                
                labelActorName.text = nameTitle
                labelVotePopularity.text = "You Like \(Int(creatorData.popularity ?? 0)) Movies".uppercased()
                imageViewActorProfile.sd_setImage(with: URL(string: backdropPath))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initGestureRecognizers()
    }
    private func initGestureRecognizers() {
        let tapImageGesture = UITapGestureRecognizer(target: self, action: #selector(doTapUnfavourite))
        heartImage.isUserInteractionEnabled = true
        heartImage.addGestureRecognizer(tapImageGesture)
        
        let tapImageGesture1 = UITapGestureRecognizer(target: self, action: #selector(doTapFavourite))
        heartFullImage.isUserInteractionEnabled = true
        heartFullImage.addGestureRecognizer(tapImageGesture1)
        
    }
    @objc func doTapFavourite() {
        heartImage.isHidden = false
        heartFullImage.isHidden = true
        delegate?.onTapFavourite(isFavourite: true)
    }
    @objc func doTapUnfavourite() {
        heartImage.isHidden = true
        heartFullImage.isHidden = false
        delegate?.onTapFavourite(isFavourite: false)
    }
}
