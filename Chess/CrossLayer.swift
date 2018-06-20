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
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.lineHeight, y: 0))
        path.apply(CGAffineTransform(rotationAngle: CGFloat(1.0/4.0*M_PI)))
        self.lineOne!.lineWidth = self.lineWidth
        self.lineOne!.strokeEnd = 1.0
        self.lineOne!.path = path.cgPath
        self.lineOne!.strokeColor = UIColor(red:0.91, green:0.26, blue:0.21, alpha:1).cgColor
        self.lineOne!.fillColor = nil
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1.0
        animation.duration = 0.5
        
        self.lineOne!.add(animation, forKey: nil)
        
        
        
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: self.lineHeight, y: 0))
        path2.addLine(to: CGPoint(x: 0, y: 0))
        path2.apply(CGAffineTransform(rotationAngle: CGFloat(3.0/4.0*M_PI)))
        self.lineTwo!.lineWidth = self.lineWidth
        self.lineTwo!.strokeEnd = 1.0
        self.lineTwo!.path = path2.cgPath
        self.lineTwo!.strokeColor = UIColor(red:0.91, green:0.26, blue:0.21, alpha:1).cgColor
        self.lineTwo!.fillColor = nil
        
        let animation2 = CABasicAnimation(keyPath: "strokeEnd")
        animation2.fromValue = 0
        animation2.toValue = 1.0
        animation2.duration = 0.5
        
        self.lineTwo!.add(animation2, forKey: nil)
        
    }
    
    
}
