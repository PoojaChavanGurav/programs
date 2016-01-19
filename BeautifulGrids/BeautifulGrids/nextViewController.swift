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
    @IBOutlet weak var sliderBorderWidth: UISlider!
    @IBOutlet weak var sliderCornerRadius: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgPick.delegate = self
        sliderCornerRadius.maximumValue = Float(self.view.frame.width)
        self.setLayoutView()
        
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
        for item in (canvasNib?.arrayOfElements)!
        {
                item?.isDelegate = self
        }
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
            item?.setPadding(CGFloat(sender.value), arrayNodeData: canvasNib!.arrayNodeData)
        }
    }
    
    @IBAction func sliderCornerRadiusValueChanged(sender: UISlider) {
        for item in (canvasNib?.arrayOfElements)!
        {
            item?.setCornerRadius(CGFloat(sender.value))
        }
    }

}




