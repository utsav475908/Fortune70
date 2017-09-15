//
//  Http.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 04/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import Foundation


let dataGotNotificationName = Notification.Name("DataReceived")

struct Http{
    // Get Method
    

    
    static func httpRequest(session:String) {
        //var questions:String = String()
        //var questionList:[String] = [String]()
        var dicList:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        
        let url = URL(string: DecisionConstants.baseURL + "/decision-meter/sessions/\(session)/current-question")!
        //let url = URL(string: "http://sgscaiu0610.inedc.corpintra.net:8891/decision-meter/sessions/\(session)/current-question")!


        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        let request = URLRequest(url: url)
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
               print(error!.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            print(data)
           dicList =  dataParserFromUrl(givenData: data) as! Dictionary<String,AnyObject>
            print(dicList)
           NotificationCenter.default.post(name: dataGotNotificationName, object: nil, userInfo: dicList)
            //print(String.convertToDictionary(text: questions)!)
        })
        task.resume()
    }
    
    
    
    // Post Method 
     static func submitAction() {
        
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
        
      //   let parameters = ["type": "OptionBasedAnswer", "questionId": "1", "userId" : "1"] as Dictionary<String, String>
        
        //let parameters = OptionBasedModel()
        
        //create the url with URL
        let defauts = UserDefaults.standard
         let questionNumber = defauts.value(forKey: "questionId") as! String
        let sessionId = defauts.value(forKey: "session") as! String
        let url = URL(string: "http://localhost:8891/decision-meter/sessions/\(sessionId)/questions/\(questionNumber)/answer")!
        //let url = URL(string: "localhost:8891/decision-meter/sessions/0001/questions")!//change the url
        //localhost:8891/decision-meter/sessions/0001/questions
        //create the sessi`on object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
         
        
        //let postDict  = passtheJSONDictionary()
        
        
        do {
            
            request.httpBody = try JSONSerialization.data(withJSONObject:passtheJSONDictionary(), options: .prettyPrinted)
            //request.httpBody =
            // pass dictionary to nsdata object and set it as request body
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
   static func convertDictionaryToJsonObject(dictionary : [String : Any]) -> Any?{
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            // here "decoded" is of type `Any`, decoded from JSON data
            
            // you can now cast it with the right type
            if let dictFromJSON = decoded as? [String:Any] {
                // use dictFromJSON
                return dictFromJSON
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    
    
    static func passtheJSONDictionary() -> Dictionary<String,Any> {
        let defaults = UserDefaults.standard
        
        if defaults.value(forKey: "questionType") as! String == "SINGLE_OPTION"{
        let doThisForSingleChoice:[String:Any] = [
            "type": "OptionBasedAnswer" ,
            "questionId": defaults.value(forKey: "questionId") as! String,
            "chossedOptions":self.convertDictionaryToJsonObject(dictionary: ["1":SaveManager.sharedInstance().getChoiceForSingleChoice()])!
            
            
        ]
            return doThisForSingleChoice
        }
        if defaults.value(forKey: "questionType") as! String == "MULTIPLE_CHOICE"{

            
        let doThisForMultipleChoice:[String:Any] = [
            "type": "OptionBasedAnswer" ,
            "questionId": defaults.value(forKey: "questionId") as! String,
            "chossedOptions": self.convertDictionaryToJsonObject(dictionary: SaveManager.sharedInstance().getChoiceForMultipleChoice())!
        ]
            print(doThisForMultipleChoice)
            return doThisForMultipleChoice
        }
        
        if defaults.value(forKey: "questionType") as! String == "SLIDER"{
        
            let doThisForSlider:[String:Any] = [
                "type": "ScaleBasedAnswer" ,
                "questionId": defaults.value(forKey: "questionId") as! String,
                
                "scale": SaveManager.sharedInstance().getSlider()
                
            ]
            
            return doThisForSlider
        }
        
        if defaults.value(forKey: "questionType") as! String == "RATING"{
        
        let doThisForRange:[String:Any] = [
            "type": "ScaleBasedAnswer" ,
            "questionId": defaults.value(forKey: "questionId") as! String,
            
                "scale": SaveManager.sharedInstance().getRatings()
            
        ]
            return doThisForRange
        }
        
        return [:]
        
    }
    
    
}
