//
//  CircleView.swift
//  Chess
//
//  Created by 周闻达 on 16/3/8.
//  Copyright © 2016年 周闻达. All rights reserved.
//

import UIKit

class CircleView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    let lineWidth: CGFloat = 6.0
    let radius: CGFloat = 20.0
    var circleLayer:CircleLayer?
    
    func reset() {
        self.circleLayer?.removeFromSuperlayer()
        self.layer.removeAllAnimations()
    }
    
    func play(){
        self.circleLayer = CircleLayer()
        self.reset()
        self.circleLayer!.bounds = CGRect(x: 0, y: 0, width: radius * 2 + lineWidth, height: radius * 2 + lineWidth)
        self.circleLayer!.position = CGPoint(x: CGRectGetMidX(self.bounds), y: CGRectGetMidY(self.bounds))
        self.circleLayer!.contentsScale = UIScreen.mainScreen().scale
        //self.circleLayer.color = UIColor.greenColor()
        self.circleLayer!.lineWidth = self.lineWidth
        self.layer.addSublayer(self.circleLayer!)
        
        // end status
        self.circleLayer!.progress = 1.0
        
        // animation
        let animation = CABasicAnimation(keyPath: "progress")
        animation.duration = 0.5
        animation.fromValue = NSNumber(double: 0.0)
        animation.toValue = NSNumber(double: 1.0)
        animation.delegate = self
        animation.setValue("circle", forKey: "circleName")
        self.circleLayer!.addAnimation(animation, forKey: nil)

    }
    
}
