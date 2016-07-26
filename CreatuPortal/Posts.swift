//
//  Posts.swift
//  CreatuPortal
//
//  Created by Developer8 on 7/12/16.
//  Copyright © 2016 Mohan. All rights reserved.
//

import UIKit

class Posts: NSObject {
    //MARK: Temp Variable declaration
    var _postId = Int()
     var _type = String()
    var _slug = String()
    var _url = String()
    var _status = String()
    var _title = String()
    var _title_plain = String()
     var _content = String()
     var _excerpt = String()
     var _date = String()
     var _modified = String()
    var _thumbnail_image = UIImage()
    var _thumbnail = String()
    
    //MARK: Setter and getter method
    var postId: Int {
        get {
            
            return _postId
        }
        set {
            _postId = newValue
        }
    }
    
    var type: String {
        get {
            
            return _type
        }
        set {
            _type = newValue
        }
    }
    
    var slug: String {
        get {
            
            return _slug
        }
        set {
            _slug = newValue
        }
    }
    
    var url: String {
        get {
            
            return _url
        }
        set {
            _url = newValue
        }
    }
    
    var status: String {
        get {
            
            return _status
        }
        set {
            _status = newValue
        }
    }
    
    var title: String {
        get {
            
            return _title
        }
        set {
            _title = newValue
        }
    }
    
    var titlePlain: String {
        get {
            
            return _title_plain
        }
        set {
            _title_plain = newValue
        }
    }
    
    var content: String {
        get {
            
            return _content
        }
        set {
            _content = newValue
        }
    }
    
    var excerpt: String {
        get {
            
            return _excerpt
        }
        set {
            _excerpt = newValue
        }
    }
    
    var date: String {
        get {
            
            return _date
        }
        set {
            _date = newValue
        }
    }
    
    var modified: String {
        get {
            
            return _modified
        }
        set {
            _modified = newValue
        }
    }
    
    var thumbnail_image: UIImage? {
        get {
            
            return _thumbnail_image
        }
        set {
            _thumbnail_image = newValue!
        }
    }
    
    var thumbnail: String?{
        get {
            
            return _thumbnail
        }
        set {
            _thumbnail = newValue!
        }
    }
}
