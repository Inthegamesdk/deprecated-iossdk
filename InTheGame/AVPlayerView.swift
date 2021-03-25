//
//  AVPlayerView.swift
//  InTheGame
//
//  Created by Tiago Lira Pereira on 25/03/2021.
//  Copyright © 2021 In The Game. All rights reserved.
//

import UIKit
import AVFoundation

class AVPlayerView: UIView {
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }

        set {
            playerLayer.player = newValue
        }
    }

    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }

    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}

