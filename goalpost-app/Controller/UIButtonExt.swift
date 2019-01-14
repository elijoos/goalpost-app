//
//  UIButtonExt.swift
//  goalpost-app
//
//  Created by Eli Joos on 1/13/19.
//  Copyright © 2019 Eli Joos. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setSelectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.3017679751, green: 0.746871829, blue: 0.3396928906, alpha: 1)
    }
    
    func setDeselectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.6519300938, green: 0.8728946447, blue: 0.6689990759, alpha: 1)
    }
}
