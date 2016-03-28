//
//  SplashViewController.swift
//  FTP
//
//  Created by Peter on 3/21/16.
//  Copyright © 2016 FTP. All rights reserved.
//

import UIKit

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
        
    }

    func show() {
        self.performSegueWithIdentifier("showApp", sender: self)
    }
    
}