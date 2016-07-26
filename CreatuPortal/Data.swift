//
//  Data.swift
//  CreatuPortal
//
//  Created by Developer8 on 5/25/16.
//  Copyright © 2016 Mohan. All rights reserved.
//

import Foundation

class Data {
    var _title:String?
    var _des:String?
    var _img:UIImage?
    var _type:String?
    
    var title:String?{
        get{
            return _title
        }
        set{
            _title = newValue
        }
    }
    var des:String?{
        get{
            return _type
        }
        set{
            _type = newValue
        }
    }
    var type:String?{
        get{
            return _des
        }
        set{
            _des = newValue
        }
    }
    var img:UIImage?{
        get{
            return _img
        }
        set{
            _img = newValue
        }
    }
}