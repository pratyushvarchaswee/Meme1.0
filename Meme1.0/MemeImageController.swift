//
//  ViewController.swift
//  Meme1.0
//
//  Created by Pratyush Varchaswee on 10/29/15.
//  Copyright (c) 2015 Pratyush. All rights reserved.
//

import UIKit

class MemeImageController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate ,UITextFieldDelegate {

    @IBOutlet weak var toolTop: UINavigationBar!

    @IBOutlet weak var toolBottom: UIToolbar!
   
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var textTop: UITextField!
    
    @IBOutlet weak var textBottom: UITextField!
    
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    
    var mvHeight: CGFloat=0
    
    
 
    func toggleShareBar(show:Bool)
    {
        if show{
            cancelBtn.enabled=show
            shareBtn.enabled=show
            
        }
        else
        {
            cancelBtn.enabled=show
            shareBtn.enabled=show
            
        }
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        toggleShareBar(false)
        
        textFieldsPopulate(textTop,txtVal: "Top")
        textFieldsPopulate(textBottom,txtVal: "Bottom")
        
       
    }
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        subscribeToKeyboarHideNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        unSubscribeToKeyboarHideNotifications()
    }

    
    func  textFieldsPopulate(textField:UITextField,txtVal:String)
    {
        textField.text=txtVal
        textField.textAlignment=NSTextAlignment.Center
        textField.sizeToFit()
        textField.borderStyle=UITextBorderStyle.None
        textField.delegate=self
        
        // textField.defaultTextAttributes=UIFont.boldSystemFontOfSize(<#T##fontSize: CGFloat##CGFloat#>)
    }
 
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.brownColor(),
            NSForegroundColorAttributeName :UIColor.blackColor(),
            NSBackgroundColorAttributeName: UIColor.greenColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 24)!,
            NSStrokeWidthAttributeName :1
        ]
        textField.text=""
        textField.defaultTextAttributes=memeTextAttributes
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
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
          getKeyboardHeight(notification)
            moveTextField(true)
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
         if textBottom.isFirstResponder()
         {
          moveTextField(false)
        }
    }
    
    
    func getKeyboardHeight(notification: NSNotification) {
        let userInfo = notification.userInfo
        if let keyboardSize =  (userInfo![UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            mvHeight = keyboardSize.height
            
        }
    
    }
    
    
    func moveTextField(up: Bool) {
        let mov = (up ? -mvHeight : mvHeight)
        
        UIView.animateWithDuration(0.3, animations: {
          self.view.frame = CGRectOffset(self.view.frame, 0, mov)
        })
    }
   
    
    
    @IBAction func pickAnImage(sender: AnyObject) {
        toggleShareBar(true)
        let imagePicker=UIImagePickerController()
        imagePicker.delegate=self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated:true, completion: nil)
        
    }

    
    
   
    @IBAction func pickAnImageFromCamera (sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        toggleShareBar(true)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.contentMode = .ScaleAspectFit
            imagePickerView.image = image
        }
        picker.dismissViewControllerAnimated(true,completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        toggleShareBar(false)
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func toolbarVisible(visible: Bool) {
        toolTop.hidden = !visible
        toolBottom.hidden = !visible
    }
    
    func generateMemedImage() -> UIImage
    {
        toolbarVisible(false)
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    @IBAction func sharePickedImage(sender: AnyObject) {
    

        let shareImage=UIActivityViewController(activityItems:[generateMemedImage()], applicationActivities:nil)
        
        presentViewController(shareImage, animated: true, completion: nil)
       
        shareImage.completionWithItemsHandler = {
            (activity, success, items, error) in
            print("Activity: \(activity) Success: \(success) Items: \(items) Error: \(error)")
            
            if success
            {
            self.save()
                shareImage.dismissViewControllerAnimated(true, completion: nil)
             
                self.dismissViewControllerAnimated(true, completion: nil)
            }
           
        
        }
       
    }
    

    
    func save()  {
       
      _ = Meme( top: textTop.text,bottom: textBottom.text, image:
         imagePickerView.image, memedImage: generateMemedImage())
        
    }
    @IBAction func actionRest(sender: AnyObject) {
        imagePickerView.image=nil
        toggleShareBar(false)
        textTop.text="Top"
        textBottom.text="Bottom"
   }
}

