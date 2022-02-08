//
//  ViewController.swift
//  FastplayDemo
//
//  Created by Tiago Lira Pereira on 02/07/2020.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var goButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goButton.clipsToBounds = true
        goButton.layer.cornerRadius = 6
    }
}
