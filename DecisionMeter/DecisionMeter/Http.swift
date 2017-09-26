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
    
    //    let UUID = UIDevice.current.identifierForVendor!.uuidString
    
    static func questionIdReset() {
        let defaults = UserDefaults.standard
        defaults.set("1", forKey: "questionId")
        defaults.synchronize()
    }
    
    static func switchTheURL(withSession sessionString:String, searchNext:Bool = false) -> URL {
        let urlHolder:URL
        if searchNext {
            let defaults = UserDefaults.standard
            let questionNumber:Int   = Int(defaults.value(forKey: "questionId")! as! String)!
            let questionId = String(questionNumber)
            defaults.set(String(describing: questionNumber), forKey: "questionId")
            defaults.synchronize()
            
            urlHolder = URL(string: DecisionConstants.baseURL + DecisionConstants.appURL + "\(sessionString)/questions/\(questionId)")!
        }else {
            //urlHolder = URL(string: DecisionConstants.baseURL + DecisionConstants.appURL + "\(sessionString)/current-question")!
            questionIdReset()
            let defaults = UserDefaults.standard
            let questionID = String(describing: defaults.value(forKey: "questionId")!)
            urlHolder = URL(string: DecisionConstants.baseURL + DecisionConstants.appURL + "\(sessionString)/questions/\(questionID)")!
            
        }
        print("url formatted is \(urlHolder) " )
        return urlHolder
    }
    
    
    static func httpRequest(session:String, viewController:UIViewController, searchNext next:Bool = false)  {
        
        var dicList:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        
        
        let url = switchTheURL(withSession: session,searchNext: next)
        print(url)
        
        let session = URLSession.shared
        var  request = URLRequest(url: url)
        request.addValue(UIDevice.current.identifierForVendor!.uuidString, forHTTPHeaderField: "x-request-id")
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: viewController.view, animated: true)
        }
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                print("HI I AM THE ERROR " + error!.localizedDescription)
                let vc = UIAlertController.alertWithTitle(title: "ERROR", message: "ERROR", buttonTitle: "ERROR")
                viewController.present(vc, animated: true, completion: nil)
                return
                
            }
            
            guard let data = data else {
                return
            }
            //Thread.sleep(forTimeInterval: 0.2)
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: viewController.view, animated: true)
            }
            //print("dictionary list got == \(data)")
            dicList =  dataParserFromUrl(givenData: data) as! Dictionary<String,AnyObject>
            print("dictionary list got == \(dicList)")
            //            NotificationCenter.default.post(name: dataGotNotificationName, object: nil, userInfo: dicList)
            postTheNotification(givenDictionary: dicList)
            //print(String.convertToDictionary(text: questions)!)
        })
        task.resume()
    }
    
    static func postTheNotification(givenDictionary dictionaryList : Dictionary<String, AnyObject>){
        NotificationCenter.default.post(name: dataGotNotificationName, object: nil, userInfo: dictionaryList)
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
        // appURL = decision-meter/sessions   and baseURL = localhost://8891
        let url = URL(string: DecisionConstants.baseURL + DecisionConstants.appURL + "\(sessionId)/questions/\(questionNumber)/answer")!
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
            request.setValue("#c$m#876ty12itu3428$z$", forHTTPHeaderField: "x-adm-client")
            request.addValue(UIDevice.current.identifierForVendor!.uuidString, forHTTPHeaderField: "x-request-id")
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
    
    
    
    
    static func passtheJSONDictionary() -> Dictionary<String,Any> {
        let defaults = UserDefaults.standard
        
        if defaults.value(forKey: "questionType") as! String == QuestionTypeConstants.SINGLE_OPTION{
            let doThisForSingleChoice:[String:Any] = ["requesterId": UIDevice.current.identifierForVendor!.uuidString,
                                                      "type": "OptionBasedAnswer" ,
                                                      "questionId": defaults.value(forKey: "questionId") as! String,
                                                      "chossedOptions":SaveManager.sharedInstance().getChoiceForSingleChoice()
                
                
            ]
            print(SaveManager.sharedInstance().getChoiceForSingleChoice())
            print(["1":SaveManager.sharedInstance().getChoiceForSingleChoice()])
            print(doThisForSingleChoice)
            
            return doThisForSingleChoice
        }
        if defaults.value(forKey: "questionType") as! String == QuestionTypeConstants.MULTIPLE_CHOICE{
            
            
            let doThisForMultipleChoice:[String:Any] = ["requesterId": UIDevice.current.identifierForVendor!.uuidString,
                                                        "type": "OptionBasedAnswer" ,
                                                        "questionId": defaults.value(forKey: "questionId") as! String,
                                                        "chossedOptions":SaveManager.sharedInstance().getChoiceForMultipleChoice()
            ]
            print(doThisForMultipleChoice)
            return doThisForMultipleChoice
        }
        
        
        if defaults.value(forKey: "questionType") as! String == QuestionTypeConstants.RATING{
            
            let doThisForSlider:[String:Any] = ["requesterId": UIDevice.current.identifierForVendor!.uuidString,
                                                "type": "ScaleBasedAnswer" ,
                                                "questionId": defaults.value(forKey: "questionId") as! String,
                                                
                                                "scale": SaveManager.sharedInstance().getRatings()
                
            ]
            print(doThisForSlider)
            return doThisForSlider
        }
        
        if defaults.value(forKey: "questionType") as! String == QuestionTypeConstants.SLIDER{
            
            
            let doThisForRange:[String:Any] = ["requesterId": UIDevice.current.identifierForVendor!.uuidString,
                                               "type": "ScaleBasedAnswer" ,
                                               "questionId": defaults.value(forKey: "questionId") as! String,
                                               
                                               "scale": SaveManager.sharedInstance().getSlider()
                
            ]
            print(doThisForRange)
            return doThisForRange
        }
        
        return [:]
        
    }
    
    
}
