//
//  WaitingViewController.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 19/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import UIKit

class WaitingViewController: UIViewController {
    struct TimerConstants {
        static let kTimerConstant:Int = 60
    }
    
    @IBOutlet weak var startButton: CustomButton!
    @IBOutlet weak var pauseButton:CustomButton!
    @IBOutlet weak var timerLabel:UILabel!
    
    var seconds = TimerConstants.kTimerConstant
    var timer = Timer()
    
    var isTimerRunning = false;
    var resumeTapped = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseButton.isEnabled = false
        addNotificationForDownloadDataFromInternet()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeNotificationForDownloadDataFromInternet() 
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
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
        if seconds < 1 {
            timer.invalidate()
            // send alert to indicate time up
        }else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
            timerLabel.text = String(seconds)
        }
        
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    
    
    
    
    @IBAction func onSubmitButtonPressed(_ sender: CustomButton) {
        let defaults = UserDefaults.standard
        let token = defaults.value(forKey: "session") as? String
        print(token!)
        let theQuestionId = defaults.value(forKey: "questionId")!
        print(theQuestionId)
        //this questionId is the deciding factor 
        
      //Http.httpRequest(session: token, viewController: self)
        Http.httpRequest(session: token!, viewController: self, searchNext: true)
        
        
//        present(vc!, animated: true, completion: nil);
    }
    
    func hasTheQuestionIdChanged() {
        print(" i am the JURY")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Single") as? SingleChoiceViewController
        DispatchQueue.main.async {
            // memory management kumar utsav vvimportant 
            self.present(vc!, animated: true, completion: nil);
        }
        
    }
    
    
    
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
