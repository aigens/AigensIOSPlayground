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

class AjaxStatus{

    var code: Int = 0
    var error: String = ""
    var jo: NSDictionary!
    
    
    func isSuccess() -> Bool{
        
        if self.jo == nil{
            return false
        }
        
        return true
    }
    

}
