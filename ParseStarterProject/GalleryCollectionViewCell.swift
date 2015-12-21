//
//  GalleryCollectionViewCell.swift
//  ParseStarterProject-Swift
//
//  Created by Cynthia Whitlatch on 11/3/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    class func identifier() -> String {
        return "GalleryCollectionViewCell"
    }
    
    var imageStatus: Status? {
        didSet {
            if imageStatus?.statusImage == nil {
                imageStatus!.statusImageData.getDataInBackgroundWithBlock({ (data, error) -> Void in
                    if error == nil {
                        self.imageStatus!.statusImage = UIImage(data: data!)
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            self.imageView.image = self.imageStatus!.statusImage
                        })
                    } else {
                        print("error")
                    }
                })
            }
        }
    }
    
}
