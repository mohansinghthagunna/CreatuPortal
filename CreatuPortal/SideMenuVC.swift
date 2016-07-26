//
//  SideMenuVC.swift
//  CreatuPortal
//
//  Created by Developer8 on 5/18/16.
//  Copyright © 2016 Mohan. All rights reserved.
//

import UIKit


//MARK:CLASS


class SideMenuVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var imgView: UIImageView!
    override func viewWillAppear(animated: Bool) {
        imgView.image = UIImage(named: "LOGO.jpg")
        tableView.reloadData()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return Offline.sharedInstance.category.count+1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
      
        if(indexPath.row==0){
            cell.textLabel!.text = "HOME"
        }
        else{
            cell.textLabel!.text = Offline.sharedInstance.category[indexPath.row-1].title
        }
        
        cell.textLabel?.textColor = UIColor.blackColor()
        
        cell.textLabel!.textAlignment = NSTextAlignment.Center
        cell.contentView.backgroundColor = UIColor.clearColor()
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        Offline.sharedInstance.menuSelect = indexPath.row
        revealViewController().revealToggleAnimated(true)
        
    }
    
}
