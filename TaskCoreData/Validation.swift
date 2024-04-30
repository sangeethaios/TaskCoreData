//
//  Validation.swift
//  TaskCoreData
//
//  Created by SangeethaKalis on 30/04/24.
//

import Foundation
import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

/**
 This class was implemented to Validation.
 */
class Validation:NSObject
{
    /**
     This method is to validate user mobile number.
     */
    class func isValidMobileNumber(_ mob:String)->Bool
    {
        //Mobile Number Validation
        let charcter  = CharacterSet(charactersIn: "0123456789").inverted
        var filtered:NSString!
        let inputString:NSArray = mob.components(separatedBy: charcter) as NSArray
        filtered = inputString.componentsJoined(by: "") as NSString?
       // if  mob == filtered && mob
        if  mob.isEqual(filtered) && mob.count < 8
        {
            return false
        }
        else
        {
           // return mob == filtered
            return mob.isEqual(filtered)
        }
      }
    class func ValidNumber(_ mob:String, from:Int,to:Int)->Bool
    {
        //Mobile Number Validation
        let charcter  = CharacterSet(charactersIn: "0123456789").inverted
        var filtered:NSString!
        let inputString:NSArray = mob.components(separatedBy: charcter) as NSArray
        filtered = inputString.componentsJoined(by: "") as NSString?
        // if  mob == filtered && mob
        if  mob.isEqual(filtered) && mob.count < from
        {
            return false
        }
        else if  mob.isEqual(filtered) && mob.count > to
        {
            return false
        }
        else
        {
            // return mob == filtered
            return mob.isEqual(filtered)
        }
    }
    /**
     This method is to validate user enter the valid password.
     */
    class func isValidPassword(_ passwd:String)->Bool
    {
        if passwd.count > 5 && passwd.count <= 32
        {
            return true
        }
        else
        {
            return false
        }
    }
    /**
     This method is to validate user enter the valid email.
     */
    class func emailValidation(_ email:String)->Bool
    {
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
        "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
        "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
        "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
        "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
        "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    /**
     This method is to validate textField text isempty or not.
     */
    class func isEmpty(_ textField:UITextField)->Bool
    {
        
        return textField.text?.count == 0 ? true : false
    }
    /**
     This method is to validate textField text characters count.
     */
    class func isContainEnoughCharacters(_ textField:UITextField,count:Int)->Bool
    {
        return textField.text?.count < count ? false : true
    }
    /**
     This method is to validate textField1 text and textField2 text is equal or not.
     */
    class func haveSameText(_ textField1:UITextField,textField2:UITextField)->Bool
    {
        return textField1.text == textField2.text ? true : false
    }
    /**
     This method is to validate string empty or not.
     */
    class func isEmptyString(_ contentString:String)->Bool
    {
        let originalString = contentString.replacingOccurrences(of: " ", with: "")
        return originalString.count == 0 ? true : false
    }
    /**
     This method is to validate string characters count.
     */
    class func isContainEnoughCharactersInString(_ textField:String,count:Int)->Bool
    {
        return textField.count < count ? false : true
    }
}
