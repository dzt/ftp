//
//  ViewController.swift
//  FTP
//
//  Created by Peter on 3/19/16.
//  Copyright © 2016 FTP. All rights reserved.
//

import UIKit
import Buy
import Haneke

class ViewController: UIViewController
    
{
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var products = [BUYProduct]()
    var currentPage: UInt = 1
    var reachedEnd = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProducts()
        
    }
    
    func fetchProducts() {
        Shopify.client?.getProductsPage(currentPage) { (products, page, reachedEnd, error) -> Void in
            self.currentPage = page
            self.reachedEnd = reachedEnd
            
            guard let buyProducts = products as? [BUYProduct] else { return }
            
            self.products.appendContentsOf(buyProducts)
            
            self.collectionView?.reloadData()
            
        }
    }
    
    private struct Storyboard {
        static let CellIdentifier = "Product Cell"
    }
}



extension ViewController : UICollectionViewDataSource
{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return products.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath) as! ProductCollectionViewCell
        
        let product = products[indexPath.row]
        //let pVariant = products.variants[indexPath.row]
        
        
        if let image = product.images.first, imageURL = NSURL(string: image.src) {
            cell.featuredImageView.hnk_setImageFromURL(imageURL)
        }
        
        
        
        //cell.productPriceLabel.text = NSString(format: "%.2ld $", (pVariant.price.floatValue)) as String
        
        if (product.available == false) {
            
            cell.availability.text = "SOLD OUT"
            
        }
        
        cell.productTitleLabel.text = product.title
        return cell ?? UICollectionViewCell()
        
    }
}


extension ViewController : UIScrollViewDelegate
{
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.memory
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.memory = offset
        
    }
    
    
    func productViewController() -> BUYProductViewController {
        let theme       = BUYTheme()
        theme.style     = .Light
        theme.tintColor = UIColor.blackColor()
        theme.showsProductImageBackground = true
        
        let productDetailController = BUYProductViewController(client: Shopify.client, theme: theme)
        
        return productDetailController
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let product     = products[indexPath.row]
        let controller  = productViewController()
        controller.loadWithProduct(product) { (success, error) -> Void in
            controller.presentPortraitInViewController(self)
        }
    }
    
}