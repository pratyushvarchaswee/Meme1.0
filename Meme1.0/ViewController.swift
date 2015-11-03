//
//  ViewController.swift
//  Meme1.0
//
//  Created by Pratyush Varchaswee on 10/29/15.
//  Copyright (c) 2015 Pratyush. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate ,UITextFieldDelegate {

   
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var textTop: UITextField!
    
    @IBOutlet weak var textBottom: UITextField!
    
 
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        textFieldsPopulate(textTop,txtVal: "Top")
        textFieldsPopulate(textBottom,txtVal: "Bottom")
        
       
    }
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
        self.subscribeToKeyboarHideNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
        self.unSubscribeToKeyboarHideNotifications()
    }

    
    func  textFieldsPopulate(textField:UITextField,txtVal:String)
    {
        textField.text=txtVal
        textField.textAlignment=NSTextAlignment.Center
        textField.sizeToFit()
        textField.borderStyle=UITextBorderStyle.None
//        textField.delegate=self
        
        // textField.defaultTextAttributes=UIFont.boldSystemFontOfSize(<#T##fontSize: CGFloat##CGFloat#>)
    }
 
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.brownColor(),
            NSForegroundColorAttributeName :UIColor.blackColor(),
            NSBackgroundColorAttributeName: UIColor.greenColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 20)!,
            NSStrokeWidthAttributeName :1
        ]
        textField.defaultTextAttributes=memeTextAttributes
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return false;
    }
    
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
    }
    func subscribeToKeyboarHideNotifications()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
        
    }
    func unSubscribeToKeyboarHideNotifications()
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if textBottom.isFirstResponder() {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
         if textBottom.isFirstResponder()
         {
//        self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    
    
   
    
    
    @IBAction func pickAnImage(sender: AnyObject) {
        let imagePicker=UIImagePickerController()
        imagePicker.delegate=self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated:true, completion: nil)
        
    }

    
    
   
    @IBAction func pickAnImageFromCamera (sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.contentMode = .ScaleAspectFill
            imagePickerView.image = image
        }
        picker.dismissViewControllerAnimated(true,completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func generateMemedImage() -> UIImage
    {
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    @IBAction func sharePickedImage(sender: AnyObject) {
//        let meme = Meme( text:"someval",
//            image: imagePickerView.image, memedImage: generateMemedImage())
        
        let shareImage=UIActivityViewController(activityItems:["TEst purpose"], applicationActivities:nil)
        
        self.presentViewController(shareImage, animated: true, completion: nil)
       
    }
    @IBAction func actionRest(sender: AnyObject) {
        imagePickerView.image=nil
        textTop.text="Top"
        textBottom.text="Bottom"
   }
}

