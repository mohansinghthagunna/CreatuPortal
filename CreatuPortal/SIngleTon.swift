//
//  SIngleTon.swift
//  CreatuPortal
//
//  Created by Developer8 on 5/25/16.
//  Copyright © 2016 Mohan. All rights reserved.
//

import Foundation
class StoreData {
    class var sharedInstance: StoreData {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: StoreData? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = StoreData()
        }
        return Static.instance!
    }
    var _data:[DataFile]?
    
    var dataObj:[DataFile]?{
        get{
            return _data
        }
        set{
            _data = newValue
        }
    }
    
}