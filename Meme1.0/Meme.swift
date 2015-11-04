//
//  Meme.swift
//  Meme1.0
//
//  Created by Pratyush Varchaswee on 11/2/15.
//  Copyright © 2015 Pratyush. All rights reserved.
//

import Foundation
import UIKit

struct Meme{
    
   var text: String!
    
   var image:UIImage?
    
   var memedImage:UIImage!
    
   init(text:String!,image:UIImage?,memedImage:UIImage!)
   {
    self.text=text
    self.image=image
    self.memedImage=memedImage
    
    }
    
    
    
}