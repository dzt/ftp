//
//  ClosedStoreViewController.swift
//  FTP
//
//  Created by Peter on 3/23/16.
//  Copyright © 2016 FTP. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ClosedStoreViewController: UIViewController {
    
    // IBOutlets
    
    @IBOutlet weak var closedImage: UIImageView!
    @IBOutlet weak var closedMsg: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://gist.githubusercontent.com/dzt/009ffe6d6f770c226899/raw/80d3813c0276f912de976c4900cd761c950cf09a/store.json"
        

        Alamofire.request(.GET, url, encoding:.JSON).responseJSON
            { response in switch response.result {
            case .Success(let JSON):
                print("Success with JSON: \(JSON)")
                
                let response = JSON as! NSDictionary
                
                // var fuck = response.objectForKey("closedDescription") as! String
                
                
                
                self.closedImage.hnk_setImageFromURL(NSURL(string: "https://i.imgur.com/SKsPvmz.jpg?1"))
                self.closedMsg.text = response.objectForKey("closedDescription") as? String
                
                print(response)
                
            case .Failure(let error):
                
                print("Request failed with error: \(error)")
            
            }
        }
        

    }

}
