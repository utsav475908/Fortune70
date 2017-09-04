//
//  iDataParserUtils.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 01/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import Foundation

func dataParserFromFile(fileName:String) -> Any {
    var jsonResult:NSDictionary? = NSDictionary()
    if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
        do {
            let data = try!  Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
               jsonResult = try! JSONSerialization.jsonObject(with:data , options: .mutableContainers) as? NSDictionary
        }
    }
   return jsonResult!
}
