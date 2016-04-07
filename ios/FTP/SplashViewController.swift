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
                let status = response.objectForKey("status") as! String
                
                if (status == "closed") {
                    self.performSegueWithIdentifier("closedSegue", sender: self)
                } else {
                    
                    let alert = UIAlertController(title: "Sorry, no network connection!", message:"Please check your internet connection or try again.", preferredStyle: .Alert)
                    let action = UIAlertAction(title: "OK", style: .Default) { _ in
                        
                        self.view.setNeedsDisplay()
                        
                    }
                    alert.addAction(action)
                    self.presentViewController(alert, animated: true){}
                    
                    let timer = NSTimer.scheduledTimerWithTimeInterval(
                        1.0, target: self, selector: Selector("show"), userInfo: nil, repeats: false)
                    
                }
                
                print(response)
                
            case .Failure(let error):
                
                print("Request failed with error: \(error)")
                let alert2 = UIAlertView()
                alert2.title = "Sorry, no network connection!"
                alert2.message = "Please check your internet connection or try again."
                alert2.addButtonWithTitle("Ok")
                alert2.show()
                
                }
        }
        
    }

    func show() {
        self.performSegueWithIdentifier("showApp", sender: self)
    }
    


}