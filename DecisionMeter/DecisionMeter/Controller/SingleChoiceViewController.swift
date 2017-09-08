//
//  SingleChoiceViewController.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 31/08/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import UIKit

class SingleChoiceViewController: UIViewController, SSRadioButtonControllerDelegate {
    
    @IBOutlet weak var choiceA: SSRadioButton!
    @IBOutlet weak var choiceB: SSRadioButton!
    @IBOutlet weak var choiceC: SSRadioButton!

    var radioButtonController:SSRadioButtonsController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.submitButtonPressd.alpha = 0
        
        radioButtonController = SSRadioButtonsController(buttons: choiceA, choiceB, choiceC)
        radioButtonController!.delegate = self;
        radioButtonController!.shouldLetDeSelect = true

        // Do any additional setup after loading the view.
    }
    
    func didSelectButton(selectedButton: UIButton?) {
        //print(selectedButton)
        let selectedButton = radioButtonController?.selectedButton()
        if (selectedButton != nil) {
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                
                self.submitButtonPressd.alpha = 1.0
            }) { (isCompleted) in
                self.submitButtonPressd.alpha = 1.0
            }
            
            
        }else {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                
                self.submitButtonPressd.alpha = 0.0
            }) { (isCompleted) in
                self.submitButtonPressd.alpha = 0.0
            }
        }
        print(selectedButton?.titleLabel?.text! ?? "no value")
    }
    
    
   
    

    @IBOutlet weak var submitButtonPressd: UIButton!
    
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
