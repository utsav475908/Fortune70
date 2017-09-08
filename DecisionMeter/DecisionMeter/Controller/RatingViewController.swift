//
//  RatingViewController.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 31/08/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      self.submitButton.alpha = 0
        // Do any additional setup after loading the view.
    }

   
    @IBOutlet weak var starRating: HCSStarRatingView!
    
    @IBAction func ratingChanged(_ sender: HCSStarRatingView) {
        UIView.animate(withDuration: 1.5, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: { 
            self.submitButton.alpha = 1
        }) { (completed) in
            self.submitButton.alpha = 1 
        }
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
