//
//  nextViewController.swift
//  BeautifulGrids
//
//  Created by Nupur Mittal on 30/12/15.
//  Copyright © 2015 Bitjini. All rights reserved.
//

import UIKit

class nextViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,ImageSelection
{
    var selectedImage :UIImage!
    var imgPick = UIImagePickerController()
    var canvasNib :CanvasView?
    var buttonTag = 0
    var indicator = false
    @IBOutlet weak var sliderBorderWidth: UISlider!
    @IBOutlet weak var sliderCornerRadius: UISlider!
    
    @IBOutlet weak var sliderBrightness: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgPick.delegate = self
        sliderCornerRadius.maximumValue = Float(self.view.frame.width)
        self.setLayoutView()
        
    }
    override func viewDidLayoutSubviews() {
        canvasNib?.frame = CGRectMake(0, self.view.frame.height/2 - self.view.frame.width/2, self.view.frame.width,  self.view.frame.width)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if !indicator
        {
            indicator = true
            canvasNib?.setLayout()
            canvasNib?.setSlider()
            canvasNib?.initCanvas()
            for item in (canvasNib?.arrayOfElements)!
            {
                item?.isDelegate = self
            }
            
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   func setLayoutView()
   {
        // Load the CanvasView on the Temp view
        canvasNib = (NSBundle.mainBundle().loadNibNamed("CanvasView", owner: nil, options: nil)[0] as! CanvasView)
        self.view.addSubview(canvasNib!)

    }
    
    //MARK: - ImageSelection delegate methods
    
    func callImagePicker(indx :Int)
    {
        buttonTag = indx
        getActionSheet()
    }

    
    func getActionSheet()
    {
        let alert = UIAlertController(title: "Select Image", message: "", preferredStyle: .ActionSheet)
        let photoAction = UIAlertAction(title: "Photo", style: .Default, handler: {(alert:UIAlertAction!) -> Void in
        self.getPhoto()
        })
        let cameraAction = UIAlertAction(title: "Camera", style: .Default, handler: {(alert:UIAlertAction!)-> Void in
        self.getCamera()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil )
        alert.addAction(photoAction)
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    func getPhoto()
    {
        imgPick.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imgPick, animated: true, completion: nil)

    }
    func getCamera()
    {
        imgPick.sourceType = UIImagePickerControllerSourceType.Camera
        
        self.presentViewController(imgPick, animated: true, completion: nil)
        
    }

    //MARK: Image picker viw delegate methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        for item in (canvasNib?.arrayOfElements)!
        {
            if item?.tag == buttonTag
            {
                canvasNib?.arrayOfElements[buttonTag]?.img = image
                canvasNib?.arrayOfElements[buttonTag]?.reloadNib()
            }
        }
    }
    

    @IBAction func sliderBorderWidthValueChanged(sender: UISlider) {
        for item in (canvasNib?.arrayOfElements)!
        {
            item?.setPadding(CGFloat(sender.value))
        }
    }
    
    @IBAction func sliderCornerRadiusValueChanged(sender: UISlider) {
        for item in (canvasNib?.arrayOfElements)!
        {
            item?.setCornerRadius(CGFloat(sender.value))
        }
    }
    
    @IBAction func sliderBrightnessValueChanged(sender: UISlider) {
        for item in (canvasNib?.arrayOfElements)!
        {
            item?.setBrightness(sender.value)
        }
    }
    
    @IBAction func barButtonRotate(sender: UIBarButtonItem) {
        for item in (canvasNib?.arrayOfElements)!
        {
            if CGColorEqualToColor(item?.layer.borderColor, UIColor.blueColor().CGColor){
                item?.setRotatation()
            }
        }
    }
    
    @IBAction func barButtonHFlip(sender: UIBarButtonItem) {
    }
    
    @IBAction func barButtonVFlip(sender: UIBarButtonItem) {
    }
    @IBAction func barButtonBordered(sender: UIBarButtonItem) {
    }
}





