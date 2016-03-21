//
//  ViewController.swift
//  FTP
//
//  Created by Peter on 3/19/16.
//  Copyright © 2016 FTP. All rights reserved.
//

import UIKit
import Buy

class ViewController: UIViewController

{
    // MARK: - IBOutlets
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var products = [BUYProduct]()
    var currentPage: UInt = 1
    var reachedEnd = false
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
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
        if let image = product.images.first, imageURL = NSURL(string: image.src) {
            //cell.imageView.hnk_setImageFromURL(imageURL)
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
}