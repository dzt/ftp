//
//  Shopify.swift
//  FTP
//
//  Created by Peter on 3/20/16.
//  Copyright © 2016 FTP. All rights reserved.
//

import Buy
import Keys
import Foundation

struct Shopify {
    
    static let keys = FtpKeys()
    static let cart = BUYCart()
    static let client = BUYClient(shopDomain: Shopify.keys.shopifyDomain(), apiKey: Shopify.keys.shopifyAPIKey(), channelId: Shopify.keys.shopifyChannelId())
    static var shop: BUYShop?
    
    static func configure() {
        Shopify.client?.getShop({ (shop, error) -> Void in
            Shopify.shop = shop
        })
    }
}