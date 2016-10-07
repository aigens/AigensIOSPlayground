//
//  AjaxStatus.swift
//  AigensIOSPlayground
//
//  Created by Peter Liu on 5/10/2016.
//  Copyright © 2016 Aigens. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

public class AjaxStatus{

    public var code: Int = 0
    public var error: String = ""
    public var jo: NSDictionary!
    
    
    public func isSuccess() -> Bool{
        
        if self.jo == nil{
            return false
        }
        
        return true
    }
    

}
