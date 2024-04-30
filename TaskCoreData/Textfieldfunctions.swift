//
//  Textfieldfunctions.swift
//  TaskCoreData
//
//  Created by SangeethaKalis on 30/04/24.
//

import Foundation
import UIKit

extension UITextField {
    //MARK: configure textField
    public func config(color: UIColor?, align: NSTextAlignment, placeHolder: String, font: UIFont?, placeHolderColor: UIColor = .white, borderColor: UIColor?, borderWidth: CGFloat?, cornerRadius: CGFloat?) {
        
        self.textColor = color ?? .white
        self.textAlignment = align
        self.textAlignment = .left
       
        self.tintColor = .black
        self.placeholder = placeHolder // Assign placeholder text here
        self.font = font ?? UIFont.systemFont(ofSize: 14)
        
       
        // Set border color
        if let borderColor = borderColor {
            self.layer.borderColor = borderColor.cgColor
        }
        
        // Set border width
        if let borderWidth = borderWidth {
            self.layer.borderWidth = borderWidth
        }
        
        // Set corner radius
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
        }
        //MARK: email Validation
        func isValidEmail() -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: self.text)
        }
    }
}
extension UILabel {
    // Function to configure text color, alignment, and font
    func configureText(color: UIColor?, alignment: NSTextAlignment, font: UIFont?,text: String) {
        // Set text color
        self.textColor = color ?? .black
        
        // Set text alignment
        self.textAlignment = alignment
        
        // Set font
        if let font = font {
            self.font = font
        }
        self.text = text
    }
}

