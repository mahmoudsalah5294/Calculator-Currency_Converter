//
//  MyAlert.swift
//  Calculator
//
//  Created by Mahmoud Mohamed on 30/06/2021.
//

import UIKit


final public class MyAlert {
    
    
    /// show alert dialog when there is an error
    /// - Parameters:
    ///   - title: error title
    ///   - message: reason of error
    ///   - viewController: viewcontroller that apply on it
    static func alert(title:String?,message:String?,viewController:UIViewController){
        let alert : UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
