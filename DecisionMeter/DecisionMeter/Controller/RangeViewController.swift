//
//  RangeViewController.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 31/08/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import UIKit

class RangeViewController: UIViewController {
    var revereSliderValue:Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        self.questionTextView.text = defaults.value(forKey: "quest") as? String
        self.submitButton.alpha = 0
              //self.submitButton.alpha = 0
        // Do any additional setup after loading the view.
    }

    
    @IBOutlet weak var questionTextView: UITextView!
    //@IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scaleShow: CustomSlider!
    @IBOutlet weak var sliderValuePointer: UILabel!
    @IBOutlet weak var submitButton: CustomButton!
    
    func showSubmitButton() {
        UIView.animate(withDuration: 0.75, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            
            self.submitButton.alpha = 1.0
        }) { (isCompleted) in
            self.submitButton.alpha = 1.0
        }
    }
    
    @IBAction func ratingSliderChanged(sender: CustomSlider) {
        showSubmitButton()
        sender.isContinuous = false;
        var currentStringValue:String = "1"
        let tracRect:CGRect = scaleShow.trackRect(forBounds: scaleShow.bounds)
        let thumbRect:CGRect = scaleShow.thumbRect(forBounds: scaleShow.bounds, trackRect: tracRect, value: scaleShow.value)
//        sliderValuePointer.center = CGPoint(thumbRect.origin.x + scaleShow.frame.origin.x,  scaleShow.frame.origin.y - 20)
        sliderValuePointer.center = CGPoint(x: thumbRect.origin.x + scaleShow.frame.origin.x, y: scaleShow.frame.origin.y - 20)
        
        DispatchQueue.global(qos: .background).async {
            
            
            //print(revereSliderValue)
            print("This is run on the background queue")
            
            DispatchQueue.main.async {
                self.revereSliderValue = Int((floor(sender.maximumValue) + 1) - floor(sender.value))
                currentStringValue = String(self.revereSliderValue)
                print("This is run on the main queue, after the previous code in outer block")
                
                self.sliderValuePointer.text = currentStringValue
               
            }
        }
        
        //showSubmitButton()
        
    }
    
    func saveTheCallMethodForSliderForPost(sliderValue:Int) {
        SaveManager.sharedInstance().saveSlider(sliderString: sliderValue)
    }

    @IBAction func onSubmitButtonPressed(_ sender: UIButton) {
        self.saveTheCallMethodForSliderForPost(sliderValue: Int(self.revereSliderValue))
        Http.submitAction() 
        let thisStoryboard =     UIStoryboard(name: "Main", bundle: nil)
        let submittedVC =   thisStoryboard.instantiateViewController(withIdentifier: "submitted")
        present(submittedVC, animated: true, completion: nil)
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
