//
//  HomeViewController.swift
//  InTheGameDemo
//
//  Created by Tiago Lira on 02/12/2019.
//  Copyright © 2019 inthegame. All rights reserved.
//

import UIKit
import InTheGameSDK

let exampleVideoURL = URL(string: "https://api-dev.inthegame.io/uploads/videos/streamers/a64706dd0f42356e93d299075940c456.857ecbb7a131f9bb4940a6b8ad5ec70e.mp4")!
let broadcaster = "orlandofcchannel"

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openFullscreenVideo(_ sender: Any) {
        let controller = ITGPlayerViewController.instantiate(videoURL: exampleVideoURL, broadcasterName: broadcaster, devMode: false)
        present(controller, animated: true, completion: nil)
    }
}
