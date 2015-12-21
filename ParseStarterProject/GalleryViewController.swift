//
//  GalleryCollectionViewCell.swift
//  ParseStarterProject-Swift
//
//  Created by Cynthia Whitlatch on 11/3/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

protocol GalleryViewControllerDelegate {
    func galleryViewControllerDidFinish(image: UIImage)
}

class GalleryViewController: UIViewController, UICollectionViewDataSource {
    var delegate: GalleryViewControllerDelegate?
//    
//    
//    
//    func initializeGestureRecognizer() {
//        var pinchGesture: UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: Selector("recognizePinchGesture:"))
//        imageView.addGestureRecognizer(pinchGesture)
//    }
//    
//    func recognizePinchGesture(sender: UIPinchGestureRecognizer) {
//        let scale = sender.scale
//        let velocity = sender.velocity
//        let imageView = "Pinch - scale = \(scale), velocity = \(velocity)"
//        
//    }
    
    
    @IBOutlet weak var colletionView: UICollectionView!
    
    let myCollectionViewLayout = CustomeFlowLayout()
    
    var posts = [PFObject]() {
        didSet {
            self.colletionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                //CALLING GESTURE RECOGNIZER
//        self.initializeGestureRecognizer()
        
        self.colletionView.dataSource = self
        self.colletionView.collectionViewLayout = myCollectionViewLayout
        let query = PFQuery(className: "Status")
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let objects = objects {
                self.posts = objects
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
        
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(GalleryCollectionViewCell.identifier(), forIndexPath: indexPath) as! GalleryCollectionViewCell
        
        let post = self.posts[indexPath.row]
        
        if let imageFile = post["image"] as? PFFile {
            imageFile.getDataInBackgroundWithBlock({ (data, error) -> Void in
                if let data = data {
                    let image = UIImage(data: data)
                    cell.imageView.image = image
                }
            })
        }
        
        return cell
    }
}
