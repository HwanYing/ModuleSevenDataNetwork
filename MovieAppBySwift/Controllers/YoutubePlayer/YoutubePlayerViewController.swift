//
//  YoutubePlayerViewController.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/6/14.
//

import UIKit
import youtube_ios_player_helper

class YoutubePlayerViewController: UIViewController, YTPlayerViewDelegate {

    @IBOutlet var videoPlayer: YTPlayerView!

    var youtubeId: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let id = youtubeId {
            videoPlayer.load(withVideoId: id)
//            videoPlayer.load(withVideoId: id, playerVars: ["playsinline": 1])
            
        } else {
            // invalid yutube id
            print("Invalid Youtube ID")
        }
    }
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        videoPlayer.playVideo()
    }
    @IBAction func onClickDimiss(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
