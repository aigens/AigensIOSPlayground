//
//  Store.swift
//  AigensIOSPlayground
//
//  Created by Peter Liu on 5/10/2016.
//  Copyright © 2016 Aigens. All rights reserved.
//

import Foundation
import ObjectMapper

class Store: Mappable{
    
    var id: Int64?
    var name: String?
    var desc: String?
    var published: Bool?
    var features: [String]?
    
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id    <- map["id"]
        name         <- map["name"]
        desc      <- map["desc"]
        published       <- map["published"]
        features  <- map["features"]
        //friends     <- map["friends"]
        //birthday    <- (map["birthday"], DateTransform())
    }
    
}
