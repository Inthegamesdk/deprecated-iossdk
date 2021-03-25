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
import InTheGameSDK

class OverlayExampleViewController: UIViewController {
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
        playerLayer?.player?.removeObserver(self, forKeyPath: "timeControlStatus")
        playerLayer?.player = nil
        playerLayer?.removeFromSuperlayer()
        
        let asset = AVAsset(url: exampleVideoURL)
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
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapVideo))
        playerView?.addGestureRecognizer(gesture)
    }

    @objc func didTapVideo() {
        print("DID TAP VIDEO AREA")
    }
    
    func loadOverlay() {
        //load the ITG overlay over your video player
        let view = ITGOverlayView(videoURL: exampleVideoURL, broadcasterName: broadcaster, devMode: false)
        view.frame = playerContainer.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        playerContainer.addSubview(view)
        overlay = view

//        overlay.setAspectRatio(22/9)
    }
    
    deinit {
        playerView?.removeFromSuperview()
        playerLayer = nil
        playerView = nil
        overlay = nil
    }
    
    @IBAction func actionPlay(_ sender: Any) {
        playerLayer?.player?.play()
        overlay.videoPlaying()
    }
    
    @IBAction func actionPause(_ sender: Any) {
        playerLayer?.player?.pause()
        overlay.videoPaused()
    }
    
    @IBAction func actionForward(_ sender: Any) {
        let time = playerLayer?.player?.currentTime().seconds ?? 100
        playerLayer?.player?.seek(to: CMTime(seconds: time + 20, preferredTimescale: 1), completionHandler: { (success) in
            if let seconds = self.playerLayer?.player?.currentTime().seconds {
                self.overlay.updateVideoTime(seconds: seconds)
            }
        })
        
    }
}
