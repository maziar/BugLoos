//
//  ViewExtenssions.swift
//  Edgecom
//
//  Created by Pelk on 6/11/21.
//  Copyright © 2021 Edgecom Energy. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func dismissKeyBoardInView(haveSubClass: Bool) {
        if self is UITextField {
            self.resignFirstResponder()
        } else if self is UITextView {
            self.resignFirstResponder()
        }
        
        if haveSubClass {
            for view in self.subviews {
                view.dismissKeyBoardInView(haveSubClass: true)
            }
        }
    }
    
    func setCurvedView(cornerRadius: CGFloat, borderWidth: CGFloat , borderColor: UIColor, masksToBounds: Bool) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = masksToBounds
    }
    
    func setCurvedView(cornerRadius: CGFloat , masksToBounds: Bool = true) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0
        self.layer.masksToBounds = masksToBounds
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
           let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
           let mask = CAShapeLayer()
           mask.path = path.cgPath
           layer.mask = mask
       }
    
    func addShadow(color: UIColor, radius: CGFloat? = nil, opacity: Float? = nil, offsetY: CGFloat? = nil) {
        self.layer.shadowColor = color.cgColor
        if let radius = radius {
            self.layer.shadowRadius = radius
        }
        if let opacity = opacity {
            self.layer.shadowOpacity = opacity
        }
        if let offsetY = offsetY {
            self.layer.shadowOffset.height = offsetY
        }
    }
    
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
}
