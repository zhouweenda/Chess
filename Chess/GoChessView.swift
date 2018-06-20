//
//  GoChessView.swift
//  Chess
//
//  Created by 周闻达 on 16/3/15.
//  Copyright © 2016年 周闻达. All rights reserved.
//

import UIKit

class GoChessView: UIView {

    fileprivate let chessLine1 = CALayer()
    fileprivate let chessLine2 = CALayer()
    fileprivate let wid: CGFloat = 355.0/19.0
    fileprivate let radius: CGFloat = 10.0
    fileprivate let starRadius: CGFloat = 3.0
    var oneChess: oneChessView?
    var starPoint: CALayer?
    var chessInfo: ChessInfo?
    
    class oneChessView: UIView {
        var color: UIColor?
        fileprivate let radius: CGFloat = 8.5
        fileprivate let centerWid: CGFloat = 10.0
        fileprivate let lineWid: CGFloat = 1.0
        
        init(frame: CGRect, color: UIColor){
            super.init(frame: frame)
            self.color = color
        }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        override func draw(_ rect: CGRect) {
            let ctx: CGContext =  UIGraphicsGetCurrentContext()!;
            let path = UIBezierPath()
            path.addArc(withCenter: CGPoint(x: self.centerWid, y: self.centerWid), radius: self.radius, startAngle: CGFloat(0), endAngle: CGFloat(2.0*M_PI), clockwise: false)
            
            ctx.addPath(path.cgPath)
            ctx.setFillColor(self.color!.cgColor)
            ctx.setStrokeColor(self.color!.cgColor)
            ctx.setLineWidth(self.lineWid)
            ctx.drawPath(using: CGPathDrawingMode.fillStroke)
        }
    }
    
    convenience init(pos: CGPoint, chessPos: CGPoint){
        self.init(pos: pos, chessPos: chessPos, showStarPoint: false)
    }
    
    init(pos: CGPoint, chessPos: CGPoint, showStarPoint: Bool){
        super.init(frame: CGRect(x: pos.x, y: pos.y, width: wid, height: wid))
        self.chessInfo = ChessInfo(pos: CGPoint(x: chessPos.x, y: chessPos.y))
        
        self.chessLine1.frame = CGRect(x: wid/2-1, y: 0, width: 2, height: wid)
        self.chessLine1.backgroundColor = UIColor.black.cgColor
        self.chessLine2.frame = CGRect(x: 0, y: wid/2-1, width: wid, height: 2)
        self.chessLine2.backgroundColor = UIColor.black.cgColor
        
        self.layer.addSublayer(self.chessLine1)
        self.layer.addSublayer(self.chessLine2)
        
        if showStarPoint{
            self.starPoint = CALayer()
            self.starPoint?.frame = CGRect(x: self.wid/2-self.starRadius, y: wid/2-self.starRadius, width: 2.0*self.starRadius, height: 2.0*self.starRadius)
            self.starPoint?.backgroundColor = UIColor.black.cgColor
            self.starPoint?.cornerRadius = self.starRadius
            self.layer.addSublayer(self.starPoint!)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if GoChessPlay.isOver{
            return
        }
        if self.chessInfo!.chessStatus != ChessStatus.nil{
            return
        }
        if GoChessPlay.whoPlay{
            self.oneChess = oneChessView(frame: CGRect(x: self.wid/2-self.radius, y: self.wid/2-self.radius, width: self.radius*2.0, height: self.radius*2.0), color: UIColor.black)
            self.chessInfo!.chessStatus = ChessStatus.black
            GoChessPlay.player1?.textColor = UIColor.gray
            GoChessPlay.player2?.textColor = UIColor(red:0.91, green:0.26, blue:0.21, alpha:1)
        } else {
            self.oneChess = oneChessView(frame: CGRect(x: self.wid/2-self.radius, y: self.wid/2-self.radius, width: self.radius*2.0, height: self.radius*2.0), color: UIColor.white)
            self.chessInfo!.chessStatus = ChessStatus.white
            GoChessPlay.player2?.textColor = UIColor.gray
            GoChessPlay.player1?.textColor = UIColor(red:0.2, green:0.66, blue:0.33, alpha:1)
        }
        self.oneChess!.backgroundColor = UIColor.clear
        self.addSubview(self.oneChess!)
        GoChessPlay.steps.append(self.chessInfo!)
        
        if !GoChessPlay.canPlay(self.chessInfo!){
            GoChessPlay.steps.popLast()
            return
        }
        
        GoChessPlay.whoPlay = !GoChessPlay.whoPlay
        
        GoChessPlay.checkEat()
    }
    
    
}
