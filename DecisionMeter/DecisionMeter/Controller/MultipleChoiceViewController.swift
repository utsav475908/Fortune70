//
//  MultipleChoiceViewController.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 31/08/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

//defaults.set(arrayElementsGot["questionString"]!, forKey: "quest")
//defaults.set(arrayElementsGot["questionId"]!, forKey: "questionId")
//defaults.set(arrayElementsGot["questionType"], forKey: "questionType")
//defaults.synchronize()
////            guard arrayElementsGot["questionType"] as! String != "SINGLE_OPTION", arrayElementsGot["questionType"] as! String != "MULTIPLE_CHOICE"
////                else { return }
//if  arrayElementsGot["questionType"] as! String == "SINGLE_OPTION" {
//    defaults.set(arrayElementsGot["options"], forKey: "options")
//}


import UIKit

class MultipleChoiceViewController: UIViewController {
    

    
    var submitCounter : Int = 0
    //@IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var multipleQuestionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var questionLabel: UILabel!
    // MARK: VDL
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults.standard
        //self.questionLabel.text = "questiona are ae lsdjfsjlkfjl kjlfsdlfj lsjflsj questiona are ae lsdjfsjlkfjl kjlfsdlfj lsjflsj questiona are ae lsdjfsjlkfjl kjlfsdlfj lsjflsj questiona are  "
        self.questionLabel.text = defaults.value(forKey: "quest") as? String
        let heightofLabel = heightForView(text: self.questionLabel.text!, width: self.questionLabel.frame.width)
        multipleQuestionViewHeightConstraint.constant = heightofLabel + 280
        
        self.submitButton.alpha = 0
        giveTheNameToRespectiveLabels()
        //showSubmitButton()
    }
    
    func giveTheNameToRespectiveLabels() {
        let defaults = UserDefaults.standard
       // let sayTitleLabel = ["1":"something", "2": "sone" , "3": "sometihf" , "4":"sfsfsff"]
        let sayTitleLabel = defaults.value(forKey: "options") as! Dictionary<String,String>
        for (key, value) in sayTitleLabel.enumerated(){
            print("Item \(key): \(value)")
        }
        

        
        choiceA.setTitle(sayTitleLabel["1"], for: .normal)
        choiceB.setTitle(sayTitleLabel["2"], for: .normal)
        choiceC.setTitle(sayTitleLabel["3"], for: .normal)
        choiceD.setTitle(sayTitleLabel["4"], for: .normal)
    }
    
    //@IBOutlet weak var questionLabel: UILabel!
    
    func showSubmitButton() {
        for case let button as ISRadioButton in self.view.subviews {
            if button.isSelected == true{
                self.submitButton.alpha = 1
               print("isRadiobutton detected")
            }
            
        }
    }

    @IBOutlet weak var choiceA: ISRadioButton!
    @IBOutlet weak var choiceB: ISRadioButton!
    @IBOutlet weak var choiceC: ISRadioButton!
    @IBOutlet weak var choiceD: ISRadioButton!
    
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
    
    func saveItToSaveManager() {
        SaveManager.sharedInstance().saveChoiceForMultipleChoice(multipleChoiceArray: createTheListOfSelectedButtonNames())
    }
    
    
    @IBAction func onSubmitButtonPressed(_ sender: UIButton) {
        saveItToSaveManager()
        Http.submitAction() 
        let thisStoryboard =     UIStoryboard(name: "Main", bundle: nil)
        let submittedVC =   thisStoryboard.instantiateViewController(withIdentifier: "submitted")
        present(submittedVC, animated: true, completion: nil)
    }
    
    func createTheListOfSelectedButtonNames() -> [String:String] {
        var list = [String:String]()
        
        if (choiceA.isSelected) {
            //list.append((choiceA.titleLabel?.text)!)
//            list.append ("1")
            list["1"] = (choiceA.titleLabel?.text)!
        }
        if (choiceB.isSelected) {
            //list.append((choiceB.titleLabel?.text)!)
//            list.append ("2")
            list["2"] = (choiceB.titleLabel?.text)!
        }
        if (choiceC.isSelected) {
            //list.append((choiceC.titleLabel?.text)!)
//            list.append ("3")
            list["3"] = (choiceC.titleLabel?.text)!

        }
        if (choiceD.isSelected) {
            //list.append((choiceD.titleLabel?.text)!)
//            list.append ("4")
            list["4"] = (choiceD.titleLabel?.text)!

        }
        
        return list
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
