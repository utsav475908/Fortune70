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
    
    @IBOutlet weak var startButton: CustomButton!
    @IBOutlet weak var pauseButton:CustomButton!
    @IBOutlet weak var timerLabel:UILabel!
    
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
        pauseButton.isEnabled = false
        startButton.alpha = 0.0
        pauseButton.alpha = 0.0
        timerLabel.alpha = 0.0
        resetButton.alpha = 0.0
        submitButton.alpha = 0.0
        runTimer()
        addNotificationForDownloadDataFromInternet()
        // Do any additional setup after loading the view.
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
        pauseButton.isEnabled = true
    }
    
    @IBAction func pauseButtonTapped(_ sender:UIButton){
        if self.resumeTapped == false {
            timer.invalidate()
            isTimerRunning = false;
            self.resumeTapped = true;
            self.pauseButton.setTitle("Resume", for: .normal)
            
        } else {
            runTimer()
            self.resumeTapped = false
            isTimerRunning = true
            self.pauseButton.setTitle("Pause", for: .normal)
        }
    }
    
    
    @IBAction func onStartButtonPressed(_ sender: CustomButton) {
        if isTimerRunning == false {
            runTimer()
            self.startButton.isEnabled = false
        }
        
    }
    
    @IBAction func onPauseButtonPressed(_ sender: CustomButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            isTimerRunning = false
            self.resumeTapped = true
            self.pauseButton.setTitle("Resume", for: .normal)
        } else {
            runTimer()
            self.resumeTapped = false
            isTimerRunning = true
            self.pauseButton.setTitle("Pause", for: .normal)
        }
        
    }
    
    
    
    @IBAction func onResetButtonPressed(_ sender: CustomButton) {
        timer.invalidate()
        seconds = TimerConstants.kTimerConstant
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
        pauseButton.isEnabled = false
        startButton.isEnabled = true 
        
        
    }
    
    
    @IBAction func resetButtonTapped(_ sender:UIButton){
        timer.invalidate()
        seconds = TimerConstants.kTimerConstant
        timerLabel.text = timeString(time:TimeInterval(seconds))
        isTimerRunning = false
        pauseButton.isEnabled = false
        startButton.isEnabled = true 
    }
    
    
    func updateTimer() {
//        if seconds < 1 {
//            timer.invalidate()
//            // send alert to indicate time up
//        }else {
//            seconds -= 1
//            timerLabel.text = timeString(time: TimeInterval(seconds))
//            timerLabel.text = String(seconds)
//            doThePolling()
//            // write the code
//        }
        doThePolling()
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func doThePolling () {
        let defaults = UserDefaults.standard
        let token = defaults.value(forKey: "session") as? String
        print(token!)
        let theQuestionId = defaults.value(forKey: "questionId")!
        print(theQuestionId)
        //this questionId is the deciding factor
        
        //Http.httpRequest(session: token, viewController: self)
        Http.httpRequest(session: token!, viewController: self, searchNext: true)
    }
    
    
    
    @IBAction func onSubmitButtonPressed(_ sender: CustomButton) {
        doThePolling()
        
        
        //        present(vc!, animated: true, completion: nil);
    }
    
    func hasTheQuestionIdChanged(notification:NSNotification) {
        print(notification.userInfo as? Dictionary<String,AnyObject>!)
        if let arrayElementsGot = notification.userInfo as? Dictionary<String,AnyObject> {
            //navigateKey = String.getQuestionCategory(passedString: arrayElementsGot[2]).1
            // print(arrayElementsGot)
            //dictsValue["status"]!.int64Value == 404
            if  arrayElementsGot["status"]?.int64Value == 404 {
                print("Raise error")
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
            
            //            guard arrayElementsGot["questionType"] as! String != "SINGLE_OPTION", arrayElementsGot["questionType"] as! String != "MULTIPLE_CHOICE"
            //                else { return }
            
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
            
            
            //
            //        print(" i am the JURY")
            //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //        let vc = storyboard.instantiateViewController(withIdentifier: "Single") as? SingleChoiceViewController
            DispatchQueue.main.async {
                // memory management kumar utsav vvimportant
                //self.present(vc!, animated: true, completion: nil);
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
    
    
    //        func instantiateTheViewController(withIdentifier identifier:String,toNavigate navigationKey:String) -> UIViewController {
    //            //Decide.single
    //            // identifiers are like single multiple go with Decisionconstants.
    //            let returnVC : UIViewController
    //
    //            switch navigationKey {
    //            case "MULTIPLE_CHOICE":
    //              returnVC =  storyboard?.instantiateViewController(withIdentifier: DecisionConstants.multiple)
    //            case "SINGLE_OPTION":
    //              returnVC =   storyboard?.instantiateViewController(withIdentifier: DecisionConstants.single)
    //            case "RATING":
    //              returnVC =   storyboard?.instantiateViewController(withIdentifier: DecisionConstants.slider)
    //            case "RANGE":
    //               returnVC = storyboard?.instantiateViewController(withIdentifier: DecisionConstants.range)
    //
    //            default:
    //              returnVC =  storyboard?.instantiateViewController(withIdentifier: DecisionConstants.range)
    //            }
    //            return returnVC
    //
    //        }
    
    
    
    func addNotificationForDownloadDataFromInternet() {
        NotificationCenter.default.addObserver(self, selector: #selector(hasTheQuestionIdChanged), name: dataGotNotificationName, object: nil)
    }
    
    func removeNotificationForDownloadDataFromInternet() {
        NotificationCenter.default.removeObserver(self, name: dataGotNotificationName, object: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
