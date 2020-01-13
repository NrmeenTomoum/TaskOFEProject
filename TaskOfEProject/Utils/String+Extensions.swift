//
//  String+Extensions.swift
//  TaskOfEProject
//
//  Created by Nrmeen Tomoum on 13/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//
import UIKit

extension NSMutableAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.height
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.width
    }
    
    class func setupWithText(_ text: String, description: String, textFont: UIFont, descriptionFont: UIFont, textColor: UIColor, descriptionColor: UIColor) -> NSMutableAttributedString?{
        
        let textAttribute = [NSMutableAttributedString.Key.font: textFont, NSMutableAttributedString.Key.foregroundColor : textColor] as [NSAttributedString.Key  : Any]
        let descriptionAttribute = [NSMutableAttributedString.Key.font: descriptionFont, NSMutableAttributedString.Key.foregroundColor: descriptionColor]
        
        let attributedText = NSMutableAttributedString(string: text,
                                                       attributes: textAttribute)
        let descriptionAttributedString = NSMutableAttributedString(string: description,
                                                                attributes:  descriptionAttribute)
        attributedText.append(descriptionAttributedString)
        return attributedText
    }
}
