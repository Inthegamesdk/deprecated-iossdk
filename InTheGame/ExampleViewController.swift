//
//  OverlayExampleViewController.swift
//  InTheGame
//
//  Created by Tiago Lira Pereira on 25/03/2021.
//  Copyright © 2021 In The Game. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Inthegamemobile

let broadcaster = "demos"
let channelID = "soccer_predictions"
let language = "en"
let videoURL = "https://media2.inthegame.io/uploads/videos/streamers/278dee276f8d43d11dad3030d0aa449e.a4ef1c02ad73f7b5ed0a6df3809abf12.mp4"


class ExampleViewController: UIViewController {
    @IBOutlet weak var playerContainer: UIView!
    
    var overlay: ITGOverlayView!
    var playerLayer: AVPlayerLayer?
    var playerView: AVPlayerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadVideoPlayer()
        loadOverlay()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func loadVideoPlayer() {
        let asset = AVAsset(url: URL(string: videoURL)!)
        let item = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: item)
        let view = AVPlayerView(frame: playerContainer.bounds)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        view.player = player
        view.playerLayer.frame = view.bounds

        playerView = view
        
        view.playerLayer.videoGravity = .resizeAspect
        view.playerLayer.needsDisplayOnBoundsChange = true
        playerLayer = view.playerLayer
        playerContainer.addSubview(view)

        player.play()
    }
    
    func loadOverlay() {
        //load the ITG overlay over your video player
        let view = ITGOverlayView(channelID: channelID, broadcasterName: broadcaster, environment: .devDefault, delegate: self)
        view.frame = playerContainer.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        playerContainer.addSubview(view)
        
        overlay = view
    }
    
    deinit {
        playerView?.removeFromSuperview()
        playerLayer = nil
        playerView = nil
        overlay = nil
    }
    
    @IBAction func actionClose(_ sender: Any) {
        dismiss(animated: true, completion:nil)
    }
}

extension ExampleViewController: ITGOverlayDelegate {
    
    func getVideoTime() -> Double {
        return playerLayer?.player?.currentTime().seconds ?? 0
    }
}
