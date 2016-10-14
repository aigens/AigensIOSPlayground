//
//  Settings.swift
//  AigensIOSPlayground
//
//  Created by Peter Liu on 14/10/2016.
//  Copyright © 2016 Aigens. All rights reserved.
//

import Foundation


public class Settings{

    public static func getString( _ key: String) -> String!{
    
        var settings: NSDictionary?
        if let path = Bundle.main.path(forResource: "Settings", ofType: "plist") {
            settings = NSDictionary(contentsOfFile: path)
        }
    
        
        return settings?.value(forKey: key) as! String
    
    }

}
