//
//  ProductCollectionViewCell.swift
//  FTP
//
//  Created by Peter on 3/19/16.
//  Copyright © 2016 FTP. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell
{
    // MARK: - Public API
    var interest: Product! {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Private
    
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var interestTitleLabel: UILabel!
    
    private func updateUI()
    {
        interestTitleLabel?.text! = interest.title
        featuredImageView?.image! = interest.featuredImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
}







