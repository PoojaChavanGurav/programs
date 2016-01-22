//
//  LayoutView.swift
//  BeautifulGrids
//  Created by Nupur Mittal on 31/12/15.
//  Copyright © 2015 Bitjini. All rights reserved.
//

protocol ImageSelection
{
    // delegate to load the Image picker 
    func callImagePicker(indx :Int)
}

import UIKit

class SingleElement: UIView,UIScrollViewDelegate{
    // Class to create a indivisual element of the grid which will load the image, zoom it and scroll it. The selected image can even be changed 
    
    @IBOutlet weak var scrollImage: UIScrollView!
    @IBOutlet weak var buttonAdd: UIButton!
    var selectedImage :UIImage!
    var doubleTapRecogniser = UITapGestureRecognizer()
    var longPressRecogniser = UILongPressGestureRecognizer()
    var isDelegate : ImageSelection?
    var img :UIImage!
    var imageEdit = UIImageView()
    var sourceImage = CIImage()
    var filter :CIFilter!
    var context = CIContext(options: nil)

    override func awakeFromNib() {
        scrollImage.hidden = true
        self.layer.borderWidth = 1  
        self.layer.borderColor = UIColor.whiteColor().CGColor
        addDoubleTapRecogniser()
        addLongPressRecogniser()
    }

    
    func addDoubleTapRecogniser()
    {
        // Open the Image picker to select a different image on double tap
        
        doubleTapRecogniser = UITapGestureRecognizer(target: self, action: "ScrollViewDoubleTap:")
        doubleTapRecogniser.numberOfTapsRequired = 2
        doubleTapRecogniser.numberOfTouchesRequired = 1
        scrollImage.addGestureRecognizer(doubleTapRecogniser)
    }
    
    func ScrollViewDoubleTap(sender : UITapGestureRecognizer)
    {
        isDelegate?.callImagePicker(self.tag)
    }

    func addLongPressRecogniser()
    {
        // Highlight the single element with blue border on 3 seconds of hold
        
        longPressRecogniser = UILongPressGestureRecognizer(target: self, action: "ScrollViewLongPress:")
        longPressRecogniser.minimumPressDuration = 0.3
        scrollImage.addGestureRecognizer(longPressRecogniser)
        
    }
    
    func ScrollViewLongPress(sender : UILongPressGestureRecognizer)
    {
        let parentView = self.superview
        for item in (parentView?.subviews)!
        {
            item.layer.borderColor = UIColor.whiteColor().CGColor
        }
        parentView?.bringSubviewToFront(self)
        self.layer.borderColor = UIColor.blueColor().CGColor
        
    }
    func addFilters()
    {
        let imgTemp = self.imageEdit.image
        sourceImage = CIImage(image: imgTemp!)!
        filter = CIFilter(name: "CIColorControls")
    }
    @IBAction func ButtonAdd(sender: UIButton)
    {
        // call the image picker to select an image on click of the button
        isDelegate?.callImagePicker(sender.tag)
    }
    
    func reloadNib()
    {
        // Assign the selected image on the scroll view to be zoomed
        scrollImage.delegate = self
        scrollImage.hidden = false
        assignImage()
        addFilters()
        assignZoom()
        centerZoomedImage()
    }
    func assignImage()
    {
        scrollImage.zoomScale = 1
        imageEdit.image = img
        scrollImage.contentSize = (img.size)
        imageEdit.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: img.size)
        scrollImage.addSubview(imageEdit)
    }
    
    func assignZoom()
    {
        let scaleHeight = scrollImage.frame.height / scrollImage.contentSize.height
        let scaleWidth = scrollImage.frame.width / scrollImage.contentSize.width
        scrollImage.minimumZoomScale = min(scaleHeight,scaleWidth)
        scrollImage.maximumZoomScale = 1
        scrollImage.zoomScale = max(scaleHeight,scaleWidth)
    }
    
    
    func centerZoomedImage()
    {
        var imageFrame = imageEdit.frame
        imageFrame.origin.x = 0.0
        imageFrame.origin.y = 0.0
        imageEdit.frame = imageFrame
    }
    
    
    //MARK: - Scroll view delegate methods 
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageEdit
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerZoomedImage()
    }
    
    
    func setPadding(padding :CGFloat)
    {
        // set the borderWidth of this frame + the parent frame
        self.layer.borderWidth = padding
    }
    
    func setCornerRadius(radius : CGFloat)
    {
        // Function to set corner radius to half of the height or width depending on which is smallest.
        if radius <= min(self.frame.width/2,self.frame.height/2)
        {
            self.layer.cornerRadius = radius
            self.scrollImage.layer.cornerRadius = radius
            self.imageEdit.layer.cornerRadius = radius
        }
    }
    
    func setBrightness(bright :NSNumber)
    {
        filter.setValue(bright, forKey: "inputBrightness")
        filter?.setValue(sourceImage, forKey: kCIInputImageKey)
        let cgImg = context.createCGImage(filter!.outputImage!, fromRect: (filter!.outputImage?.extent)!)
        self.imageEdit.image = UIImage(CGImage: cgImg)
    }
    
    func setRotatation()
    {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.imageEdit.transform = CGAffineTransformRotate(self.imageEdit.transform,CGFloat(M_PI_2))
            self.imageEdit.frame = self.frame
        }
        
    }
}