//
//  Image UIImageExtension
//  ParseStarterProject-Swift
//
//  Created by Cynthia Whitlatch on 11/3/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func resizeImage(image: UIImage, size: CGSize) -> UIImage {
        
        //Creating a UIContext
        
        UIGraphicsBeginImageContext(size)
        
        //coordinates where to land, where to draw itself.  Now image is in the context.
        image.drawInRect(CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))  //0.0 top left
        
        //grab snapshot from context
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()   //actually need to end/kill this
        UIGraphicsEndImageContext()
        
        return resizedImage
        
        //do this for any image because it's taking a lot of the work of the processor.  Always want to resize image.  Don't loose any quality.
    }
}



