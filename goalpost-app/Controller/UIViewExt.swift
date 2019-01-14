//
//  UIViewExt.swift
//  goalpost-app
//
//  Created by Eli Joos on 1/13/19.
//  Copyright © 2019 Eli Joos. All rights reserved.
//

import UIKit

extension UIView {
    
    //THIS WILL ALLOW AN OBJECT SUCH AS NEXT BUTTON TO MOVE TO THE TOP OF THE KEYBOARD WHEN WE TAP THE TEXT BOX
    
    //add an observer for when the keyboard changes frame
    
    func bindToKeyboard() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    
    
    
    //animate the frame of whatever object we bind the keyboard with so it moves upward
    
    @objc func keyboardWillChange(_ notification: NSNotification) {
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let startingFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endingFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        //use starting frame and ending frame and subtract their y values so we know exactly how much difference it changes
        
        let deltaY = endingFrame.origin.y - startingFrame.origin.y
        
        //when we call bind to keyboard it will call all of this above then we will do this above
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions.init(rawValue: curve), animations: {
            self.frame.origin.y += deltaY
            //SO IN ALL THIS WE ARE RAISING THE OBJECT UP THE HEIGHT OF THE KEYBOARD!!! IN THIS CASE THE NEXT BUTTON WILL RAISE UP ABOVE THE KEYBOARD!!!
        }, completion: nil)
    }
    
    
}
