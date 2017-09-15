//
//  StringExtension.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 14/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import Foundation

extension String {
    
    static func giveKeyAndValue(givenString:String) -> (key:String , value:String ){
        let some = givenString.components(separatedBy: ":")
        return (some[0], some[1])
    }
    
    static func getQuestionType(passedString:String) -> (String, String){
        return giveKeyAndValue(givenString:passedString)
    }
    
    static func getQuestionCategory(passedString:String) -> (String, String){
        return giveKeyAndValue(givenString:passedString)
    }
    
    static func getQuestionToDisplay(passedString:String) -> (String, String) {
        return giveKeyAndValue(givenString: passedString)
    }
    
    static func getOptions(passedString:[String]) -> Any? {
        return nil
    }

static func replaceStringWithBraces(stringValue:String) ->String {
    var displayedString = stringValue
    displayedString =     displayedString.replacingOccurrences(of: "{", with: "")
    displayedString = displayedString.replacingOccurrences(of: "}", with: "")
    displayedString =  displayedString.replacingOccurrences(of: "\n", with: "")
    displayedString =  displayedString.replacingOccurrences(of: "\"", with: "")
    displayedString =  displayedString.replacingOccurrences(of: "=", with: " : ")
    displayedString =  displayedString.replacingOccurrences(of: ";", with: "")
    displayedString = displayedString.replacingOccurrences(of: "[", with: "")
    displayedString = displayedString.replacingOccurrences(of: "]", with: "")
    return displayedString
    }
    
    static func convertToDictionary(text:String) ->[String:Any]?{
    if let  data = text.data(using: .utf8){
        do {
            return try (JSONSerialization.jsonObject(with: data, options: []) as? [String : Any])
        }
        catch {
            print(error.localizedDescription)
        }
        
        
        }
         return nil
    }
   
    
}
