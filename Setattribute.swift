//
//  Setattribute.swift
//  jsonsatadard
//
//  Created by Dol2omo on 3/30/2560 BE.
//  Copyright © 2560 Dol2omo. All rights reserved.
//

import UIKit


extension UIView{
    func addconstraintsWithFormat(format:String , views: [String:UIView]){
        
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: views))
    }
}

