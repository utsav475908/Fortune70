////
////  ViewRouter.swift
////  DecisionMeter
////
////  Created by Avishek Sinha on 15/09/17.
////  Copyright © 2017 Avishek Sinha. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class ViewRouter : UIViewController{
//    
//    //func routeTheView(ofType type:String, questions questionString,givenOptionalOptions options:Dictionary){
//    
//    var controllers:[UIViewController] = [UIViewController]()
//    
//    
//    let thisStoryboard =     UIStoryboard(name: "Main", bundle: nil)
//    
//    func routeTheView(idType id:String , ofType type:String, questions questionString:String , givenOptionalOptions options:NSDictionary) ->Void {
//        
//        
//        switch type {
//        case DecisionConstants.range:
//            let submittedVC =   thisStoryboard.instantiateViewController(withIdentifier: DecisionConstants.range)
//            present(submittedVC, animated: true, completion: nil)
//        default:
//            
//        }
//        
//    }
//    
//    
//    func createAnArrayOfVC() ->[UIViewController] {
//        let myVC = UIStoryboard(name: "Main", bundle: nil)
//        let vc0:UIViewController =  myVC.instantiateViewController(withIdentifier: DecisionConstants.multiple)
//        let vc1:UIViewController = myVC.instantiateViewController(withIdentifier: DecisionConstants.single)
//        let vc2:UIViewController = myVC.instantiateViewController(withIdentifier: DecisionConstants.range)
//        let vc3:UIViewController = myVC.instantiateViewController(withIdentifier: DecisionConstants.slider)
//        
//        var multipleVC = [vc0,vc1,vc2,vc3]
//        print(multipleVC)
//        return multipleVC;
//    }
//
//        
//    
//}
