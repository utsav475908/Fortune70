//: Playground - noun: a place where people can play

import UIKit





//public func queryAllFlightsWithClosure(completionHandler : (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void ) {

//public func queryAllFlightsWithClosure(completionHandler:(response:NSURLResponse!, data:NSData!, error:NSError!) -> Void){
//    completionHandler
//}

let session = "2323"


let url = URL(string: "http://localhost:8891/decision-meter/sessions/\(session)/current-question")!
print(url)

