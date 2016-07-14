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
    
   var txtTop: String!
    
   var txtBottom: String!
    
   var image:UIImage?
    
   var memedImage:UIImage!
    
    init(top:String!,bottom:String!,image:UIImage?,memedImage:UIImage!)
   {
    self.txtTop=top
    self.txtBottom=bottom
    self.image=image
    self.memedImage=memedImage
    
    }
    
    
    
}