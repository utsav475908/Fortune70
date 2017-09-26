 //
 //  WaitingViewController.swift
 //  DecisionMeter
 //
 //  Created by Avishek Sinha on 19/09/17.
 //  Copyright © 2017 Avishek Sinha. All rights reserved.
 //
 
 import UIKit
 
 struct Decide {
    static let single:String = "Single"
    static let multiple:String = "Multiple"
    static let slider:String = "Slider"
    static let range:String = "Rating"
    static let baseURL:String = "http://localhost:8891"
    //static let baseURL:String = "http://sgscaiu0610.inedc.corpintra.net:8891"
    static let appURL:String = "/decision-meter/sessions/"
 }
 
 class WaitingViewController: UIViewController {
    struct TimerConstants {
        static let kTimerConstant:Int = 10
    }
    

    @IBOutlet weak var resetButton: CustomButton!
    var seconds = TimerConstants.kTimerConstant
    var timer = Timer()
    var navigationKey:String?
    var isTimerRunning = false;
    var resumeTapped = false;
    var errorCode404:Int?
    
    @IBOutlet weak var submitButton: CustomButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        //submitButton.alpha = 1.0
        runTimer()
        addNotificationForDownloadDataFromInternet()
     
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeNotificationForDownloadDataFromInternet() 
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
       
    }

    func updateTimer() {

        doThePolling()
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func questionIdIncrement() {
        let defauts = UserDefaults.standard
        let questionNumber = defauts.value(forKey: "questionId") as! String
        let questionId = Int(questionNumber)! + 1
        let stringQuestionId = String(questionId)
        defauts.set(stringQuestionId, forKey: "questionId")
        defauts.synchronize()
    }
    
    func doThePolling () {
        let defaults = UserDefaults.standard
        let token = defaults.value(forKey: "session") as? String
        print(token!)
        let theQuestionId = defaults.value(forKey: "questionId")!
        print(theQuestionId)
        questionIdIncrement() // lets increment the question. 
        Http.httpRequest(session: token!, viewController: self, searchNext: true)
    }
    
    
    
    @IBAction func onSubmitButtonPressed(_ sender: CustomButton) {
        questionIdIncrement()
        doThePolling()
        
        
        //        present(vc!, animated: true, completion: nil);
    }
    
    func addGestureRecognizerForThis(){
        
        DispatchQueue.main.async {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.navigateToLoginVC(_:)))
            self.view.addGestureRecognizer(tapGesture)
            tapGesture.numberOfTapsRequired = 8
        }
        
    }
    
    func navigateToLoginVC(_ sender: UITapGestureRecognizer) {
        // navigate to login vc.
        let loginVC =   storyboard?.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        present(loginVC, animated: true, completion: nil)
    }
    
    func hasTheQuestionIdChanged(notification:NSNotification) {
        //print(notification.userInfo as? Dictionary<String,AnyObject>!)
        if let arrayElementsGot = notification.userInfo as? Dictionary<String,AnyObject> {

            if  arrayElementsGot["status"]?.int64Value == 404 {
                print("Raise error")
                addGestureRecognizerForThis()
                /*
                 DispatchQueue.main.async {
                 [weak self] value in
                 let ac =  UIAlertController.alertWithTitle(title: "NO Question", message: "NO Question", buttonTitle: "NO Question")
                 //                    self?.tokenTextField.text = ""
                 // the question has not changed , so stay upon this page or throw error.
                 self?.present(ac, animated: true, completion: nil)
                 
                 }
                 */
            }
            // you have got the success
//            if  arrayElementsGot["status"]?.int64Value == 404 {
//            questionIdIncrement()
            
            let defaults = UserDefaults.standard
            // MULTIPLE_CHOICE
            
            if var errorCode404  = arrayElementsGot["status"] {
                errorCode404 = arrayElementsGot["status"]!
                print(errorCode404 as! Int )
            }
            
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
            
            // nav key
            navigationKey = arrayElementsGot["questionType"] as? String
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let returnVC : UIViewController
            switch navigationKey {
                
            case "MULTIPLE_CHOICE"?:
                returnVC =  storyboard.instantiateViewController(withIdentifier: DecisionConstants.multiple) as! MultipleChoiceViewController
                
            case "SINGLE_OPTION"?:
                returnVC =   storyboard.instantiateViewController(withIdentifier: DecisionConstants.single) as! SingleChoiceViewController
            case "RATING"?:
                returnVC =   storyboard.instantiateViewController(withIdentifier: DecisionConstants.range) as! RatingViewController
            case "RANGE"?:
                returnVC = storyboard.instantiateViewController(withIdentifier: DecisionConstants.slider) as! RangeViewController
                
            default:
                returnVC =  storyboard.instantiateViewController(withIdentifier: DecisionConstants.waiting) as! WaitingViewController
                // Please handle this case kumar utsav
                // ToDo: //
            }

            DispatchQueue.main.async {

                self.presentTheViewController(viewController: returnVC)
            }
            
        }
        
        
    }
    func presentTheViewController(viewController:UIViewController){
        if viewController is WaitingViewController {
            // do nothing
        }else {
            self.present(viewController, animated: true, completion: nil);
        }
    }
    
    
    
    
    
    func addNotificationForDownloadDataFromInternet() {
        NotificationCenter.default.addObserver(self, selector: #selector(hasTheQuestionIdChanged), name: dataGotNotificationName, object: nil)
    }
    
    func removeNotificationForDownloadDataFromInternet() {
        NotificationCenter.default.removeObserver(self, name: dataGotNotificationName, object: nil)
    }
    

    
 }
