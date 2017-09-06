//
//  MultipleChoiceViewController.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 31/08/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import UIKit

class MultipleChoiceViewController: UIViewController {

    @IBOutlet weak var optionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        optionLabel.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    
    func mapLabelTagWithButtonTag() {
        
    }
    
    func tapFunction(sender:UITapGestureRecognizer) {
        print("tap working")
        UIView.animate(withDuration: 2, delay: 1, options:
            UIViewAnimationOptions.curveEaseInOut, animations: { 
                self.optionLabel.text = "this"
        }) { (completed) in
            self.optionLabel.text = "what" + "who are you"
        }
    }
    
    


    @IBOutlet weak var submit: UIButton!
    
    
    
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
