//
//  Status.swift
//  ParseStarterProject-Swift
//
//  Created by Cynthia Whitlatch on 11/4/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class Status {
    
    var image: UIImage
    var thumbnail: UIImage?
    var status: String
    
    init(image: UIImage, thumbnail: UIImage?, status: String) {
        self.image = image
        self.thumbnail = thumbnail
        self.status = status
    }
}

