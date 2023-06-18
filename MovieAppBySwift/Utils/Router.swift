//
//  Router.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/4/6.
//

import Foundation
import UIKit

enum StoryBoardName: String {
    case Main = "Main"
    case Authentication = "Authentication"
    case LaunchScreen = "LaunchScreen"
}

extension UIStoryboard {
    static func mainStoryBoard() -> UIStoryboard {
        UIStoryboard(name: StoryBoardName.Main.rawValue, bundle: nil)
    }
}

extension UIViewController {
    
    func navigateToSearchContentViewController() {
        let vc = VIewMoreActorViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToViewMoreActorsViewController(data: ActorListResult) {
        let vc = VIewMoreActorViewController()
        vc.initData = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToActorDetailsViewController(actorId: Int) {
        let vc = ActorDetailsViewController()
        vc.actorId = actorId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToMovieDetailsVC(movieId: Int) {
      
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: DetailsViewController.identifier) as? DetailsViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.movieID = movieId
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true)
    }
    
}

