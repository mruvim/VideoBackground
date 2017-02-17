//
//  UIViewExtensions.swift
//  VideoBackground
//
//  Created by Ruvim Micsanschi on 2/16/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
