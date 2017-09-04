// *************************************************************************************************
// # MARK: Imports


import UIKit


// *************************************************************************************************
// # MARK: Extension Implementation


extension UIFont {
    
    
    // *********************************************************************************************
    // # MARK: Extension Type Methods
    
    
    public class func iDecisionTextFontWithSize(fontSize: CGFloat) -> UIFont! {
        guard let font = UIFont(name: "daimler", size: fontSize) else {
            let font = UIFont.systemFont(ofSize: fontSize)
            
            return font
        }
        
        return font
    }
    
    
    public class func iBPMApplicationTextThinFontWithSize(fontSize: CGFloat) -> UIFont! {
        guard let font = UIFont(name: "HelveticaNeue-thin", size: fontSize) else {
            let font = UIFont.systemFont(ofSize: fontSize)
            
            return font
        }
        
        return font
    }
    
    
    
    public class func iBPMApplicationTextMediumFontWithSize(fontSize: CGFloat) -> UIFont! {
        guard let font = UIFont(name: "HelveticaNeue-Medium", size: fontSize) else {
            let font = UIFont.systemFont(ofSize: fontSize)
            
            return font
        }
        
        return font
    }
    
    
    public class func iBPMApplicationTextBoldFontWithSize(fontSize: CGFloat) -> UIFont! {
        guard let font = UIFont(name: "HelveticaNeue-Bold", size: fontSize) else {
            let font = UIFont.systemFont(ofSize: fontSize)
            
            return font
        }
        
        return font
    }
    
    
}

