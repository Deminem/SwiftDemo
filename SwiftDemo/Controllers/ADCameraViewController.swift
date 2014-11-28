//
//  ADCameraViewController.swift
//  Version 0.1
//  Created by Adnan Urooj (Deminem)
//

// This code is distributed under the terms and conditions of the MIT license.

// Copyright (c) 2014 Adnan Urooj (Deminem) - http://www.deminem.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import MobileCoreServices

class ADCameraViewController: UIViewController, UIImagePickerControllerDelegate, UIAlertViewDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var backgroundImage: UIImageView!
    
    var cameraUI:UIImagePickerController = UIImagePickerController()
    var isDevice = false;
    
    //MARK: - View Lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.title = "Camera View"
        
        self.navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: "showMediaPicker"), animated: true)
        
        // show media picker
        self.showMediaPicker()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Camera
    func showMediaPicker() {
        
        cameraUI = UIImagePickerController()
        cameraUI.delegate = self
        
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            cameraUI.sourceType = UIImagePickerControllerSourceType.Camera
            isDevice = true;
        }
        else {
            cameraUI.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            isDevice = false;
        }
        
        cameraUI.mediaTypes = [kUTTypeImage!]
        cameraUI.allowsEditing = false
        
        self.presentViewController(cameraUI, animated: true, completion: nil)
    }
    
    func savedImage() {
        var alert:UIAlertView = UIAlertView()
        alert.title = "Saved!"
        alert.message = "Your picture was saved to Camera Roll"
        alert.delegate = self
        alert.addButtonWithTitle("Awesome")
        alert.show()
    }
    
    func alertView(alertView: UIAlertView!, didDismissWithButtonIndex buttonIndex: Int) {
        NSLog("Did dismiss button: %d", buttonIndex)
    }
    
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker:UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker:UIImagePickerController!, didFinishPickingMediaWithInfo info:NSDictionary) {
        
        var imageToSave:UIImage
        imageToSave = info.objectForKey(UIImagePickerControllerOriginalImage) as UIImage
        if (isDevice) {
            // save the image in photo library and also show it.
            UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
            self.savedImage()
        }

        // show the image
        backgroundImage.image = imageToSave;
        
        // dismiss the image picker or camera picker controller
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
