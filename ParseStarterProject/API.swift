//
//  GalleryCollectionViewCell.swift
//  ParseStarterProject-Swift
//
//  Created by Cynthia Whitlatch on 11/3/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

typealias ParseCompletionHandler = (sucess: Bool) -> ()

class API {
    
    class func saveImage(image: UIImage, text: String) {
        
        let savedStatus = PFObject(className: kParseClass)
        
        if let imageData = UIImageJPEGRepresentation(image, 1.0) {
            if let imageFile = PFFile(data: imageData) {
                savedStatus["image"] = imageFile
                savedStatus["statusText"] = text
                savedStatus.saveInBackgroundWithBlock { (success, error) -> Void in
                    if success {
                        print("success")
                    } else {
                        print("error")
                    }
                }
            }
        }
    }
    
    class func uploadImage(image: UIImage, completion: ParseCompletionHandler) {
        
        if let imageData = UIImageJPEGRepresentation(image, 0.7) {
            print(imageData)
            let imageFile = PFFile(name: "Image", data: imageData)
            let status = PFObject(className: "Status")
            status["Image"] = imageFile
            
            status.saveInBackgroundWithBlock( { (sucess, error) -> Void in
                if sucess {
                    completion(sucess: sucess)
                } else {
                    completion(sucess: false)
                }
            })
        }
    }
}
