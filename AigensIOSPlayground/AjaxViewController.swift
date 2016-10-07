//
//  DetailViewController.swift
//  AigensIOSPlayground
//
//  Created by Peter Liu on 22/9/2016.
//  Copyright © 2016 Aigens. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper

class AjaxViewController: UIViewController {
    
    @IBOutlet weak var methodLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var responseText: UITextView!
   
    var method : String!
    var host = "https://aigensstoretest.appspot.com"
    //var host = "http://192.168.111.17"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        debugPrint("method", method)
        
        self.methodLabel.text = method
        
        switch method {
            case "AjaxGet":
                ajaxGet()
            case "AjaxPost":
                ajaxPost()
            case "AjaxLogin":
                ajaxLogin()
            case "AjaxAuth":
                ajaxAuth()
            default:
                debugPrint("Unknown Method", method)
        }
        
       
        
    }
    
    func ajaxGet(){
        
        debugPrint("ajaxGet");
        
        let url = host + "/api/v1/reward/brand/107.json"
        self.urlLabel.text = url
        
        iq.url(url).ajax(callback: brandCb)
        
        
    }
    
    func brandCb(status: AjaxStatus){
    
        if(status.isSuccess()){
            
            
            let data = status.jo["data"]
            
            let brand = Mapper<Brand>().map(JSONObject: data)
            
            debugPrint("B", brand!.name)
            debugPrint("C", brand!.stores!)
            
            
            self.responseText.text = status.jo.description
            
        }else{
            
            debugPrint("failed")
            self.responseText.text = String(status.code) + ":" + status.error
            
        }
    
    }
    
    func ajaxPost(){
        
        debugPrint("ajaxPost");
        
        let url = host + "/p/doNothing"
        self.urlLabel.text = url
        
        
        
        
        iq.url(url)
        iq.param("hello", "world")
        iq.method(.post)
        
        iq.ajax{status in
        
            if(status.isSuccess()){
                
                self.responseText.text = status.jo.description
                
            }else{
                
                debugPrint("failed")
                self.responseText.text = String(status.code) + ":" + status.error
                
            }
            
        }
    
    }
    
    func ajaxLogin(){
        
        debugPrint("ajaxLogin");
        
        let url = host + "/api/v1/reward/login.json"
        self.urlLabel.text = url
        
        
        let params : NSMutableDictionary = [
            "username": "test4@aigens.com",
            "password": "1234"
        ]
        
        
        iq.url(url)
        iq.params(params)
        iq.method(.post)
        
        iq.ajax{status in
            
            if(status.isSuccess()){
                
                self.responseText.text = status.jo.description
                
                
                let sid = status.jo["sessionId"] as! String
                let mid = status.jo["memberId"] as! NSNumber
                
                self.iq.setSid(sid: sid)
                self.iq.setMid(mid: mid.stringValue)
            }else{
                
                debugPrint("failed")
                self.responseText.text = String(status.code) + ":" + status.error
                
            }
            
        }
        
        
        
    }
    
    func ajaxAuth(){
        
        debugPrint("ajaxAuth");
        
        let sid = iq.getSid()
        
        if(sid == nil){
            self.responseText.text = "No user session."
            return;
        }
        
        //memberlet url = host + "/p/doNothing"
        let url = host + "/api/v1/reward/membership.json"
        
        self.methodLabel.text = self.method + "(" + sid! + ")"
        self.urlLabel.text = url
        
        
        iq.auth()
        iq.url(url)
        
        
        iq.ajax{status in
            
            if(status.isSuccess()){
                
                self.responseText.text = status.jo.description
                
            }else{
                
                debugPrint("failed")
                self.responseText.text = String(status.code) + ":" + status.error
                
            }
            
        }
        
       
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

