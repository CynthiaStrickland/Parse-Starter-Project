//
//  Status.swift
//  ParseStarterProject-Swift
//
//  Created by Cynthia Whitlatch on 11/4/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class Status {

var image: UIImage?
var thumbnail:UIImage?
var status: String
var statusImageData: PFFile
var statusImage: UIImage?
var statusText = ""

init(image: UIImage?, thumbnail: UIImage?, status: String, statusText: String, statusImageData: PFFile) {
    self.image = image
    self.thumbnail = thumbnail
    self.status = status
    self.statusText = statusText
    self.statusImageData = statusImageData
    }
}

