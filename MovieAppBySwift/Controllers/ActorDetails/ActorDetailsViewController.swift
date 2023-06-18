//
//  ActorDetailsViewController.swift
//  Jun17
//
//  Created by 梁世仪 on 2023/6/17.
//

import UIKit

class ActorDetailsViewController: UIViewController {

    private let networkAgent = MovieDBNetworkAgent.shared

    @IBOutlet weak var imgViewActor: UIImageView!
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var actorDOBLabel: UILabel!
    
    @IBOutlet weak var bioContentLabel: UILabel!
    @IBOutlet weak var readMoreView: UIView!
    
    @IBOutlet weak var tvCreditsCollectionView: UICollectionView!

    var actorId: Int = -1
    var tvCreditsList: TVCreditsResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tvCreditsCollectionView.delegate = self
        tvCreditsCollectionView.dataSource = self
        tvCreditsCollectionView.registerCollectionCell(identifier: PopularFilmAndSeriesCollectionViewCell.identifier)
        
        // Do any additional setup after loading the view.
        print("details for this actor id>>>>", actorId)

        fetchActorBio(actorId: actorId)
        fetchTVCredits(actorId: actorId)
    }
    
    private func bindData(data: ActorDetailsResponse) {
        
        let posterPath = "\(AppConstants.baseImageUrl)\(data.profilePath ?? "")"
        imgViewActor.sd_setImage(with: URL(string: posterPath))
        actorNameLabel.text = data.name
        actorDOBLabel.text = data.birthday
        bioContentLabel.text = data.biography
        
    }

    // get actor bio
    func fetchActorBio(actorId: Int) {
        networkAgent.getActorBio(actorId: actorId) { data in
            self.bindData(data: data)
        } failure: { error in
            print(error)
        }

    }
    // get tv credits list
    func fetchTVCredits(actorId: Int) {
        networkAgent.getTVCreditsList(id: actorId) { data in
            self.tvCreditsList = data
            self.tvCreditsCollectionView.reloadData()
        } failure: { error in
            print(error)
        }

    }
}
extension ActorDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvCreditsList?.cast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCollectionCell(identifier: PopularFilmAndSeriesCollectionViewCell.identifier, indexPath: indexPath) as PopularFilmAndSeriesCollectionViewCell
        cell.tvCreditsList = tvCreditsList?.cast?[indexPath.row]
        return cell
    }
    
    
}
extension ActorDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 130, height: collectionView.frame.height)
        
    }
}
