//
//  Offline.swift
//  CreatuPortal
//
//  Created by Developer8 on 7/12/16.
//  Copyright © 2016 Mohan. All rights reserved.
//

import UIKit

class Offline: NSObject {
    //MARK: Shared Instance make Unique Object
    class var sharedInstance: Offline {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: Offline? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = Offline()
        }
        return Static.instance!
    }
    
    //MARK: Temp Variable declaration
    var _category:[Category] = []
    var _Recent:[Posts] = []
    var _isFirst:Int = 0
     var _isPause:Int = 0
    var _menuSelect:Int = 0
     var videoList:[String] = ["qhA3MUsfIVI","rxfV4Q4pc_s","Cl4HonKjeaw"]
     var selectedVideoIndex = 0
    //MARK: Setter and getter method
    var recent: [Posts] {
        get {
            
            return _Recent
        }
        set {
            _Recent = newValue
        }
    }
    
    var category: [Category] {
        get {
            
            return _category
        }
        set {
            _category = newValue
        }
    }
    
    var isFirst: Int {
        get {
            
            return _isFirst
        }
        set {
            _isFirst = newValue
        }
    }
    
    var menuSelect: Int {
        get {
            
            return _menuSelect
        }
        set {
            _menuSelect = newValue
        }
    }
    var isPause: Int {
        get {
            
            return _isPause
        }
        set {
            _isPause = newValue
        }
    }

    
}
