
/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func saveImage(sender: UIButton) {
        var textToUpload = ""
        if self.textField.text != nil {
            textToUpload = self.textField.text!
            
            let alert = UIAlertController(title: "Image was uploaded", message: "Good Job", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(okAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Image failed to upload", message: "Try Again", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(okAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        if let imageToUpload = self.imageView.image {
            API.saveImage(imageToUpload, text: textToUpload)
        }
    }
    
    
//    @IBOutlet weak var segmentedControl: UISegmentedControl!
   
//    @IBAction func segmentedControlAction(sender: UISegmentedControl) {
//        if(segmentedControl.selectedSegmentIndex == 0)
//        {
//            
//    }
//        else if(segmentedControl.selectedSegmentIndex == 1)
//        {
//    }
//        else if(segmentedControl.selectedSegmentIndex == 2)
//        {
//            textField.text = "SAVE";
//            textField.resignFirstResponder()
//        
//        var textToUpload = ""
//            if self.textField.text != nil {
//                textToUpload = self.textField.text!
//            }
//            if let imageToUpload = self.imageView.image {
//                API.saveImage(imageToUpload, text: textToUpload)
//            }
//        }
//    }


    @IBOutlet weak var imageView: UIImageView!
  
//    @IBAction func uploadImageButton(sender: AnyObject) {
//                
//        if imageView.image == nil {
//            
//            let alert = UIAlertController(title: "You must select an Image First", message: "", preferredStyle: UIAlertControllerStyle.Alert)
//            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
//            alert.addAction(okAction)
//            
//            self.presentViewController(alert, animated: true, completion: nil)
//            
//        } else {
//            
//        let image = imageView.image
//    
//        let size = CGSize(width: 600, height: 600)
//    
//        let resizedImage = UIImage.resizeImage(image!, size: size)
//    
//        if let imageData = UIImageJPEGRepresentation(resizedImage, 1.0) {
//            let imageToParse = PFObject(className: kParseImages)
//            let imageFilename = PFObject(className: "CollectionViewData")
//
//            if let imageFile = PFFile(data: imageData) {
//                imageToParse["image"] = imageFile
//                imageFilename["textField"] = imageFile
//    
//                imageToParse.saveInBackgroundWithBlock { (success, error) -> Void in
//                    if success {
//                        print("success")
//                        
//                    }
//                }
//            }
//        }
//    }
//}
    
    
    @IBAction func filterButtonPressed(sender: AnyObject) {
        presentFilterAlert()
        
    }
    
    func presentFilterAlert() {
        
        let alertController = UIAlertController(title: "FILTERS", message: "Pick One", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let VintageFilterAction = UIAlertAction(title: "Vintage", style: UIAlertActionStyle.Default) { (alert) -> Void in
            FilterService.applyVintageEffect(self.imageView.image!, completion: { (filteredImage, name) -> Void in
                if let filteredImage = filteredImage {
                    self.imageView.image = filteredImage
                }
            })
        }
        
        let BWFilterAction = UIAlertAction(title: "Black and White", style: UIAlertActionStyle.Default) { (alert) -> Void in
            FilterService.applyBWEffect(self.imageView.image!, completion: { (filteredImage, name) -> Void in
                
                if let filteredImage = filteredImage {
                self.imageView.image = filteredImage
                }
            })
        }
        
        let ChromeFilterAction = UIAlertAction(title: "Chrome", style: UIAlertActionStyle.Default) { (alert) -> Void in
            FilterService.applyChrome(self.imageView.image!, completion: { (filteredImage, name) -> Void in
                    
                if let filteredImage = filteredImage {
                self.imageView.image = filteredImage
                }
            })
        }
        
        let PhotoFilterAction = UIAlertAction(title: "PhotoEffectProcess", style: UIAlertActionStyle.Default) { (alert) -> Void in
            FilterService.applyPhotoEffectProcess(self.imageView.image!, completion: { (filteredImage, name) -> Void in
                
                if let filteredImage = filteredImage {
                self.imageView.image = filteredImage
                }
            })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            
            alertController.addAction(VintageFilterAction)
            alertController.addAction(BWFilterAction)
            alertController.addAction(ChromeFilterAction)
            alertController.addAction(PhotoFilterAction)
            alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
        }

    // MARK :   BUTTON PRESSED
    
    @IBAction func buttonPressed(sender:UIButton!) {
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            
            let alert = UIAlertController(title: "Please Select One", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { (alert) -> Void in
                self.presentImagePicker(.Camera)                
            }
            
            let photoLibrary = UIAlertAction(title: "Photos", style: UIAlertActionStyle.Default) { (alert) -> Void in
                self.presentImagePicker(.PhotoLibrary)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action) -> Void in
                
                let alertController = UIAlertController(title: "CANCEL?", message: "", preferredStyle: UIAlertControllerStyle.Alert)
                
                let action = UIAlertAction(title: "YES", style: UIAlertActionStyle.Default, handler: { (alert) -> Void in
                    self.imageView.image = nil
                    print("Cancel")
                })
                
                alertController.addAction(action)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            
            alert.addAction(photoLibrary)
            alert.addAction(cameraAction)
            alert.addAction(cancelAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else {
            
            self.presentImagePicker(.PhotoLibrary)
            
        }
    }
    
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

