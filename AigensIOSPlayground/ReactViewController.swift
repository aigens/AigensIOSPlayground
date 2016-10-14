//
//  ReactViewController.swift
//  AigensIOSPlayground
//
//  Created by Peter Liu on 12/10/2016.
//  Copyright © 2016 Aigens. All rights reserved.
//

import Foundation
import React

class ReactViewController: BaseReactViewController {
    
   
    var method : String!
    //var bridge : RCTBridge!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
    }
    
    public override func getReactModule() -> String!{
        
         switch method {
            case "ReactList":
                return "ReactNativePlayground"
            default:
                debugPrint("Unknown Method", method)
                return nil
         }
        
        
    }
    
    
   
    
    
    
}
