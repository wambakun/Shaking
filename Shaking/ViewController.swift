//
//  ViewController.swift
//  Shaking
//
//  Created by DSMacbook on 04/10/19.
//  Copyright © 2019 DSMacbook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var btnView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //btnView.isUserInteractionEnabled = true
        btnView.isUserInteractionEnabled = true
        btnView.layer.cornerRadius = 50
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.addPulse))
        
        tapGestureRecognizer.numberOfTapsRequired = 1
        btnView.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func addPulse(){
        let pulse = Pulsing(numberOfPulse: 2, radius: 180, Position: btnView.center)
        
        pulse.animationDuration = 1.0
        self.view.layer.insertSublayer(pulse, below: btnView.layer)
        
        print("add Button Action after pulse")
        
        // TODO: Add Button action after pulse
        
        
    }


}

