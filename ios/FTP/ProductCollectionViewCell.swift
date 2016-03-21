//
//  ProductCollectionViewCell.swift
//  FTP
//
//  Created by Peter on 3/19/16.
//  Copyright © 2016 FTP. All rights reserved.
//

import UIKit
import Buy

class ProductCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    
    required init(coder aDecoder: NSCoder) {
        

        super.init(coder: aDecoder)!
        
    }
    
    func updateWithProduct(product: BUYProduct) {
        
        let images = product.images as NSArray
        let buyImage = images.firstObject as! BUYImage
        let url = NSURL(string: buyImage.src!)
        let data = NSData(contentsOfURL: url!)
        
        self.productTitleLabel.text = product.title
        self.productPriceLabel.text = product.title
        self.featuredImageView.image = UIImage(data: data!)
        
    }


    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 15.0
        self.clipsToBounds = true
    }
}







