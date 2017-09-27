
//  ViewController.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 31/08/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

// question == question
// option == option
// session == session 

import UIKit

enum QuestionType: String {
    
    case MULTIPLE_CHOICE = "MULTIPLE_CHOICE"
    case SINGLE_OPTION = "SINGLE_OPTION"
    case RATING = "RATING"
    case SLIDER = "SLIDER"
    
    
    static func parse(s:String) -> QuestionType {
        switch s {
        case "MULTIPLE_CHOICE": return .MULTIPLE_CHOICE
        case "SINGLE_OPTION": return .SINGLE_OPTION
        //case "SINGLE_OPTION": return .MULTIPLE_CHOICE
        case "RATING": return .RATING
        case "SLIDER": return .SLIDER
            
        default :
            return .RATING
            
        }
    }
}


class LoginViewController: UIViewController, UITextFieldDelegate{
    var navigateKey:String = String()
    var controllers:[UIViewController] = [UIViewController]()
    // 4 outlets image,label,textfield,button
    @IBOutlet weak var daimlerImageView: UIImageView!
    @IBOutlet weak var attendeeLabel: UILabel!
    @IBOutlet weak var tokenTextField: UITextField!
    @IBOutlet weak var loginButton: CustomButton!
    // action for the login button 
    
    @IBAction func doLoginTask(_ sender: CustomButton) {
        let defaults = UserDefaults.standard
        
        defaults.set(self.tokenTextField.text, forKey: "session")
        
        defaults.synchronize()
        //Http.httpRequest(session: self.tokenTextField.text!)
        Http.httpRequest(session: self.tokenTextField.text!, viewController: self)
        // only after the successful callback invokeTheSegueAfterTheWebService()
        
    }
    
    func invokeTheSegueAfterTheWebService (navigationKey:String) {
       // controllers =   createAnArrayOfVC()
       // print(controllers)
        
//        switch navigationKey {
//
//        case "MULTIPLE_CHOICE": present(controllers[0], animated: true, completion: nil)
//        case "SINGLE_OPTION": present(controllers[1], animated: true, completion: nil)
//        case "RATING": present(controllers[2], animated: true, completion: nil)
//        case "RANGE": present(controllers[3], animated: true, completion: nil)
//        default: present(controllers[3], animated: true, completion: nil)
//        }
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let returnVC : UIViewController
        switch navigationKey {
            
        case "MULTIPLE_CHOICE":
            returnVC =  storyboard.instantiateViewController(withIdentifier: DecisionConstants.multiple) as! MultipleChoiceViewController
            
        case "SINGLE_OPTION":
            returnVC =   storyboard.instantiateViewController(withIdentifier: DecisionConstants.single) as! SingleChoiceViewController
        case "RATING":
            returnVC =   storyboard.instantiateViewController(withIdentifier: DecisionConstants.range) as! RatingViewController
        case "RANGE":
            returnVC = storyboard.instantiateViewController(withIdentifier: DecisionConstants.slider) as! RangeViewController
            
        default:
            returnVC =  storyboard.instantiateViewController(withIdentifier: DecisionConstants.waiting) as! WaitingViewController
            // Please handle this case kumar utsav
            // ToDo: //
        }
        
        DispatchQueue.main.async {
            
            self.present(returnVC, animated: true, completion: nil)
            
        }
        
    }
        
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //self.loginButton.alpha = 1
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        return true
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        var startString = ""
        if (textField.text != nil)
        {
            startString += textField.text!
        }
        startString += string
        let  limitNumber = startString.characters.count
        if limitNumber > 4
        {
            UIView.animate(withDuration: 0.75, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                
                self.loginButton.alpha = 1.0
            }) { (isCompleted) in
                self.loginButton.alpha = 1.0
            }
            return false
        }
        else if limitNumber == 4 {
            if self.loginButton.alpha == 1 {
                UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                    
                    self.loginButton.alpha = 0.0
                }) { (isCompleted) in
                    self.loginButton.alpha = 0.0
                }
                return true
            }
            UIView.animate(withDuration:0.75 , delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                
                self.loginButton.alpha = 1
            }) { (isCompleted) in
                self.loginButton.alpha = 1
            }
            return true;
        }
            
            
            
        else
        {
            UIView.animate(withDuration: 0.75, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                
                self.loginButton.alpha = 0
            }) { (isCompleted) in
                self.loginButton.alpha = 0
            }
            return true;
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    // MARK: Notification Method calls Show
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    // MARK: Notification Method calls Hide
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        removeListOfNotifications()
    }
    
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    func removeNotificationForKeyboard(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UIKeyboardWillShowNotification"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UIKeyboardWillHideNotification"), object: nil)
        
    }
    
    func addNotificationForKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func respondToTokenTextField() {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
        self.loginButton.alpha = 0
        tokenTextField.delegate = self;
    }
    
    func addNotificationForDownloadDataFromInternet() {
        NotificationCenter.default.addObserver(self, selector: #selector(dataDownloaded), name: dataGotNotificationName, object: nil)
    }
    
    func removeNotificationForDownloadDataFromInternet() {
        NotificationCenter.default.removeObserver(self, name: dataGotNotificationName, object: nil)
    }
    // MARK: data downloaded callback 
    func questionIdIncrement() {
        let defauts = UserDefaults.standard
        let questionNumber = defauts.value(forKey: "questionId") as! String
        let questionId = Int(questionNumber)! + 1
        let stringQuestionId = String(questionId)
        defauts.set(stringQuestionId, forKey: "questionId")
        defauts.synchronize()
    }
    
    func dataDownloaded(notification:NSNotification) {
        let kQuestionUnAvailable = "QUESTION_UNAVAILABLE"
        let kQuestionAnswered = "QUESTION_ALREADY_ANSWERED"
        if let arrayElementsGot = notification.userInfo as? Dictionary<String,AnyObject> {
      
            
            if  arrayElementsGot["status"]?.int64Value == 404 {
                if arrayElementsGot["message"] as! String  == kQuestionUnAvailable{
                    print("question is unavailable")
                    return
                }
               if  arrayElementsGot["message"] as! String  == kQuestionAnswered {
                questionIdIncrement()
                //let defaults = UserDefaults.standard
                let session = tokenTextField.text!
                //let session = defaults.value(forKey: "session") as! String
                print("critical")
                Http.httpRequest(session: session, viewController:self , searchNext: true)
                return 
                }
                print("Raise error")
                DispatchQueue.main.async {
                    [weak self] value in
//                    let ac =  UIAlertController.alertWithTitle(title: "TOKEN", message: "TOKEN", buttonTitle: "TOKEN")
//                    self?.tokenTextField.text = ""
//                    self?.present(ac, animated: true, completion: nil)
                    
//                    UIView.animate(withDuration: 0.75, animations: {
//                        self?.attendeeLabel.textColor = UIColor.red
//                        self?.attendeeLabel.text = "Enter correct token"
//                    }, completion: { (complete) in
//                        self?.attendeeLabel.text = "Enter correct token"
//                    })
                    
                    UIView.animate(withDuration: 0.75, delay: 0, options: .curveEaseIn, animations: {
                        self?.attendeeLabel.textColor = UIColor.red
                        self?.attendeeLabel.text = "Enter correct token"
                    }, completion: { (complete) in
                        self?.attendeeLabel.text = "Enter correct token"
                    })
        
                    
                }
            }
            
            // use keystore
            // question
            let defaults = UserDefaults.standard
            // MULTIPLE_CHOICE
            

            
            if let _ = arrayElementsGot["questionString"], (arrayElementsGot["questionId"] != nil), (arrayElementsGot["questionType"] != nil) {
                defaults.set(arrayElementsGot["questionString"]!, forKey: "quest")
                defaults.set(arrayElementsGot["questionId"]!, forKey: "questionId")
                defaults.set(arrayElementsGot["questionType"], forKey: "questionType")
                defaults.synchronize()
            }
      
            
            if let _ = arrayElementsGot["questionType"] {
                
                if  arrayElementsGot["questionType"] as! String == "SINGLE_OPTION" {
                    defaults.set(arrayElementsGot["options"], forKey: "options")
                    defaults.synchronize()
                }
                
                if  arrayElementsGot["questionType"] as! String == "MULTIPLE_CHOICE" {
                    defaults.set(arrayElementsGot["options"], forKey: "options")
                    defaults.synchronize()
                }
            }
            
            if var errorCode404  = arrayElementsGot["status"] {
                errorCode404 = arrayElementsGot["status"]!
                print(errorCode404 as! Int )
                print("TOKEN ERROR THROWING! ALERT ALERT ALERT")
                return 
            }
            
            
            
            
            
            defaults.synchronize()
            

            
            DispatchQueue.main.async {
                [weak self] value in
                self?.invokeTheSegueAfterTheWebService(navigationKey: arrayElementsGot["questionType"]! as! String)
            }
            
        }
        
    }
    
    func addedListOfNotifications() {
        addNotificationForKeyboard()
        addNotificationForDownloadDataFromInternet()
    }
    
    func removeListOfNotifications() {
        removeNotificationForDownloadDataFromInternet()
        removeNotificationForKeyboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loginviewcontroller" + serverEndPointURL)
        self.tokenTextField.borderStyle = UITextBorderStyle.roundedRect 
        respondToTokenTextField()
        addedListOfNotifications()
        
        // delete this
        
        #if Debug
            serverEndPointURL = "www.google.com"
        #elseif Testing
            serverEndPointURL = "www.youtube.com"
            
        #elseif Staging
            serverEndPointURL = "www.apple.com"
            
        #elseif Release
            serverEndPointURL = "www.gmail.com"
            
        #elseif Production
            serverEndPointURL = "www.yahoo.com"
            
        #endif

  
    }
    
//    func createAnArrayOfVC() ->[UIViewController] {
//        let myVC = UIStoryboard(name: "Main", bundle: nil)
//        let vc0:UIViewController = myVC.instantiateViewController(withIdentifier: DecisionConstants.multiple)
//        let vc1:UIViewController = myVC.instantiateViewController(withIdentifier: DecisionConstants.single)
//        let vc2:UIViewController = myVC.instantiateViewController(withIdentifier: DecisionConstants.range)
//        let vc3:UIViewController = myVC.instantiateViewController(withIdentifier: DecisionConstants.slider)
//        
//        let multipleVC = [vc0,vc1,vc2,vc3]
//        print(multipleVC)
//        return multipleVC;
//    }
    
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print(navigateKey)
//
//        let myVC = UIStoryboard(name: "Main", bundle: nil)
//        let vc0:UIViewController =  myVC.instantiateViewController(withIdentifier: DecisionConstants.multiple)
//        let vc1:UIViewController = myVC.instantiateViewController(withIdentifier: DecisionConstants.single)
//        let vc2:UIViewController = myVC.instantiateViewController(withIdentifier: DecisionConstants.range)
//        let vc3:UIViewController = myVC.instantiateViewController(withIdentifier: DecisionConstants.slider)
//
//        var multipleVC = [vc0,vc1,vc2,vc3]
//        print(multipleVC)
//
//    }
    
    
    
    
    
    
}

