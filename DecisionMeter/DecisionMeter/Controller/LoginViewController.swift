//
//  ViewController.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 31/08/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import UIKit

enum QuestionType: String {
    
    case MULTIPLE_CHOICE = "MULTIPLE_CHOICE"
    case SINGLE_OPTION = "SINGLE_OPTION"
    case RATINGS = "RATINGS"
    case SLIDER = "SLIDER"
    
    
    static func parse(s:String) -> QuestionType {
        switch s {
        case "MULTIPLE_CHOICE": return .MULTIPLE_CHOICE
            case "SINGLE_OPTION": return .SINGLE_OPTION
            case "SINGLE_OPTION": return .MULTIPLE_CHOICE
            case "RATINGS": return .RATINGS
            case "SLIDER": return .SLIDER
            
        default :
            return .SLIDER
        
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
    @IBOutlet weak var loginButton: UIButton!
    // action for the login button 
   
    @IBAction func doLoginTask(_ sender: UIButton) {
        
       controllers =   createAnArrayOfVC()
        print(controllers)
        
        switch navigateKey {
        
        case "MULTIPLE_CHOICE": present(controllers[0], animated: true, completion: nil)
        case "SINGLE_OPTION": present(controllers[1], animated: true, completion: nil)
        case "RATINGS": present(controllers[2], animated: true, completion: nil)
        case "SLIDER": present(controllers[3], animated: true, completion: nil)
         default: present(controllers[3], animated: true, completion: nil)
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
            UIView.animate(withDuration: 2.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                
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
            UIView.animate(withDuration:1 , delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                
                self.loginButton.alpha = 1
            }) { (isCompleted) in
                self.loginButton.alpha = 1
            }
            return true;
        }
            
            
            
        else
        {
            UIView.animate(withDuration: 1, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                
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
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UIKeyboardWillShowNotification"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UIKeyboardWillHideNotification"), object: nil)
    }
    
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
        self.loginButton.alpha = 0
        tokenTextField.delegate = self;
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        //Http.httpRequest()
        Http.submitAction()
        // Note that SO highlighting makes the new selector syntax (#selector()) look
        // like a comment but it isn't one
        
        let sampleMockDictionary:NSDictionary? = dataParserFromFile(fileName: "Mock") as? NSDictionary
        print(sampleMockDictionary ?? [:])
        navigateKey  = sampleMockDictionary!.value(forKey: "questionType")! as! String
         print(sampleMockDictionary!.value(forKey: "questionType")!)
    }
    
    func createAnArrayOfVC() ->[UIViewController] {
        let myVC = UIStoryboard(name: "Main", bundle: nil)
        let vc0:UIViewController =  myVC.instantiateViewController(withIdentifier: DecisionConstants.multiple)
        let vc1:UIViewController = myVC.instantiateViewController(withIdentifier: DecisionConstants.single)
        let vc2:UIViewController = myVC.instantiateViewController(withIdentifier: DecisionConstants.range)
        let vc3:UIViewController = myVC.instantiateViewController(withIdentifier: DecisionConstants.slider)
        
        var multipleVC = [vc0,vc1,vc2,vc3]
        print(multipleVC)
        return multipleVC;
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(navigateKey)
        
        let myVC = UIStoryboard(name: "Main", bundle: nil)
        let vc0:UIViewController =  myVC.instantiateViewController(withIdentifier: DecisionConstants.multiple)
        let vc1:UIViewController = myVC.instantiateViewController(withIdentifier: DecisionConstants.single)
        let vc2:UIViewController = myVC.instantiateViewController(withIdentifier: DecisionConstants.range)
        let vc3:UIViewController = myVC.instantiateViewController(withIdentifier: DecisionConstants.slider)
        
        var multipleVC = [vc0,vc1,vc2,vc3]
        print(multipleVC)
        
    }

    
    
    

    
}

