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
    
    override init(layer: AnyObject) {
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
    
    override class func needsDisplayForKey(key: String) -> Bool {
        switch key{
        case "progress":
            return true
        default:
            break
        }
        
        return super.needsDisplayForKey(key)
    }

    override func drawInContext(ctx: CGContext) {
        
        let path = UIBezierPath()
        
        let radius = min(CGRectGetWidth(bounds), CGRectGetHeight(bounds)) / 2 - lineWidth / 2
        let center = CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMidY(bounds))
        
        let originStart = M_PI * 7 / 2
        let originEnd = M_PI * 2
        let currentOrigin = originStart - (originStart - originEnd) * Double(progress)
        
        let destStart = M_PI * 3
        let destEnd = 0.0
        let currentDest = destStart - (destStart - destEnd) * Double(progress)
        
        path.addArcWithCenter(center, radius: radius, startAngle: CGFloat(currentOrigin), endAngle: CGFloat(currentDest), clockwise: false)
        
        CGContextAddPath(ctx, path.CGPath)
        CGContextSetLineWidth(ctx, lineWidth)
        CGContextSetStrokeColorWithColor(ctx, UIColor(red:0.2, green:0.66, blue:0.33, alpha:1).CGColor)
        CGContextStrokePath(ctx)
    }
    
    
    
}
