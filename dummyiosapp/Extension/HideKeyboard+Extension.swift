//
//  HideKeyboard+Extension.swift
//  dummyiosapp
//
//  Created by Maheen on 07/09/2022.
//

import UIKit

extension UIViewController{
    func hideKeyboardTappedAround(){
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target:
                                                                self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
