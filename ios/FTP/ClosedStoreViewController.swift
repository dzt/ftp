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
        
        let url = "http://fuckthepopulation.herokuapp.com/status"
        

        Alamofire.request(.GET, url, encoding:.JSON).responseJSON
            { response in switch response.result {
            case .Success(let JSON):
                print("Success with JSON: \(JSON)")
                
                let response = JSON as! NSDictionary
                
                let imageC = response.objectForKey("imageURL") as? String
                
                self.closedImage.hnk_setImageFromURL(NSURL(string: imageC!))
                self.closedMsg.text = response.objectForKey("message") as? String
                
                print(response)
                
            case .Failure(let error):
                
                print("Request failed with error: \(error)")
            
            }
        }
    }
    
}
