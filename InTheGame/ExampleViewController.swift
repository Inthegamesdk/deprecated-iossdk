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
    var playerBottomConstraint: NSLayoutConstraint?

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
        view.translatesAutoresizingMaskIntoConstraints = false
        view.player = player
        view.playerLayer.frame = view.bounds

        playerView = view
        
        view.playerLayer.videoGravity = .resize
        view.playerLayer.needsDisplayOnBoundsChange = true
        playerLayer = view.playerLayer
        playerContainer.addSubview(view)
        
        view.topAnchor.constraint(equalTo: playerContainer.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: playerContainer.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: playerContainer.trailingAnchor).isActive = true
        
        playerBottomConstraint = view.bottomAnchor.constraint(equalTo: playerContainer.bottomAnchor, constant: 0)
        playerBottomConstraint?.isActive = true

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
    //called when the overlay shows a new activity
    func overlayWillOpenActivity(height: CGFloat) {
        playerBottomConstraint?.constant = -height
        UIView.animate(withDuration: 0.4) {
            self.playerContainer.layoutIfNeeded()
        }
    }
    
    //called when the overlay closes the current activity
    func overlayWillCloseActivity() {
        playerBottomConstraint?.constant = 0
        UIView.animate(withDuration: 0.4) {
            self.playerContainer.layoutIfNeeded()
        }
    }
    
    //the overlay will periodically call this method to get the updated video time
    func getVideoTime() -> Double {
        return playerLayer?.player?.currentTime().seconds ?? 0
    }
}
