//
//  Loader.swift
//  TaskOfEProject
//
//  Created by Nrmeen Tomoum on 13/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//
import Foundation
import UIKit
import MBProgressHUD
import FCAlertView
class CAlert
{
    class func createAlert (title :String, subTitle: String,vc : UIViewController , buttons : [String] = [])
    {
        let alert = FCAlertView()
        alert.delegate = (vc as! FCAlertViewDelegate)
        //   alert.makeAlertTypeSuccess()
        alert.doneButtonTitleColor = UIColor.white
        alert.firstButtonTitleColor   = UIColor.black
        alert.doneButtonHighlightedBackgroundColor = UIColor.black
        alert.colorScheme = alert.flatGray
        alert.tintColor = UIColor.black
        alert.showAlert(withTitle: title, withSubtitle: subTitle, withCustomImage: nil, withDoneButtonTitle: "Cancel", andButtons:buttons)
    }
}
class loader: NSObject {
    
    func startIndecator(_ view:UIView)
    {
        
        let spinnerActivity = MBProgressHUD.showAdded(to: view, animated: true);
        spinnerActivity.contentColor = UIColor.blue
        spinnerActivity.backgroundColor = UIColor.clear
        spinnerActivity.isUserInteractionEnabled = false;
        view.isUserInteractionEnabled = false
    }
    func stopIndecator(_ view:UIView)
    {
        MBProgressHUD.hideAllHUDs(for: view, animated: true)
        view.isUserInteractionEnabled = true
    }
}
