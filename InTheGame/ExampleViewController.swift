//
//  ExampleViewController.swift
//  InTheGameDemo
//
//  Created by Tiago Lira on 25/11/2019.
//  Copyright © 2019 inthegame. All rights reserved.
//


import UIKit
import InTheGameSDK

class ExampleViewController: UIViewController {

    @IBOutlet weak var videoContainer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //instantiate the ITGPlayerView
        let playerView = ITGPlayerView.instantiate(videoURL: exampleVideoURL, broadcasterName: broadcaster, devMode: false)
        //set up the frame or contraints
        playerView.frame = videoContainer.bounds
        playerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        playerView.translatesAutoresizingMaskIntoConstraints = true
        //add as subview
        videoContainer.addSubview(playerView)

        adjustNavigationBar()
        NotificationCenter.default.addObserver(self, selector: #selector(adjustNavigationBar), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @objc func adjustNavigationBar() {
        let isLandscape = UIDevice.current.orientation.isLandscape
        navigationController?.setNavigationBarHidden(isLandscape, animated: true)
    }
}
