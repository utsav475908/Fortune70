//
//  Http.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 04/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import Foundation

struct Http{
    // Get Method
    static func httpRequest() {
        
        //create the url with NSURL
//        let url = URL(string: "http://localhost:3000/posts")!
        //change the url
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        //http://localhost:3000/posts
        //create the session object
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
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    
    
    // Post Method 
     static func submitAction() {
        
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
        
        let parameters = ["title": "Utsav", "body": "Kumar", "userId" : "1"] as Dictionary<String, String>
        
        //create the url with URL
        let url = URL(string: "http://jsonplaceholder.typicode.com/posts")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
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
    
    
}
