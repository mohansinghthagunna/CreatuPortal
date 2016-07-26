//
//  PageItemController.swift
//  Paging_Swift
//
//  Created by Olga Dalton on 26/10/14.
//  Copyright (c) 2014 swiftiostutorials.com. All rights reserved.
//

import UIKit

class PageItemController: UIViewController {
    
    // MARK: - Variables
    var itemIndex: Int = 0
    var tle:String?
 //   var img:UIImage?
    var imageName: String = "" {
        
        didSet {
            
            if let imageView = contentImageView {
                imageView.image = UIImage(named: imageName)
            }
            
        }
    }
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var contentImageView: UIImageView?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        contentImageView!.image = UIImage(named:imageName)
        lblTitle.text = tle
    }
 
    @IBAction func btntpd(sender: AnyObject) {
        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("newsDetails") as! NewsDetailsVC
       
      //  secondViewController.img = img
      //  secondViewController.strTitle = tle
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
}
