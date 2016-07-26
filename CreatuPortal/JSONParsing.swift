//
//  JSONParsing.swift
//  CreatuPortal
//
//  Created by Developer8 on 7/13/16.
//  Copyright © 2016 Mohan. All rights reserved.
//

import UIKit

class JSONParsing: NSObject {
    
    func categoryParse(jasonData: [String:AnyObject]){
        
       
        if(jasonData["status"] as! String == "ok"){
            if(jasonData["category"] != nil){
                 let categoryItem = Category()
            let categoryJsonString = jasonData["category"] as!  [String:AnyObject]
            categoryItem.categoryId = categoryJsonString["id"] as! Int
            categoryItem.title = categoryJsonString["title"] as! String
            categoryItem.slug = categoryJsonString["slug"] as! String
            categoryItem.parent = categoryJsonString["parent"] as! Int
            categoryItem.descriptions = categoryJsonString["description"] as? String
            categoryItem.postCount = categoryJsonString["post_count"] as! Int
            
            
            
            for categoryItemData in jasonData["posts"] as! [AnyObject] {
                categoryItem.posts += [postsParse(categoryItemData as! [String:AnyObject])]
            }
            Offline.sharedInstance.category += [categoryItem]
            }
            else{
                //recent post
                
                for categoryItemData in jasonData["posts"] as! [AnyObject] {
                    Offline.sharedInstance.recent += [postsParse(categoryItemData as! [String:AnyObject])]
                }
                
                
            }
        }
    }
    
    func postsParse(jasonData: [String:AnyObject]) -> Posts{
        let postItem = Posts()
        postItem.postId = jasonData["id"] as! Int
        postItem.type = jasonData["type"] as! String
        postItem.slug = jasonData["slug"] as! String
        postItem.url = jasonData["url"] as! String
        postItem.status = jasonData["status"] as! String
        postItem.title = jasonData["title"] as! String
        postItem.titlePlain = jasonData["title_plain"] as! String
        postItem.content = jasonData["content"] as! String
        postItem.excerpt = jasonData["excerpt"] as! String
        postItem.date = jasonData["date"] as! String
        postItem.modified = jasonData["modified"] as! String
        let imgs = jasonData["thumbnail"] as? String
        if(imgs != nil)
        {
            postItem.thumbnail = imgs
            let url = NSURL(string:imgs!)
            if(url != nil)
            {
                let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
                if(data != nil){
                    postItem.thumbnail_image  = UIImage(data: data!)
                }
                
            }
            
        }
        return postItem
    }
}
