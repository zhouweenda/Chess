//
//  CircleLayer.swift
//  Chess
//
//  Created by 周闻达 on 16/3/8.
//  Copyright © 2016年 周闻达. All rights reserved.
//

import UIKit

class CircleLayer: CALayer {
    var progress: CGFloat = 1.0
    var lineWidth: CGFloat = 6.0
    
    override init(layer: Any) {
        super.init(layer: layer)
        
        let circleLayer = layer as! CircleLayer
        self.progress = circleLayer.progress
        self.lineWidth = circleLayer.lineWidth
    }
    
    override init(){
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override class func needsDisplay(forKey key: String) -> Bool {
        switch key{
        case "progress":
            return true
        default:
            break
        }
        
        return super.needsDisplay(forKey: key)
    }

    override func draw(in ctx: CGContext) {
        
        let path = UIBezierPath()
        
        let radius = min(bounds.width, bounds.height) / 2 - lineWidth / 2
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        let originStart = M_PI * 7 / 2
        let originEnd = M_PI * 2
        let currentOrigin = originStart - (originStart - originEnd) * Double(progress)
        
        let destStart = M_PI * 3
        let destEnd = 0.0
        let currentDest = destStart - (destStart - destEnd) * Double(progress)
        
        path.addArc(withCenter: center, radius: radius, startAngle: CGFloat(currentOrigin), endAngle: CGFloat(currentDest), clockwise: false)
        
        ctx.addPath(path.cgPath)
        ctx.setLineWidth(lineWidth)
        ctx.setStrokeColor(UIColor(red:0.2, green:0.66, blue:0.33, alpha:1).cgColor)
        ctx.strokePath()
    }
    
    
    
}
