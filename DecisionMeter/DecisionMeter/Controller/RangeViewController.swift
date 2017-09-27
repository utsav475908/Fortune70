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
    
    @IBOutlet weak var rangeQuestionViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // according to the requirements I am setting this sliderValuePointer to alpha value 0 Kumar Utsav
        sliderValuePointer.alpha = 0
        let defaults = UserDefaults.standard
        //self.questionLabel.text = defaults.value(forKey: "quest") as? String
        self.questionLabel.text = "woeioeeor sldf sdf sdf sfd s slkflksjf fjslfjld sfldklj d klsdk sdlj  ldskl slkflksjf fjslfjld sfldklj d klsdk sdlj  ldskl slkflksjf fjslfjld sfldklj d klsdk sdlj  ldskl slkflksjf fjslfjld sfldklj d klsdk sdlj  ldskl "
        // debugging
        //self.questionLabel.text = "lore ipsuem loe lore lore ipsuem loe lore lore ipsuem loe lore lore ipsuem loe lore  "
        // debugging
        let height = heightForView(text: self.questionLabel.text!, width: self.questionLabel.frame.size.width)
        print(height)
        
        rangeQuestionViewHeightConstraint.constant = height + 250
        self.submitButton.alpha = 0
              //self.submitButton.alpha = 0
        // Do any additional setup after loading the view.
    }

    
    @IBOutlet weak var questionLabel: UILabel!
    //@IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scaleShow: CustomSlider!
    @IBOutlet weak var sliderValuePointer: UILabel!
    @IBOutlet weak var submitButton: CustomButton!
    
    //MARK:HEIGHT FOR THE VIEW
    func heightForView(text:String, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont(name: "CorporateS-Regular", size: 18.0)
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }
    
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
