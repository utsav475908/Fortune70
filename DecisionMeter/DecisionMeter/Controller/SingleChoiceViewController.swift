//
//  SingleChoiceViewController.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 31/08/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
// LOOKS OUT THE OPTIOS FROM THE WEBSERVICE AND DO THE THING .. TO DO  KUMAR UTSAV
// answer == answer

import UIKit

class SingleChoiceViewController: UIViewController, SSRadioButtonControllerDelegate {
    
    @IBOutlet weak var choiceA: SSRadioButton!
    @IBOutlet weak var choiceB: SSRadioButton!
    @IBOutlet weak var choiceC: SSRadioButton!
    @IBOutlet weak var choiceD: SSRadioButton!
   // @IBOutlet weak var choiceD: SSRadioButton!
    @IBOutlet weak var questionTextView: UITextView!
    
    var radioButtonController:SSRadioButtonsController?
    
    //@IBOutlet weak var postQuestion: UILabel!
    // the question from the webservice will be coming here
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        
        self.questionTextView.text = defaults.value(forKey: "quest") as? String
        let questionDictionary = defaults.value(forKey: "options") as! [String:String]
//        for (key,value) in questionDictionary {
//            choiceA.titleLabel?.text = value
//            choiceB.titleLabel?.text = value
//            choiceC.titleLabel?.text = value
//            //choiceD.titleLabel?.text = value
//        }
        choiceA.setTitle(questionDictionary["1"], for: .normal)
        choiceB.setTitle(questionDictionary["2"], for: .normal)
        choiceC.setTitle(questionDictionary["3"], for: .normal)
        choiceD.setTitle(questionDictionary["4"], for: .normal)
        
    
        let spaceA = "    " + (choiceA.titleLabel?.text!)!
        let spaceB = "    " + (choiceB.titleLabel?.text!)!
        let spaceC = "    " + (choiceC.titleLabel?.text!)!
        let spaceD = "    " + (choiceD.titleLabel?.text!)!
        
        choiceA.titleLabel?.text = spaceA
        choiceB.titleLabel?.text = spaceB
        choiceC.titleLabel?.text = spaceC
        choiceD.titleLabel?.text = spaceD 
        
        
        
        
        
        self.submitButtonPressd.alpha = 0
        
        radioButtonController = SSRadioButtonsController(buttons: choiceA, choiceB, choiceC, choiceD)
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
        let defaults = UserDefaults.standard
        defaults.set(selectedButton?.titleLabel?.text, forKey: "answer")
        defaults.synchronize()
    }
    
    func saveForTheSingleChoiceVC() -> [String : String ] {
      return [String(describing: radioButtonController!
        .selectedButton()!.tag): (radioButtonController?.selectedButton()?.titleLabel?.text!)!]
    }
    
    func saveitToSaveManager() {
        SaveManager.sharedInstance().saveChoiceForSingleChoice(choiceStringText: saveForTheSingleChoiceVC())
    }
   
    

    @IBOutlet weak var submitButtonPressd: UIButton!
    
    @IBAction func onSubmitButtonPressed(_ sender: UIButton) {
        saveitToSaveManager()
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
