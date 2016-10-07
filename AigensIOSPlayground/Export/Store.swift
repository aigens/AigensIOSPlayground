//
//  Store.swift
//  AigensIOSPlayground
//
//  Created by Peter Liu on 5/10/2016.
//  Copyright © 2016 Aigens. All rights reserved.
//

import Foundation
import ObjectMapper

public class Store: Mappable{
    
    public var id: Int64?
    public var name: String?
    public var desc: String?
    public var published: Bool?
    public var features: [String]?
    
    public required init?() {
        
    }
    
    public required init?(map: Map) {
        
    }
    
    // Mappable
    public func mapping(map: Map) {
        id    <- map["id"]
        name         <- map["name"]
        desc      <- map["desc"]
        published       <- map["published"]
        features  <- map["features"]
        //friends     <- map["friends"]
        //birthday    <- (map["birthday"], DateTransform())
    }
    
}
