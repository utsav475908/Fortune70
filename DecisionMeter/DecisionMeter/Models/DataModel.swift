//
//  DataModel.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 04/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import Foundation

struct DataModel {
    
    var session: Int
    var questionId: Int
    var timeStamp: Timer?
    var sessionId: Int
    
    
}

struct ListedDataModels {
    
    var models = [DataModel]()
}
