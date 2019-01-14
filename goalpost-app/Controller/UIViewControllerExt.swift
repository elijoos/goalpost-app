//
//  UIViewControllerExt.swift
//  goalpost-app
//
//  Created by Eli Joos on 1/13/19.
//  Copyright © 2019 Eli Joos. All rights reserved.
//

import UIKit


extension UIViewController {
    
    //override default animation when you present a view controller
    
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        //core animation
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        //present the view controller we passed in
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func dismissDetail() {
        //core animation
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
    
}
