//
//  BaseReactViewController.swift
//  AigensIOSPlayground
//
//  Created by Peter Liu on 14/10/2016.
//  Copyright © 2016 Aigens. All rights reserved.
//

import Foundation
import UIKit
import React

public class BaseReactViewController: UIViewController {

    
    private static var bridge : RCTBridge!
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        setupReact()
        
        
        
    }
    
    func getBridge() -> RCTBridge{
        
        if(BaseReactViewController.bridge == nil){
            
            let bundle = Settings.getString("REACT_BUNDLE")
            
            if(bundle != nil){
            
                let jsCodeLocation = URL(string: bundle!)
                
                debugPrint("loading react bundle", bundle)
                
                BaseReactViewController.bridge = RCTBridge(bundleURL: jsCodeLocation, moduleProvider: nil, launchOptions: nil)
            }
            
        }
        
        return BaseReactViewController.bridge
        
    }
    
    public func setReactView( _ view : UIView){
        self.view = view
    }
    
    public func getReactModule() -> String!{
        
        return nil
        
    }
    
    public func getReactProps() -> [AnyHashable: Any]!{
        
        return nil
        
    }
    
  
    func setupReact(){
        
        debugPrint("setupReact");
        
        let module = getReactModule()
        if(module == nil){
            return
        }
        
        let props = getReactProps()
        
        let rootView = RCTRootView(bridge: getBridge(), moduleName: module, initialProperties: props)
        
        //let vc = UIViewController()
        //self.view = rootView
        //self.present(vc, animated: true, completion: nil)
        setReactView(rootView!)
        
    }
    
    

}
