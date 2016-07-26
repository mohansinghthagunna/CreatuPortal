//
//  Category.swift
//  CreatuPortal
//
//  Created by Developer8 on 7/12/16.
//  Copyright © 2016 Mohan. All rights reserved.
//

import UIKit

class Category: NSObject {
    
    //MARK: Temp Variable declaration
    var _categoryId = Int()
    var _slug = String()
    var _title = String()
    var _description = String()
    var _parent = Int()
    var _post_count = Int()
    var _posts:[Posts] = []
    
    //MARK: Setter and getter method
    var categoryId: Int {
        get {
            
            return _categoryId
        }
        set {
            _categoryId = newValue
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
    
    var title: String {
        get {
            
            return _title
        }
        set {
            _title = newValue
        }
    }
    
    var descriptions: String? {
        get {
            
            return _description
        }
        set {
            _description = newValue!
        }
    }
    
    var parent: Int {
        get {
            
            return _parent
        }
        set {
            _parent = newValue
        }
    }
    
    var postCount: Int {
        get {
            
            return _post_count
        }
        set {
            _post_count = newValue
        }
    }
    
    var posts: [Posts] {
        get {
            
            return _posts
        }
        set {
            _posts = newValue
        }
    }

}
