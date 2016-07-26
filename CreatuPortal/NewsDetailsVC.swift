//
//  NewsDetailsVC.swift
//  CreatuPortal
//
//  Created by Developer8 on 5/24/16.
//  Copyright © 2016 Mohan. All rights reserved.
//

import UIKit

class NewsDetailsVC: UIViewController {
    
    @IBOutlet var webView: UIWebView!
    var post = Posts()
    
    override func viewWillAppear(animated: Bool) {
        var imgStr = String()
        if(post.thumbnail != nil){
            imgStr = post.thumbnail!
            let webString = "<h3>\(post.title)</h3><p>date: \(post.date)</p></br><img src=\"\(imgStr)\"  style=\"width:320px;height:250px;\"></br></br>\(post._content+post.excerpt)"
            webView.loadHTMLString(webString, baseURL: nil)
            
        }
        else{
            let webString = "<h3>\(post.title)</h3></br><p>date: \(post.date)</p></br></br></br></br>\(post._content+post.excerpt)"
            webView.loadHTMLString(webString, baseURL: nil)
            
        }
        //webView.scalesPageToFit = true;
    }
    @IBAction func shareTapped(sender: AnyObject) {
        let textToShare: String = post.title + "\n date: "+post.date
        let myWebsite: NSURL = NSURL(string: post.url)!
        let objectsToShare: [AnyObject] = [textToShare, myWebsite]
        let activityVC: UIActivityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        let excludeActivities: [String] = [UIActivityTypePostToFacebook,UIActivityTypePostToTwitter,UIActivityTypePostToFlickr,UIActivityTypeMessage,UIActivityTypeAirDrop, UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr, UIActivityTypePostToVimeo]
        activityVC.excludedActivityTypes = excludeActivities
        self.presentViewController(activityVC, animated: true, completion: { _ in })
    }
    
}
