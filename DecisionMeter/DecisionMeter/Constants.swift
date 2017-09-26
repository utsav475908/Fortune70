//
//  Constants.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 01/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import Foundation


struct DecisionConstants {
    static let single:String = "Single"
    static let multiple:String = "Multiple"
    static let slider:String = "Slider"
    static let waiting:String = "Waiting"
    static let range:String = "Rating"
    //static let baseURL:String = "http://localhost:8891"
    static let baseURL:String = "http://sgscaiu0610.inedc.corpintra.net:8891"
    static let appURL:String = "/decision-meter/sessions/"
}

struct QuestionTypeConstants {
   static let MULTIPLE_CHOICE = "MULTIPLE_CHOICE"
   static  let  SINGLE_OPTION = "SINGLE_OPTION"
   static  let  RATING = "RATING"
   static  let  SLIDER = "RANGE"

}
