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
    
    @IBOutlet weak var closedImage: UIImageView!
    @IBOutlet weak var closedMsg: UILabel!
    
    @IBOutlet weak var twitter: UIButton!
    @IBOutlet weak var mail: UIButton!
    @IBOutlet weak var insta: UIButton!
    
    @IBOutlet weak var ftpLogo: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://ftpadmin-ftpadmin.rhcloud.com/status"
        
        twitter.addTarget(self, action: "twitterClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        insta.addTarget(self, action: "instaClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        mail.addTarget(self, action: "newsClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        

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
    
    func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage {
        let scale = newHeight / image.size.height
        let newWidth = image.size.width * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func twitterClicked(sender:UIButton!) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://twitter.com/ftp")!)
    }
    
    func instaClicked(sender:UIButton!) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.instagram.com/fuckthepopulation/")!)
    }
    
    func newsClicked(sender:UIButton!) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://fuckthepopulation.com/pages/newsletter")!)
    }
    
    func contactClicked(sender:UIButton!) {
        UIApplication.sharedApplication().openURL(NSURL(string: "mailto:info@fuckthepopulation.com")!)
    }
    
}
