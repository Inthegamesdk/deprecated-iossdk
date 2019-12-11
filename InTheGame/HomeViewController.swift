//
//  HomeViewController.swift
//  InTheGameDemo
//
//  Created by Tiago Lira on 02/12/2019.
//  Copyright © 2019 inthegame. All rights reserved.
//

import UIKit
import InTheGameSDK

let exampleVideoURL = URL(string: "https://media.inthegame.io/uploads/videos/itgdemo5clips.mp4?123123")!

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openFullscreenVideo(_ sender: Any) {
        let controller = ITGPlayerViewController.instantiate(videoURL: exampleVideoURL)
        present(controller, animated: true, completion: nil)
    }
}
