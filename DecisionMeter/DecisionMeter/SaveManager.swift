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
        standard().set(sliderString, forKey: Q.kSlider)
        sync()
    }
    
    func saveRatings(ratingString:Int) {
        standard().set(ratingString, forKey: Q.kRating)
        sync()
    }
    // getters for sliders and ratings
    func getSlider() -> Int {
      return   standard().value(forKey:Q.kSlider) as! Int!
    }
    
    func getRatings() ->Int {
        print(standard().value(forKey: Q.kRating) as! Int!)
      return   standard().value(forKey: Q.kRating) as! Int!
    }
    
     // MARK: Utility file for saving SingleChoice Questions and Multiple Choice Questions
    // savers for single choice and multiple choice
    func saveChoiceForSingleChoice(choiceStringText:[String : String]) {
        standard().set(choiceStringText, forKey:Q.kSingleChoice)
    }
    
    func saveChoiceForMultipleChoice(multipleChoiceArray:[String: String]) {
        standard().set(multipleChoiceArray, forKey:Q.kMultipleChoice)
    }
    // getters for single choice and multiple choice
    func getChoiceForSingleChoice() -> [String : String] {
        return standard().value(forKey: Q.kSingleChoice) as! [String : String]
    }
    
    
    
    func getChoiceForMultipleChoice() -> [String : String] {
        print(standard().value(forKey: Q.kMultipleChoice) as! [String:String])
        print(standard().object(forKey: Q.kMultipleChoice) as! [String:String])
        return standard().value(forKey: Q.kMultipleChoice) as! [String:String]
    }
    
    
    // MARK: Helpers
    
    func standard () -> UserDefaults {
        return UserDefaults.standard
    }
    
    func sync () {
        standard().synchronize()
    }
    
    struct Q {
        static let kMultipleChoice = "MultipleChoice"
        static let kSingleChoice = "SingleChoice"
        static let kRating = "Rating"
        static let kSlider = "Slider"
    }
}
