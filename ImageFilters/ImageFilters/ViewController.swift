//
//  ViewController.swift
//  ImageFilters
//
//  Created by Nupur Mittal on 12/01/16.
//  Copyright © 2016 Bitjini. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var imageViewTarget: UIImageView!
    @IBOutlet weak var sliderBrightness: UISlider!
    @IBOutlet weak var sliderContrast: UISlider!
    
    var context = CIContext(options: nil)
    var filter : CIFilter!
    var sourceImage : CIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        applyImageFilter()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func applyImageFilter()
    {
       let img = imageViewTarget.image
        sourceImage = CIImage(image: img!)
        filter = CIFilter(name: "CIColorControls")
        filter.setValue(sourceImage, forKey: kCIInputImageKey)
    }
    
    @IBAction func sliderBrightnessValueChanged(sender: UISlider) {
        filter.setValue(sender.value, forKey: "inputBrightness")
        let cgImg = context.createCGImage(filter.outputImage!, fromRect: (filter.outputImage?.extent)!)
        let newImg = UIImage(CGImage: cgImg)
        imageViewTarget.image = newImg
    }
    
    @IBAction func sliderContrastValueChanged(sender: UISlider) {
        filter.setValue(sender.value, forKey: "inputContrast")
        let cgImg = context.createCGImage(filter.outputImage!, fromRect: (filter.outputImage?.extent)!)
        let newImg = UIImage(CGImage: cgImg)
        imageViewTarget.image = newImg
    }

}

