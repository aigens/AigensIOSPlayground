//
//  ImageViewController.swift
//  AigensIOSPlayground
//
//  Created by Peter Liu on 22/9/2016.
//  Copyright © 2016 Aigens. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class ImageViewController: UIViewController {
    
    @IBOutlet weak var methodLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    
    var method : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        debugPrint("method", method)
        
        self.methodLabel.text = method
        
        switch method {
        case "ImageBasic":
            ajaxBasic()
        case "AjaxPost":
            ajaxPost()
        default:
            debugPrint("Unknown Method", method)
        }
        
        
        
    }
    
    func ajaxBasic(){
        
        debugPrint("ajaxBasic");
        
        let url = "https://c8.staticflickr.com/4/3179/2816578079_ae9bddbf95_b.jpg"
        self.urlLabel.text = url
        
        self.mainImage.af_setImage(withURL: URL(string: url)!)
        
        
        
    }
    
    func ajaxPost(){
        
        debugPrint("ajaxPost");
        
        let url = "http://aigensstoretest.appspot.com/p/doNothing"
        self.urlLabel.text = url
        
        let params: Parameters = [
            "hello": "world"
            
        ]
        
        Alamofire.request(url, method: .post, parameters: params).responseJSON { response in
            
            //self.responseText.text = response.result.value.debugDescription
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
