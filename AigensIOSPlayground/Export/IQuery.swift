//
//  IQuery.swift
//  AigensIOSPlayground
//
//  Created by Peter Liu on 5/10/2016.
//  Copyright © 2016 Aigens. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

/*
public enum HTTPMethod: String {
    
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
   
}*/

class IQuery{
    
    private var url: String?
    private var params: NSMutableDictionary = [:]
    private var headers: NSMutableDictionary = [:]
    private var method: HTTPMethod = .get
    
    /*
    func ajax(){
        
        Alamofire.request(self.url!).responseJSON { response in
            
            
            let jo = response.result.value as! NSDictionary
            let data = jo["data"]
            
            debugPrint("A", type(of: data!))
            
            //self.responseText.text = response.result.value.debugDescription
            //self.responseText.text = json.rawString()
            
            let brand = Mapper<Brand>().map(JSONObject: data)
            
            debugPrint("B", brand!.name)
            debugPrint("C", brand!.stores!)
            
            
            //self.responseText.text = jo.description
            
        }
        
    }
    */
    
    private func clear(){
        
        self.url = nil
        self.params = [:]
        self.headers = [:]
        self.method = .get
        
    }
    
    @discardableResult func auth() -> Self{
        
        headers["sid"] = getSid()
        return self
    }
    
    
    @discardableResult func url( _ url:String) -> Self{
        
        self.url = url
        return self
    }
    
    @discardableResult func param( _ name:String, _ value:Any) -> Self{
        
        self.params.setValue(value, forKey: name)
        return self
    }
    
    @discardableResult func params( _ params:NSDictionary) -> Self{
        
        self.params = NSMutableDictionary(dictionary: params)
        return self
    }
    
    @discardableResult func header( _ name:String, _ value:Any) -> Self{
        
        self.headers.setValue(value, forKey: name)
        return self
    }
    
    @discardableResult func headers( _ headers:NSDictionary) -> Self{
        
        self.headers = NSMutableDictionary(dictionary: headers)
        return self
    }
    
    
    @discardableResult func method( _ method:HTTPMethod) -> Self{
        
        self.method = method
        return self
    }
    
    
    
    func setSid(sid: String){
        
        UserDefaults.standard.set(sid, forKey: "aigens.sid")

    }
    
    func getSid() -> String?{
        return UserDefaults.standard.string(forKey: "aigens.sid")
    }
    
    func setMid(mid: String){
        
        UserDefaults.standard.set(mid, forKey: "aigens.mid")
        
    }
    
    func getMid() -> String?{
        return UserDefaults.standard.string(forKey: "aigens.mid")
    }
    
    func ajax(callback: @escaping(AjaxStatus) -> Void){
        
        let url = self.url
        let method = self.method
        
        let params = NSDictionary(dictionary: self.params) as! Parameters
        let headers = NSDictionary(dictionary: self.headers) as! HTTPHeaders
        
        
        clear()
        
        Alamofire.request(url!, method:method, parameters: params, headers: headers).responseJSON { response in
            
            let status = AjaxStatus()
            
            if let code = response.response?.statusCode{
                status.code = code
                
                if(code < 200 || code >= 300){
                    let error = String(data: response.data!, encoding: String.Encoding.utf8)
                    status.error = error!
                }
                
            }
            
            
            if let jo = response.result.value as? NSDictionary{
                debugPrint("setting response")
                status.jo = jo
            }
            
            
            callback(status)
            
        }
        
        
        
        
    }
    
    
}
