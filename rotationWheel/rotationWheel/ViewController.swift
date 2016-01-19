//
//  ViewController.swift
//  rotationWheel
//
//  Created by Nupur Mittal on 17/12/15.
//  Copyright © 2015 Bitjini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rotatingView: UIView!
           override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            let wheel = NSBundle.mainBundle().loadNibNamed("WheelView", owner: self, options: nil)[0] as! WheelView
            wheel.center = self.view.center
            self.view.addSubview(wheel)
            print(wheel.frame)
    }
}


