//
//  Product.swift
//  FTP
//
//  Created by Peter on 3/19/16.
//  Copyright © 2016 FTP. All rights reserved.
//

import UIKit

class Product
{
    // MARK: - Public API
    var title = ""
    var description = ""
    var featuredImage: UIImage!
    
    init(title: String, description: String, featuredImage: UIImage!)
    {
        self.title = title
        self.description = description
        self.featuredImage = featuredImage
    }
    
    // MARK: - Private
    // dummy data
    static func createInterests() -> [Product]
    {
        return [
            Product(title: "LOGO TEE(ASH)", description: "LOGO TEE(ASH)", featuredImage: UIImage(named: "i1")!),
            Product(title: "LOGO TEE(SAND)", description: "LOGO TEE(SAND)", featuredImage: UIImage(named: "i2")!),
            Product(title: "LOGO TEE(ASH)", description: "LOGO TEE(ASH)", featuredImage: UIImage(named: "i1")!),
            Product(title: "LOGO TEE(SAND)", description: "LOGO TEE(SAND)", featuredImage: UIImage(named: "i2")!),
        ]
    }
}