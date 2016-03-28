//
//  SplashViewController.swift
//  FTP
//
//  Created by Peter on 3/21/16.
//  Copyright © 2016 FTP. All rights reserved.
//

import UIKit
import Alamofire

class SplashViewController: UIViewController {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jeremyGif = UIImage.gifWithName("anim")
        logo.image = jeremyGif
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(
            5.5, target: self, selector: Selector("show"), userInfo: nil, repeats: false)
        
        let url = "https://fuckthepopulation.herokuapp.com/status"
        
        Alamofire.request(.GET, url, encoding:.JSON).responseJSON
            { response in switch response.result {
            case .Success(let JSON):
                print("Success with JSON: \(JSON)")
                
                let response = JSON as! NSDictionary
                
                var status = response.objectForKey("staus") as! String
                
                if (status == "closed") {
                    self.performSegueWithIdentifier("closedSegue", sender: self)
                }
                
                print(response)
                
            case .Failure(let error):
                
                print("Request failed with error: \(error)")
                
                }
        }
        
    }

    func show() {
        self.performSegueWithIdentifier("showApp", sender: self)
    }
    


}