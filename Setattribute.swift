//
//  Setattribute.swift
//  Beeservice
//
//  Created by MC-MG57035 on 8/24/2560 BE.
//
//

import UIKit


extension UIView{
    func addconstraintsWithFormat(format:String , views: [String:UIView]){
        
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: views))
    }
}

