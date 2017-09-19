//
//  HttpRouting.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 19/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import Foundation

struct HttpRouting{
    // Get Method
    
    
    
    static func httpRequestRouting(session:String, viewController:UIViewController) {
        //var questions:String = String()
        //var questionList:[String] = [String]()
        var dicList:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        //let urlTest = URL(string: DecisionConstants.baseURL + "/decision-meter/sessions/\(session)/current-question")!
        let url = URL(string: DecisionConstants.baseURL + DecisionConstants.appURL + "\(session)/current-question")!
        //let url = URL(string: "http://sgscaiu0610.inedc.corpintra.net:8891/decision-meter/sessions/\(session)/current-question")!
        
        
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        let request = URLRequest(url: url)
        MBProgressHUD.showAdded(to: viewController.view, animated: true)
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            Thread.sleep(forTimeInterval: 1)
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: viewController.view, animated: true)
            }
            print(data)
            dicList =  dataParserFromUrl(givenData: data) as! Dictionary<String,AnyObject>
            print(dicList)
            NotificationCenter.default.post(name: dataGotNotificationName, object: nil, userInfo: dicList)
            //print(String.convertToDictionary(text: questions)!)
        })
        task.resume()
}

}

