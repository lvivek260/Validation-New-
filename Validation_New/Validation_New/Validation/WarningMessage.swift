//
//  WarningMessage.swift
//  Validation_New
//
//  Created by PHN MAC 1 on 13/10/23.
//

import Foundation
// Password validation: At least 8 characters long, containing letters and numbers
struct NameWarning{
    let empty = "Name cannot be empty"
    let notValid = "special character, number not valid"
}
struct MobileWarning{
    let empty = "Mobile number cannot be empty"
    let notTenDigit = "Mobile number should be of 10 digit"
    let notValid = "Please enter valid mobile number"
}
struct EmailWarning{
    let empty = "Email id cannot be empty"
    let notValid = "Email id should be valid"
}
struct AgeWarning{
    let empty = "Age cannot be empty"
}
struct PasswordWarning{
    let empty = "Password cannot be empty"
    let notSecure = "At least minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character"
}
