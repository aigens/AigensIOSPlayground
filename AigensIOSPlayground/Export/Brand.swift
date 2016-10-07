//
//  Brand.swift
//  AigensIOSPlayground
//
//  Created by Peter Liu on 5/10/2016.
//  Copyright © 2016 Aigens. All rights reserved.
//

import Foundation
import ObjectMapper

public class Brand: Mappable{
    
    public var id: Int64?
    public var name: String?
    public var desc: String?
    public var published: Bool?
    public var limited: Bool?
    public var features: [String]?
    public var stores: [Store]?
    
    
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
        limited  <- map["limited"]
        features  <- map["features"]
        stores <- map["stores"]
        //friends     <- map["friends"]
        //birthday    <- (map["birthday"], DateTransform())
    }
    
}
