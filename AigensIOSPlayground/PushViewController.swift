//
//  PushViewController.swift
//  AigensIOSPlayground
//
//  Created by Peter Liu on 6/10/2016.
//  Copyright © 2016 Aigens. All rights reserved.
//

import Foundation
import Alamofire
import Firebase
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging

class PushViewController: UIViewController {
    
    @IBOutlet weak var methodLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var responseText: UITextView!
    
    var method : String!
    var host = "https://aigensstoretest.appspot.com"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        debugPrint("method", method)
        
        self.methodLabel.text = method
        
        switch method {
        case "PushRegister":
            ajaxRegister()
        case "PushSend":
            ajaxSend()
        default:
            debugPrint("Unknown Method", method)
        }
        
        
        
    }
    
    func ajaxRegister(){
        
        debugPrint("ajaxRegister");
        
        let url = host + "/api/v1/push/register.json"
        self.urlLabel.text = url
        
        
        let token = FIRInstanceID.instanceID().token()
        debugPrint("current push token", token)
        
        iq.url(url).auth()
        iq.param("groupId", "1000")
        iq.param("deviceId", "1234")
        iq.param("app", "com.aigens.playground.ios")
        iq.param("token", token!)
        
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
    
    func ajaxSend(){
        
        debugPrint("ajaxSend");
        
        let url = host + "/api/v1/push/send.json"
        self.urlLabel.text = url
        
        iq.url(url).auth()
        iq.param("groupId", "1000")
        iq.param("title", "title" )
        iq.param("message", "message")
        iq.param("body", "body")
        iq.param("memberId", iq.getMid()!)
        iq.param("delay", "5000")
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
