//
//  FiveChessView.swift
//  Chess
//
//  Created by 周闻达 on 16/3/14.
//  Copyright © 2016年 周闻达. All rights reserved.
//

import UIKit

class FiveChessView: UIView {
    private let chessLine1 = CALayer()
    private let chessLine2 = CALayer()
    private let wid: CGFloat = 355.0/19.0
    private let radius: CGFloat = 10.0
    var oneChess: FiveChess?
    var val: Int?
    var chessPos: CGPoint?
    
    
    class FiveChess: UIView {
        var color: UIColor?
        init(frame: CGRect, color: UIColor){
            super.init(frame: frame)
            self.color = color
        }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        override func drawRect(rect: CGRect) {
            let ctx: CGContextRef =  UIGraphicsGetCurrentContext()!;
            let path = UIBezierPath()
            path.addArcWithCenter(CGPoint(x: 10.0, y: 10.0), radius: 8.0, startAngle: CGFloat(0), endAngle: CGFloat(2.0*M_PI), clockwise: false)
            
            CGContextAddPath(ctx, path.CGPath)
            CGContextSetFillColorWithColor(ctx, self.color!.CGColor)
            CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor().CGColor)
            CGContextSetLineWidth(ctx, 1.0)
            CGContextDrawPath(ctx, CGPathDrawingMode.FillStroke)
        }
    }
    
    init(pos: CGPoint, chessPos: CGPoint){
        super.init(frame: CGRect(x: pos.x, y: pos.y, width: wid, height: wid))
        self.chessPos = chessPos
        
        self.chessLine1.frame = CGRect(x: wid/2-1, y: 0, width: 2, height: wid)
        self.chessLine1.backgroundColor = UIColor.brownColor().CGColor
        self.chessLine2.frame = CGRect(x: 0, y: wid/2-1, width: wid, height: 2)
        self.chessLine2.backgroundColor = UIColor.brownColor().CGColor
        
        self.layer.addSublayer(self.chessLine1)
        self.layer.addSublayer(self.chessLine2)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if FiveChessPlay.isOver{
            return
        }
        if self.val != nil{
            return
        }
        if FiveChessPlay.whoPlay{
            self.oneChess = FiveChess(frame: CGRect(x: self.wid/2-self.radius, y: self.wid/2-self.radius, width: self.radius*2.0, height: self.radius*2.0), color: UIColor.blackColor())
            self.val = 0
            FiveChessPlay.player1?.textColor = UIColor.grayColor()
            FiveChessPlay.player2?.textColor = UIColor(red:0.91, green:0.26, blue:0.21, alpha:1)
        } else {
            self.oneChess = FiveChess(frame: CGRect(x: self.wid/2-self.radius, y: self.wid/2-self.radius, width: self.radius*2.0, height: self.radius*2.0), color: UIColor.whiteColor())
            self.val = 1
            FiveChessPlay.player2?.textColor = UIColor.grayColor()
            FiveChessPlay.player1?.textColor = UIColor(red:0.2, green:0.66, blue:0.33, alpha:1)
        }
        self.oneChess!.backgroundColor = UIColor.clearColor()
        self.addSubview(self.oneChess!)
        FiveChessPlay.steps.append(self.chessPos!)
        
        if FiveChessPlay.checkWin(){
            FiveChessPlay.isOver = true
            
            if FiveChessPlay.whoPlay{
                FiveChessPlay.winBoard?.text = "Player1 WIN!"
                FiveChessPlay.winBoard!.textColor = UIColor(red:0.2, green:0.66, blue:0.33, alpha:1)
            } else {
                FiveChessPlay.winBoard?.text = "Player2 WIN!"
                FiveChessPlay.winBoard!.textColor = UIColor(red:0.91, green:0.26, blue:0.21, alpha:1)
            }
            FiveChessPlay.player1?.textColor = UIColor.grayColor()
            FiveChessPlay.player2?.textColor = UIColor.grayColor()
        }
        
        
        FiveChessPlay.regret!.hidden = false
        FiveChessPlay.whoPlay = !FiveChessPlay.whoPlay
    }
    
}
