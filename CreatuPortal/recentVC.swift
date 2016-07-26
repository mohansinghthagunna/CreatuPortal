//
//  recentVC.swift
//  CreatuPortal
//
//  Created by Developer8 on 5/27/16.
//  Copyright © 2016 Mohan. All rights reserved.
//

import UIKit

class recentVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var lblNewsMenuTitle: UILabel!
  
    @IBOutlet var button: UIButton!
    var titleNews:[String] = []
    var desNews:[String] = []
    var imageNews:[UIImage] = []
    
    override func viewDidLoad() {
     
    }
    override func viewWillAppear(animated: Bool) {
        titleNews.removeAll()
        titleNews = ["इराकको मोसुल बाँध फुट्ने खतरा, १५ लाख मानिसको ज्यान जोखिममा","२०१६ मा नेपालको अर्थतन्त्रले गति लिने राष्ट्रसंघको विश्वास","सय किलोवाट सोलार बिजुली केन्द्रीय प्रसारण लाइनमा जोडिँदै","आज घोडेजात्रा मनाइँदै","यस बर्षको एस.एल.सी परिक्षा आजबाट शुरु पहिलो दिन अनिवार्य अंग्रेजीको परीक्षा हुँदै"]
        imageNews.removeAll()
        imageNews = [UIImage(named: "n1.jpg")!,UIImage(named: "n2.jpg")!,UIImage(named: "n3.jpg")!,UIImage(named: "n4.jpg")!,UIImage(named: "n5.jpg")!]

    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as! recentTableCell
        cell.backgroundColor = UIColor.clearColor()
        cell.lblTitle.text = titleNews[indexPath.row]
        cell.imgLayer.image = imageNews[indexPath.row]
        cell.contentView.backgroundColor = UIColor.clearColor()
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundColor = UIColor.clearColor()
        return titleNews.count
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("newsDetails") as! NewsDetailsVC


        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let more = UITableViewRowAction(style: .Normal, title: "More") { action, index in
            print("more button tapped")
        }
        more.backgroundColor = UIColor.clearColor()
        
        let favorite = UITableViewRowAction(style: .Normal, title: "Favorite") { action, index in
            print("favorite button tapped")
        }
        favorite.backgroundColor = UIColor.clearColor()
        
        let share = UITableViewRowAction(style: .Normal, title: "Share") { action, index in
            print("share button tapped")
        }
        share.backgroundColor = UIColor.clearColor()
        
        return [share, favorite, more]
    }
}
