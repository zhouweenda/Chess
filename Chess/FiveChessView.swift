//
//  FiveChessView.swift
//  Chess
//
//  Created by 周闻达 on 16/3/14.
//  Copyright © 2016年 周闻达. All rights reserved.
//

import UIKit

class FiveChessView: UIView {
    fileprivate let chessLine1 = CALayer()
    fileprivate let chessLine2 = CALayer()
    fileprivate let wid: CGFloat = 355.0/19.0
    fileprivate let radius: CGFloat = 10.0
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
        override func draw(_ rect: CGRect) {
            let ctx: CGContext =  UIGraphicsGetCurrentContext()!;
            let path = UIBezierPath()
            path.addArc(withCenter: CGPoint(x: 10.0, y: 10.0), radius: 8.0, startAngle: CGFloat(0), endAngle: CGFloat(2.0*M_PI), clockwise: false)
            
            ctx.addPath(path.cgPath)
            ctx.setFillColor(self.color!.cgColor)
            ctx.setStrokeColor(UIColor.black.cgColor)
            ctx.setLineWidth(1.0)
            ctx.drawPath(using: CGPathDrawingMode.fillStroke)
        }
    }
    
    init(pos: CGPoint, chessPos: CGPoint){
        super.init(frame: CGRect(x: pos.x, y: pos.y, width: wid, height: wid))
        self.chessPos = chessPos
        
        self.chessLine1.frame = CGRect(x: wid/2-1, y: 0, width: 2, height: wid)
        self.chessLine1.backgroundColor = UIColor.brown.cgColor
        self.chessLine2.frame = CGRect(x: 0, y: wid/2-1, width: wid, height: 2)
        self.chessLine2.backgroundColor = UIColor.brown.cgColor
        
        self.layer.addSublayer(self.chessLine1)
        self.layer.addSublayer(self.chessLine2)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if FiveChessPlay.isOver{
            return
        }
        if self.val != nil{
            return
        }
        if FiveChessPlay.whoPlay{
            self.oneChess = FiveChess(frame: CGRect(x: self.wid/2-self.radius, y: self.wid/2-self.radius, width: self.radius*2.0, height: self.radius*2.0), color: UIColor.black)
            self.val = 0
            FiveChessPlay.player1?.textColor = UIColor.gray
            FiveChessPlay.player2?.textColor = UIColor(red:0.91, green:0.26, blue:0.21, alpha:1)
        } else {
            self.oneChess = FiveChess(frame: CGRect(x: self.wid/2-self.radius, y: self.wid/2-self.radius, width: self.radius*2.0, height: self.radius*2.0), color: UIColor.white)
            self.val = 1
            FiveChessPlay.player2?.textColor = UIColor.gray
            FiveChessPlay.player1?.textColor = UIColor(red:0.2, green:0.66, blue:0.33, alpha:1)
        }
        self.oneChess!.backgroundColor = UIColor.clear
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
            FiveChessPlay.player1?.textColor = UIColor.gray
            FiveChessPlay.player2?.textColor = UIColor.gray
        }
        
        
        FiveChessPlay.regret!.isHidden = false
        FiveChessPlay.whoPlay = !FiveChessPlay.whoPlay
    }
    
}
