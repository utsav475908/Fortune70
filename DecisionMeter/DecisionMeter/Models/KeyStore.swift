//
//  KeyStore.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 14/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import Foundation
final class  KeyStore {
    
    private init() {}
    
    static let shared = KeyStore()
    
    static  func saveTheQuestion(withValue value:String , withKey key:String) {
        let storeChain =  UserDefaults.standard
        storeChain.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }

    static func saveTheOptions(optionsDictionary:[String:String], withKey optionsKey:String) {
        let storeChain = UserDefaults.standard
        storeChain.set(optionsDictionary, forKey: optionsKey)
        UserDefaults.standard.synchronize()
    }
    
    static func retreiveTheQuestion(questionKey:String) -> String  {
        return UserDefaults.standard.value(forKey: questionKey) as! String
    }
    
    static func retreiveTheOptions(giveOptionKey:String)->[String:String] {
        return UserDefaults.standard.value(forKey: giveOptionKey) as! [String : String]
    }
    
}

