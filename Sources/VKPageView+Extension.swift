

import UIKit
extension CAShapeLayer{
    convenience init(from startPoint:CGPoint , to endPoint:CGPoint,strokeColor: UIColor,fillColor:UIColor,lineWidth:CGFloat = 1) {
        self.init()
        let bezier = UIBezierPath.init()
        
        bezier.move(to: startPoint)
        
        bezier.addLine(to: endPoint)
        
        bezier.lineWidth = lineWidth
        
        self.path = bezier.cgPath
        
        self.lineWidth = lineWidth
        
        self.fillColor = fillColor.cgColor
        
        self.strokeColor = strokeColor.cgColor
    }
    
}
