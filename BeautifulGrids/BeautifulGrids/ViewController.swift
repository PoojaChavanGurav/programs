//
//  ViewController.swift
//  BeautifulGrids
//
//  Created by Nupur Mittal on 30/12/15.
//  Copyright © 2015 Bitjini. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var GridTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let destVC = segue.destinationViewController as! nextViewController
//        destVC.gridnumber = canvasGrid
//        
//    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = GridTableView.dequeueReusableCellWithIdentifier("cell")
        cell?.textLabel!.text = String(indexPath.row + 1)
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            CanvasSetting.canvasGrid = indexPath.row
        let nextVC :UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("nextViewControllerID")
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}

