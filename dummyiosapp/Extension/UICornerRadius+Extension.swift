//
//  UICornerRadius+Extension.swift
//  dummyiosapp
//
//  Created by Maheen on 27/08/2022.
//

import UIKit

extension UIView{
   @IBInspectable var cornerRadius: CGFloat {
       get{return self.cornerRadius }
        set{
            self.layer.cornerRadius = newValue
        }
    }
}
