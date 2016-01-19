//
//  CanvasView.swift
//  BeautifulGrids
//
//  Created by Nupur Mittal on 05/01/16.
//  Copyright © 2016 Bitjini. All rights reserved.
//

import UIKit

class CanvasView: UIView , UIScrollViewDelegate{
    
    var arrayGridData = []
    var arrayOfElements :[SingleElement?] = []
    var singleTapRegogniser = UITapGestureRecognizer()
    var arrayNodeData :NSArray!
    
    @IBOutlet weak var scrollViewCanvas: UIScrollView!
    var slider = UISlider()
    override func awakeFromNib() {
        self.backgroundColor = UIColor.whiteColor()
        self.frame = CGRect(x: 0,
            y: (UIScreen.mainScreen().bounds.height/2 - (UIScreen.mainScreen().bounds.width/2)),
            width: UIScreen.mainScreen().bounds.width,
            height: UIScreen.mainScreen().bounds.width)

        self.setLayout()
        self.setSlider()
        self.initCanvas()
        self.addSingleTapRecogniser()
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.backgroundColor = UIColor.yellowColor()
        
    }
    
    func initCanvas(){
        // Load the the Grid Plist
        if let path = NSBundle.mainBundle().pathForResource("Grids", ofType: "plist"){
            let gridData = NSDictionary(contentsOfFile: path)
            arrayGridData = gridData![CanvasSetting.canvasPattern] as! NSArray!
            getGridNodes()
    }
}
    
    func setLayout()
    {
        switch CanvasSetting.canvasPattern
        {
            case "portrait":
                scrollViewCanvas.contentSize = CGSizeMake(scrollViewCanvas.frame.width, scrollViewCanvas.frame.width*2)
                scrollViewCanvas.showsVerticalScrollIndicator = true
                scrollViewCanvas.showsHorizontalScrollIndicator = false
                break
            case "landscape":
                scrollViewCanvas.contentSize = CGSizeMake(scrollViewCanvas.frame.width*2, scrollViewCanvas.frame.width)
                scrollViewCanvas.showsVerticalScrollIndicator = false
                scrollViewCanvas.showsHorizontalScrollIndicator = true
                break
            case "mugs":
                scrollViewCanvas.contentSize = CGSizeMake(scrollViewCanvas.frame.width*2, scrollViewCanvas.frame.width)
                scrollViewCanvas.showsVerticalScrollIndicator = false
                scrollViewCanvas.showsHorizontalScrollIndicator = true
                break
        default:
                 scrollViewCanvas.contentSize = CGSizeMake(scrollViewCanvas.frame.width, scrollViewCanvas.frame.width)
                 scrollViewCanvas.showsVerticalScrollIndicator = false
                 scrollViewCanvas.showsHorizontalScrollIndicator = false
                break
        }
    }
    
    func setSlider()
    {
        switch CanvasSetting.canvasPattern
        {
        case "portrait":
            slider.frame = CGRect(x: 0, y: 0, width: scrollViewCanvas.frame.width, height: 30)
            slider.transform = CGAffineTransformRotate(slider.transform, CGFloat(M_PI_2))
            break
        case "landscape":
            slider.frame = CGRect(x: 30 , y: scrollViewCanvas.bounds.origin.y, width: scrollViewCanvas.frame.width, height: 30)
            print(scrollViewCanvas.frame.origin.x)
            print(scrollViewCanvas.frame.width*2)
            break
        case "mugs":
            slider.frame = CGRect(x: scrollViewCanvas.bounds.origin.x, y: scrollViewCanvas.bounds.origin.y , width: scrollViewCanvas.frame.width, height: 30)
            break
        default:
            break
        }
        slider.addTarget(self, action: "sliderValueChanged:", forControlEvents: .ValueChanged)
        slider.minimumValue = 0.0
        slider.maximumValue = Float(slider.frame.width)
        self.addSubview(slider)
    }
    
    func sliderValueChanged(sender : UISlider)
    {
        switch CanvasSetting.canvasPattern
        {
        case "landscape" :
            scrollViewCanvas.contentOffset = CGPointMake(CGFloat(sender.value), 0.0)
            break
        case "portrait" :
            scrollViewCanvas.contentOffset = CGPointMake(0.0, CGFloat(sender.value))
            break
        case "mugs":
            scrollViewCanvas.contentOffset = CGPointMake(CGFloat(sender.value), 0.0)
            break
        default:
            break
        }
    }
    
    //MARK: Scroll View delegates
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        switch CanvasSetting.canvasPattern
        {
        case "landscape" :
            slider.value = Float(scrollView.contentOffset.x)
            break
        case "portrait" :
            slider.value = Float(scrollView.contentOffset.y)
            break
        default:
            break
        }
    }
    func getGridNodes(){
        // Place each item of the selected grid into proper position depending on the plist entry
        arrayNodeData = arrayGridData[CanvasSetting.canvasGrid] as! NSArray
        var i = 0
        for vertex in arrayNodeData
        {
            let nib = (NSBundle.mainBundle().loadNibNamed("SingleElement", owner: nil, options: nil)[0] as! SingleElement)
            nib.buttonAdd.tag = i
            nib.tag = i
            i++
            var X = CGFloat(vertex["x"] as! Double)
            var Y = CGFloat(vertex["y"] as! Double)
            var W = CGFloat(vertex["w"] as! Double)
            var H = CGFloat(vertex["h"] as! Double)
//            X = self.frame.width * X
//            W = self.frame.width * W
//            Y = self.frame.height * Y
//            H = self.frame.height * H
            X = self.scrollViewCanvas.contentSize.width * X
            Y = self.scrollViewCanvas.contentSize.height * Y
            W = self.scrollViewCanvas.contentSize.width * W
            H = self.scrollViewCanvas.contentSize.height * H 
            nib.frame = CGRect(x: X, y: Y, width: W, height: H)
            arrayOfElements.append(nib)
            scrollViewCanvas.addSubview(nib)
        }
        
    }
    
    func addSingleTapRecogniser()
    {
        // To deselect the highlighted element on single click
        singleTapRegogniser = UITapGestureRecognizer(target: self, action: "singleTapRecogniser:")
        singleTapRegogniser.numberOfTapsRequired = 1
        singleTapRegogniser.numberOfTouchesRequired = 1
        self.addGestureRecognizer(singleTapRegogniser)
    }
    
    func singleTapRecogniser(sender : UITapGestureRecognizer)
    {
        for item in self.subviews
        {
            item.layer.borderColor = UIColor.whiteColor().CGColor
        }
    }

   }
