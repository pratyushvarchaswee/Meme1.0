//
//  ViewController.swift
//  Meme1.0
//
//  Created by Pratyush Varchaswee on 10/29/15.
//  Copyright (c) 2015 Pratyush. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate  {

   
    @IBOutlet weak var imagePickerView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    

    @IBAction func pickAnImage(sender: AnyObject) {
        let imagePicker=UIImagePickerController()
        imagePicker.delegate=self
        self.presentViewController(imagePicker, animated:true, completion: nil)
//        self.dismissViewControllerAnimated(true,completion: nil)
        
    }
    

}

