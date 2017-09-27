//
//  RatingViewController.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 31/08/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {
@IBOutlet weak var ratingQuestionViewHeightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        self.questionLabel.text = defaults.value(forKey: "quest") as? String
        //self.questionLabel.text = "seomthisdfjsfsjfljsklfsfjslkflksjf fjslfjld sfldklj d klsdk sdlj  ldsklj sdfsdf sdfs dfdssf sdfdsfsd sdfs dfs sdf sdf sdfs df ds slkflksjf fjslfjld sfldklj d klsdk sdlj  ldskl slkflksjf fjslfjld sfldklj d klsdk sdlj  ldskl slkflksjf fjslfjld sfldklj d klsdk sdlj  ldskl slkflksjf fjslfjld sfldklj d klsdk sdlj  ldskl"
        let height = heightForView(text: self.questionLabel.text!, width: self.questionLabel.frame.size.width)
        print(height)
        ratingQuestionViewHeightConstraint.constant = height + 220
      self.submitButton.alpha = 0
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var questionLabel: UILabel!
    
    //@IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var starRating: HCSStarRatingView!
    
    @IBAction func ratingChanged(_ sender: HCSStarRatingView) {
        UIView.animate(withDuration: 0.75, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: { 
            self.submitButton.alpha = 1
        }) { (completed) in
            self.submitButton.alpha = 1 
        }
    }
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
    
    @IBAction func onSubmitButtonPressed(_ sender: UIButton) {
        saveTheRatingsValue()
        Http.submitAction() 
    let thisStoryboard =     UIStoryboard(name: "Main", bundle: nil)
      let submittedVC =   thisStoryboard.instantiateViewController(withIdentifier: "submitted")
        present(submittedVC, animated: true, completion: nil)
    }
    
    func saveTheRatingsValue() {
        SaveManager.sharedInstance().saveRatings(ratingString:Int(starRating.value))
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
