//
//  MultipleChoiceViewController.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 31/08/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import UIKit

class MultipleChoiceViewController: UIViewController {
  var submitCounter : Int = 0
    @IBOutlet weak var optionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.submitButton.alpha = 0
        //showSubmitButton()
    }
    
    func showSubmitButton() {
        for case let button as ISRadioButton in self.view.subviews {
            if button.isSelected == true{
                self.submitButton.alpha = 1
               print("isRadiobutton detected")
            }
            
        }
    }
    @IBOutlet var multipleRadioButton: [ISRadioButton]!

    @IBAction func onMultipleChoiceButtonPressed(_ sender: ISRadioButton) {
        
    
        if sender.isSelected {
            submitCounter += 1
        } else {
            submitCounter -= 1
        }
        
        if submitCounter > 0 {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                
                self.submitButton.alpha = 1.0
            }) { (isCompleted) in
                self.submitButton.alpha = 1.0
            }

        }else {
            self.submitButton.alpha = 0
        }
        
        //print(multipleRadioButton)
    }



    @IBOutlet weak var submitButton: CustomButton!
    
    
    
    @IBAction func onSubmitButtonPressed(_ sender: UIButton) {
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
