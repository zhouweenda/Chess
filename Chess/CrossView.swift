//
//  CrossView.swift
//  Chess
//
//  Created by 周闻达 on 16/3/9.
//  Copyright © 2016年 周闻达. All rights reserved.
//

import UIKit

class CrossView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    let lineWidth: CGFloat = 8.0
    let height: CGFloat = 35.0
    var crossLayer:CrossLayer?
    
    func reset() {
        self.crossLayer?.removeFromSuperlayer()
        self.layer.removeAllAnimations()
    }
    
    func play(){
        self.crossLayer = CrossLayer(lineWidth: lineWidth, height: self.height)
        self.reset()
        self.crossLayer!.bounds = CGRect(x: 0, y: 0, width: self.height, height: self.height)
        self.crossLayer!.position = CGPoint(x: CGRectGetMidX(self.bounds), y: CGRectGetMidY(self.bounds))
        self.crossLayer!.contentsScale = UIScreen.mainScreen().scale
        self.layer.addSublayer(self.crossLayer!)
        
        self.crossLayer!.play()
    }

}
