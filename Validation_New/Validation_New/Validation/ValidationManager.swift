//
//  Validation.swift
//  Validation_New
//
//  Created by PHN MAC 1 on 13/10/23.
//

import Foundation



final class ValidationManager{
   
    func name(_ value:String?) -> (error: String, isSuccess: Bool){
        let warning = NameWarning()
        let name = (value ?? "").trimmingCharacters(in: .whitespaces)
         if name.isEmpty{
             return(warning.empty,false)
         }
        let set = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ")
        if(name.rangeOfCharacter(from: set.inverted) != nil ){
            return(warning.notValid,false)
        }
         return("",true)
    }
    
     func mobileNumber(_ value : String?) -> (error: String, isSuccess: Bool){
        let warning = MobileWarning()
        let mobile = (value ?? "").trimmingCharacters(in: .whitespaces)
        if mobile.isEmpty{
            return(warning.empty, false)
        }
        else if mobile.count != 10{
            return (warning.notTenDigit, false)
        }
        else{
            let phoneRegex = "^[6-9]\\d{9}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            if phoneTest.evaluate(with: mobile){
                return ("", true)
            }
            else{
                return(warning.notValid,false)
            }
        }
    }
    
     func email(_ value:String?) -> (error: String, isSuccess: Bool){
        let warning = EmailWarning()
        let email = (value ?? "").trimmingCharacters(in: .whitespaces)
        if email.isEmpty{
            return(warning.empty, false)
        }
        else{
            // let reqularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let reqularExpression = "[A-Z0-9a-z._]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
            if !predicate.evaluate(with: email){
                return (warning.notValid, false)
            }
            else{
                return("",true)
            }
        }
    }
    
    func age(_ value:String?) -> (error: String, isSuccess: Bool){
        let warning = AgeWarning()
        let email = (value ?? "").trimmingCharacters(in: .whitespaces)
        if email.isEmpty{
            return(warning.empty, false)
        }
        return("",true)
    }
    
    func password(_ value: String?) -> (error: String, isSuccess: Bool) {
        let warning = PasswordWarning()
        let password = (value ?? "").trimmingCharacters(in: .whitespaces)
        if password.isEmpty{
            return(warning.empty, false)
        }
        else{
            let reqularExpression = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
            let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
            if !predicate.evaluate(with: password){
                return (warning.notSecure, false)
            }
            else{
                return("",true)
            }
        }
    }
}
