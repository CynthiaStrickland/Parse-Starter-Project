//
//  FilterService.swift
//  ParseStarterProject-Swift
//
//  Created by Cynthia Whitlatch on 11/3/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import CoreImage

class FilterService {
    
    private class func setupFilter(filterName: String, parameters: [String: AnyObject]?, image: UIImage) -> UIImage?{
        
        let image = CIImage(image: image)
        let filter : CIFilter
        
        if let parameters = parameters {
            filter = CIFilter(name: filterName, withInputParameters: parameters)!
        } else {
            filter = CIFilter(name: filterName)!
        }
        filter.setValue(image, forKey:kCIInputImageKey)   //input image for filter
     
        // GPU CONTEXT - BoilerPlate Language
        let options = [kCIContextWorkingColorSpace: NSNull()]
        let myEAGLContext = EAGLContext(API:EAGLRenderingAPI.OpenGLES2)
        let gpuContext = CIContext(EAGLContext: myEAGLContext, options: options)
        
        //image comes back from filter ...make it the same size as the original image "extent"
        let outputImage = filter.outputImage
        let extent = outputImage!.extent
        let cgImage = gpuContext.createCGImage(outputImage!, fromRect: extent)
        
        
        let finalImage = UIImage(CGImage: cgImage)
        
        return finalImage
    }
    
    
    class func applyVintageEffect(image: UIImage, completion: (filteredImage: UIImage?, name: String) -> Void) {
        
        let filterName = "CIPhotoEffectTransfer"
        let displayName = "Vintage"
        
        //call method for filter
        let finalImage = self.setupFilter(filterName, parameters: nil, image: image)
    
                //make sure you are handling the threading yourself -   ???
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            completion(filteredImage: finalImage, name: displayName)

        }
    }
    
    class func applyBWEffect(image: UIImage, completion: (filteredImage: UIImage?, name: String) -> Void) {
        
        let filterName = "CIPhotoEffectMono"
        let displayName = "Black and White"
        
        //call method for filter
        let finalImage = self.setupFilter(filterName, parameters: nil, image: image)
        
        //make sure you are handling the threading yourself -   ???
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            completion(filteredImage: finalImage, name: displayName)
        }
    }
    
    class func applyChrome(image: UIImage, completion: (filteredImage: UIImage?, name: String) -> Void) {
        
        let filterName = "CIPhotoEffectChrome"
        let displayName = "Chrome"
        
        //call method for filter
        let finalImage = self.setupFilter(filterName, parameters: nil, image: image)
        
        //make sure you are handling the threading yourself -   ???
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            completion(filteredImage: finalImage, name: displayName)
        }
    }
    
    class func applyPhotoEffectProcess(image: UIImage, completion: (filteredImage: UIImage?, name: String) -> Void) {
        
        let filterName = "CIPhotoEffectProcess"
        let displayName = "PhotoEffectProcess"
        
        //call method for filter
        let finalImage = self.setupFilter(filterName, parameters: nil, image: image)
        
        //make sure you are handling the threading yourself -   ???
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            completion(filteredImage: finalImage, name: displayName)
        }
    }
    
//    class func CIColorCrossPolynomial(image: UIImage, completion: (filteredImage: UIImage?, name: String) -> Void) {
//        
//            let filterName = "CIColorCrossPolynomial"
//            let displayName = "Color Cross"
//        
//        
//            let redVector = PolynomialCoefficients(a0: 0.0, a1: 0.0, a2: 0.0, a3: 0.4)
//            let greenVector = PolynomialCoefficients(a0: 0.0, a1: 0.0, a2: 0.5, a3: 0.8)
//            let blueVector = PolynomialCoefficients(a0: 0.0, a1: 0.0, a2: 0.5, a3: 1.0)
//            let alphaVector = PolynomialCoefficients(a0: 0.0, a1: 1.0, a2: 1.0, a3: 1.0)
//        
//        let options = ColorPolynomialOptions(inputRedCoefficients: redVector, inputGreenCoefficients: greenVector, inputBlueCoefficients: blueVector, inputAlphaCoefficients: alphaVector)
//        
//        let finalImage = ColorPolynomial(options)
//        
//        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
//            completion(filteredImage: finalImage, name: displayName)
//        }
//    }

}
