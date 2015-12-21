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
    
    class func getImages(completion: (objects: [Status]?) -> ()) {
        
        let query = PFQuery(className: kParseClass)
        query.whereKeyExists("image")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                if let objects = objects {
                    var arrayOfStatuses = [Status]()
                    for object in objects {
                        let pfFileFromObject = object["image"] as! PFFile
                        let textFromObject = object["statusText"] as! String
                        let newStatus = Status(statusText: textFromObject, statusImageData: pfFileFromObject)
                        arrayOfStatuses.append(newStatus)
                    }
                    completion(objects: arrayOfStatuses)
                }
            } else {
                print(error)
            }
        }
    }
}