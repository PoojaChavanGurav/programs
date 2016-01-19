//
//  WheelView.swift
//  rotationWheel
//
//  Created by Nupur Mittal on 14/01/16.
//  Copyright © 2016 Bitjini. All rights reserved.
//

import UIKit

class WheelView: UIView {

    @IBOutlet var collectionButtons: [UIButton]!
    var top = 1
    var position = [1,2,3,4,5]
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        self.frame = CGRect(x: (UIScreen.mainScreen().bounds.width - 320)/2 , y: UIScreen.mainScreen().bounds.height/2 - UIScreen.mainScreen().bounds.width/2 , width: 320, height: 320)
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = self.frame.width/2
        self.drawWheel()
    }
    
    func drawWheel()
    {
        for button in collectionButtons
        {
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.blackColor().CGColor
            button.layer.cornerRadius = 40
        }
    }

    @IBAction func buttonRotate(sender: UIButton) {
        
        var pos = 0
        for var i=0;i<5;i++
        {
            if position[i] == sender.tag
            {
                pos = i
                break
            }
        }
        var angle :CGFloat = 0.0
        UIView.beginAnimations(nil , context: nil)
        UIView.setAnimationDuration(0.2)
        
        switch pos
        {
        case 1: angle = -1.2567
        case 2: angle = -2.5132
        case 3: angle = 2.5132
        case 4: angle = 1.2567
        default: angle = 0
        }
        
        let rotation :CGAffineTransform = CGAffineTransformRotate(self.transform, angle)
        self.transform = rotation
        
        for button in collectionButtons
        {
            let buttonRotation :CGAffineTransform = CGAffineTransformRotate(button.transform, -angle)
            button.transform = buttonRotation
            
        }
        
        top = sender.tag
        for var i=0;i<5;i++
        {
            if top == 6
            {
                top = 1
            }
            position[i] = top++
        }
    }
}
