//
//  Password.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by 최용석 on 2018. 4. 24..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import Foundation

class Password {
    
    // The passwords to be inputted
    private let firstPW: String
    private let secondPW: String
    
    init(firstPW: String, secondPW: String) {
        self.firstPW = firstPW
        self.secondPW = secondPW
    }
    
    // Verify if blank is the password
    var isBlank: Bool {
        var isBlankString: Bool = true
        
        for char in self.firstPW {
            if char != " " {
                isBlankString = false
            }
        }
        
        return isBlankString
    }
    
    // Verify the both password are same
    var isSameAsSecondPW: Bool {
        if self.firstPW == self.secondPW {
            return true
        } else {
            return false
        }
    }
    
    // Verify the number of password characters is over 8
    var isOverEightCharacters: Bool {
        if self.firstPW.count >= 8 {
            return true
        } else {
            return false
        }
    }
    
    // Verify If the blank exists in the password
    var hasBlank: Bool {
        if self.firstPW.contains(" ") {
            return true
        } else {
            return false
        }
    }
    
    // Verify if only the number exists in the password
    var hasOnlyNumber: Bool {
        var isNumberString: Bool = true
        let pwArray: Array<Character> = Array<Character>(self.firstPW)
        
        for char in pwArray {
            if !(char == "1" || char == "2" || char == "3" || char == "4" || char == "5" || char == "6" || char == "7" || char == "8" || char == "9" || char == "0" ) {
                isNumberString = false
            }
        }
        
        return isNumberString
    }
    
    // Verify if the capital letter limited exists in the password
    var hasUppercase: Bool {
        let uppercaseLetters: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        
        return compare(self.firstPW, with: uppercaseLetters)
    }
    
    // Verify if the capital letter limited exists in the password
    var hasLowercase: Bool {
        let lowerLetters: String = "abcdefghijklmnopqrstuvwxyz"
        
        return compare(self.firstPW, with: lowerLetters)
    }
    
    // Verify if the special character exists in the password
    var hasSpecialCharacter: Bool {
        var isSpecialCharacter: Bool = false
        let commonCharacters: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890"
        let password: Array<Character> = Array<Character>(self.firstPW)
        
        for char in password {
            if !compare(commonCharacters, with: String(char)) {
                isSpecialCharacter = true
                break
            }
        }
        
        return isSpecialCharacter
    }
    
    // Verify if the number exists in the password
    var hasNumber: Bool {
        let numbers: String = "1234567890"
        
        return compare(self.firstPW, with: numbers)
    }
    
    // Compare password with some letters
    
    private func compare(_ object: String, with: String) -> Bool {
        var hasSpecificCharacter: Bool = false
        let objectString: Array<Character> = Array<Character>(object)
        let comparedString: Array<Character> = Array<Character>(with)
        
        firstLoop : for obj in objectString {
            for cmp in comparedString {
                if obj == cmp {
                    hasSpecificCharacter = true
                    break firstLoop
                }
            }
        }
        
        return hasSpecificCharacter
    }
}
