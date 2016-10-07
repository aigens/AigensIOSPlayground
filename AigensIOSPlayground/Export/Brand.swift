//
//  Brand.swift
//  AigensIOSPlayground
//
//  Created by Peter Liu on 5/10/2016.
//  Copyright © 2016 Aigens. All rights reserved.
//

import Foundation
import ObjectMapper

class Brand: Mappable{
    
    var id: Int64?
    var name: String?
    var desc: String?
    var published: Bool?
    var limited: Bool?
    var features: [String]?
    var stores: [Store]?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id    <- map["id"]
        name         <- map["name"]
        desc      <- map["desc"]
        published       <- map["published"]
        limited  <- map["limited"]
        features  <- map["features"]
        stores <- map["stores"]
        //friends     <- map["friends"]
        //birthday    <- (map["birthday"], DateTransform())
    }
    
}
