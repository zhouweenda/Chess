//
//  CrossLayer.swift
//  Chess
//
//  Created by 周闻达 on 16/3/9.
//  Copyright © 2016年 周闻达. All rights reserved.
//

import UIKit

class CrossLayer: CALayer {
    
    var lineOne: CAShapeLayer?
    var lineTwo: CAShapeLayer?
    var height: CGFloat!
    var lineWidth: CGFloat!
    var lineHeight: CGFloat!
    
    init(lineWidth: CGFloat, height: CGFloat){
        super.init()
        self.lineWidth = lineWidth
        self.height = height
        self.lineHeight = sqrt(2*pow(self.height, 2))
        self.lineOne = CAShapeLayer()
        self.lineTwo = CAShapeLayer()
        self.lineOne!.position = CGPoint(x: 0, y: 0)
        self.lineTwo!.position = CGPoint(x: self.height, y: 0)
        self.addSublayer(self.lineOne!)
        self.addSublayer(self.lineTwo!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func play(){
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: self.lineHeight, y: 0))
        path.applyTransform(CGAffineTransformMakeRotation(CGFloat(1.0/4.0*M_PI)))
        self.lineOne!.lineWidth = self.lineWidth
        self.lineOne!.strokeEnd = 1.0
        self.lineOne!.path = path.CGPath
        self.lineOne!.strokeColor = UIColor(red:0.91, green:0.26, blue:0.21, alpha:1).CGColor
        self.lineOne!.fillColor = nil
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1.0
        animation.duration = 0.5
        
        self.lineOne!.addAnimation(animation, forKey: nil)
        
        
        
        let path2 = UIBezierPath()
        path2.moveToPoint(CGPoint(x: self.lineHeight, y: 0))
        path2.addLineToPoint(CGPoint(x: 0, y: 0))
        path2.applyTransform(CGAffineTransformMakeRotation(CGFloat(3.0/4.0*M_PI)))
        self.lineTwo!.lineWidth = self.lineWidth
        self.lineTwo!.strokeEnd = 1.0
        self.lineTwo!.path = path2.CGPath
        self.lineTwo!.strokeColor = UIColor(red:0.91, green:0.26, blue:0.21, alpha:1).CGColor
        self.lineTwo!.fillColor = nil
        
        let animation2 = CABasicAnimation(keyPath: "strokeEnd")
        animation2.fromValue = 0
        animation2.toValue = 1.0
        animation2.duration = 0.5
        
        self.lineTwo!.addAnimation(animation2, forKey: nil)
        
    }
    
    
}
