//
//  Extension.swift
//  Demo
//
//  Created by karl  on 18/9/2020.
//  Copyright © 2020 karl. All rights reserved.
//

import UIKit

extension CAGradientLayer{
    convenience init( _ startPoint:CGPoint = CGPoint.init(x: 0, y: 0.5),_ endPoint:CGPoint =  CGPoint.init(x: 1, y: 0.5) ,startColor:UIColor,endColor:UIColor,size:CGSize){
        self.init()
        self.frame = CGRect.init(origin: CGPoint.zero, size: size)
        self.colors = [startColor.cgColor,endColor.cgColor]
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
}
extension UIColor{
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }

}
