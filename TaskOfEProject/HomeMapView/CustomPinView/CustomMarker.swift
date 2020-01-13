//
//  CustomView.swift
//  TaskOfEProject
//
//  Created by Nrmeen Tomoum on 13/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//

import UIKit
protocol CustomMarkerDelegate {
    func showDetailsOfSelectedCity ()
}
class CustomMarker: UIView {
    var   delegate: CustomMarkerDelegate?
    var isexist = false
    @IBOutlet weak var showDetailsButton: UIButton!
    
    class func instancefromNib() -> UIView {
        return UINib.init(nibName: "CustomMarker", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
    }
    @IBAction func showDetailsOfCity(_ sender: Any) {
        delegate?.showDetailsOfSelectedCity()
    }
}
