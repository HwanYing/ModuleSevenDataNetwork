//
//  YoutubePlayerViewController.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/6/14.
//

import UIKit
import YouTubePlayer

class YoutubePlayerViewController: UIViewController {

    @IBOutlet var videoPlayer: YouTubePlayerView!

    var youtubeId: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let id = youtubeId {
            videoPlayer.loadVideoID(id)
            videoPlayer.play()
        } else {
            // invalid yutube id
            print("Invalid Youtube ID")
        }
    }
    
    @IBAction func onClickDimiss(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
