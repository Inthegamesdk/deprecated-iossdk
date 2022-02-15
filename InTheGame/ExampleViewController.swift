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
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var playButton: UIButton!
    
    var overlay: ITGOverlayView!
    var playerLayer: AVPlayerLayer?
    var playerView: AVPlayerView?
    var playerBottomConstraint: NSLayoutConstraint?
    var seeking = false
    var sliderTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureControls()
        loadVideoPlayer()
        loadOverlay()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        sliderTimer?.invalidate()
        sliderTimer = nil
        super.viewDidDisappear(animated)
    }
    
    func loadOverlay() {
        //load the ITG overlay over your video player
        let view = ITGOverlayView(channelID: channelID, broadcasterName: broadcaster, environment: .devDefault, delegate: self, showMenu: true)
        
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
    
    func overlayPause() {
        playerLayer?.player?.pause()
    }
    
    func overlayResume() {
        playerLayer?.player?.play()
    }
}

//MARK: - Video and controls
extension ExampleViewController {
    
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
        
        playButton.isSelected = true
        slider.value = 0
        if (playerLayer?.player?.currentItem?.status == .readyToPlay) {
            slider.maximumValue = Float(item.duration.seconds)
        }

        NotificationCenter.default.addObserver(self, selector:#selector(playerDidFinishPlaying(note:)),name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: playerLayer?.player?.currentItem)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapVideo(gesture:)))
        playerView?.addGestureRecognizer(gesture)
        
        if sliderTimer == nil {
            self.sliderTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                DispatchQueue.main.async {
                    self.updateSliderTime()
                }
            })
        }
    }
    
    @IBAction func actionPlay(_ sender: Any) {
        guard let player = self.playerLayer?.player else { return }
        if (player.timeControlStatus == .playing) {
            player.pause()
            (sender as? UIButton)?.isSelected = false
        } else if (player.currentItem?.status == .readyToPlay) {
            player.play()
            (sender as? UIButton)?.isSelected = true
        }
    }
    
    @objc func didTapVideo(gesture:UITapGestureRecognizer) {
        controlView.isHidden = !controlView.isHidden
        if (!controlView.isHidden) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.controlView.isHidden = true
            }
        }
    }
    
    @IBAction func actionSlider(_ sender: UISlider) {
        let time = Double(sender.value)
        seeking = true
        playerLayer?.player?.seek(to: CMTime(seconds: time, preferredTimescale: 1), completionHandler: { (ok) in
            self.seeking = false
        })

    }
    @objc func playerDidFinishPlaying(note: NSNotification) {
        playButton.isSelected = false
        slider.value = 0
    }
    
    func updateSliderTime() {
        guard let player = playerLayer?.player else { return }

        if (player.currentItem?.status == .readyToPlay) {
            let duration = Float(player.currentItem?.duration.seconds ?? 0)
            if self.slider.maximumValue != duration && duration > 0 {
                self.slider.maximumValue = duration
            }
        }
        if (player.timeControlStatus == .playing && self.slider.state == .normal && !self.seeking) {
            self.slider.setValue(Float(player.currentTime().seconds), animated: false)
        }
    }
    
    func configureControls() {
        controlView.layer.cornerRadius = 8
        let image = UIImage(named: "thumb")
        slider.setThumbImage(image, for: .normal)
        slider.setThumbImage(image, for: .highlighted)
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool { return true }
}
