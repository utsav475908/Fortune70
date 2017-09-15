//
//  SaveManager.swift
//  DecisionMeter
//
//  Created by Avishek Sinha on 15/09/17.
//  Copyright © 2017 Avishek Sinha. All rights reserved.
//


class SaveManager {
    
    
    // MARK: Singleton
    
    private static let instance = SaveManager()
    
    class func sharedInstance () -> SaveManager {
        return instance
    }
    
     let SaveManagerKeys:String = "SaveManagerKeys"
    
    // MARK: Utility file for saving Slider and ratings
    
    //savers for slider and rating
    func saveSlider(sliderString:Int) {
        standard().set(sliderString, forKey: "Slider")
        sync()
    }
    
    func saveRatings(ratingString:Int) {
        standard().set(ratingString, forKey: "Rating")
        sync()
    }
    // getters for sliders and ratings
    func getSlider() -> Int {
      return   standard().value(forKey: "Slider") as! Int!
    }
    
    func getRatings() ->Int {
      return   standard().value(forKey: "Rating") as! Int!
    }
    
     // MARK: Utility file for saving SingleChoice Questions and Multiple Choice Questions
    // savers for single choice and multiple choice
    func saveChoiceForSingleChoice(choiceStringText:String) {
        standard().set(choiceStringText, forKey:"SingleChoice")
    }
    
    func saveChoiceForMultipleChoice(multipleChoiceArray:[String: String]) {
        standard().set(multipleChoiceArray, forKey:"MultipleChoice")
    }
    // getters for single choice and multiple choice
    func getChoiceForSingleChoice() -> String {
        return standard().value(forKey: "SingleChoice") as! String
    }
    
    func getChoiceForMultipleChoice() -> [String : String] {
        print(standard().value(forKey: "MultipleChoice") as! [String:String])
        print(standard().object(forKey: "MultipleChoice") as! [String:String])
        return standard().value(forKey: "MultipleChoice") as! [String:String]
    }
    
    
    // MARK: Helpers
    
    func standard () -> UserDefaults {
        return UserDefaults.standard
    }
    
    func sync () {
        standard().synchronize()
    }
}
