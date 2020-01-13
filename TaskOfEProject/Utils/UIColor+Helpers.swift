//
//  UIColor+Helpers.swift
//  TaskOfEProject
//
//  Created by Nrmeen Tomoum on 13/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//

import UIKit

extension UIColor {
    class func weatherWhite() -> UIColor {
        return white.withAlphaComponent(0.8)
    }
    class func weatherSemiTransparent() -> UIColor {
        return white.withAlphaComponent(0.5)
    }
}
