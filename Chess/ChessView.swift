//
//  ChessView.swift
//  Chess
//
//  Created by 周闻达 on 16/3/7.
//  Copyright © 2016年 周闻达. All rights reserved.
//

import UIKit

class ChessView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var chessPos: CGPoint!
    var blockView: UILabel!
    //var showText: String!
    var val: Int?
    var circleView: CircleView?
    var crossView: CrossView?
    
    init(pos: CGPoint, chessPos: CGPoint){
        self.chessPos = chessPos
        
        self.blockView = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.blockView.backgroundColor = UIColor.clearColor()
        //self.blockView.layer.borderWidth = 1
        //self.blockView.layer.borderColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0).CGColor
        //self.blockView.font = UIFont(name: "iconfont", size: 50)
        self.blockView.textAlignment = NSTextAlignment.Center
        
        super.init(frame: CGRect(x: pos.x, y: pos.y, width: 100, height: 100))
        self.addSubview(self.blockView)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if ChessPlay.isOver{
            return
        }
        if self.val != nil {
            return
        }
        if ChessPlay.whoPlay{
            //self.showText = "\u{e600}"
            //self.blockView.textColor = UIColor(red:0.2, green:0.66, blue:0.33, alpha:1)
            
            self.circleView = CircleView()
            self.circleView!.frame = CGRect(x: 50, y: 50, width: 0, height: 0)
            self.addSubview(self.circleView!)
            
            self.val = 0
            ChessPlay.player1?.textColor = UIColor.grayColor()
            ChessPlay.player2?.textColor = UIColor(red:0.91, green:0.26, blue:0.21, alpha:1)
            
            self.circleView!.play()
        } else {
            //self.showText = "\u{e601}"
            //self.blockView.textColor = UIColor(red:0.91, green:0.26, blue:0.21, alpha:1)
            
            self.crossView = CrossView()
            self.crossView!.frame = CGRect(x: 50, y: 50, width: 0, height: 0)
            self.addSubview(self.crossView!)
            
            self.val = 1
            ChessPlay.player2?.textColor = UIColor.grayColor()
            ChessPlay.player1?.textColor = UIColor(red:0.2, green:0.66, blue:0.33, alpha:1)
            
            self.crossView!.play()
        }
        ChessPlay.steps.append(self.chessPos)
        //self.blockView.text = self.showText
        
        if ChessPlay.checkWin() {
            ChessPlay.isOver = true
            if ChessPlay.whoPlay{
                ChessPlay.winBoard?.text = "Player1 WIN!"
                ChessPlay.winBoard!.textColor = UIColor(red:0.2, green:0.66, blue:0.33, alpha:1)
                ChessPlay.huangGuan!.frame = CGRect(x: 10, y: 30, width: 60, height: 60)
                ChessPlay.huangGuan!.hidden = false
            } else {
                ChessPlay.winBoard?.text = "Player2 WIN!"
                ChessPlay.winBoard!.textColor = UIColor(red:0.91, green:0.26, blue:0.21, alpha:1)
                ChessPlay.huangGuan!.frame = CGRect(x: 250, y: 30, width: 60, height: 60)
                ChessPlay.huangGuan!.hidden = false
            }
            ChessPlay.replay!.hidden = false
            ChessPlay.restore!.hidden = false
            ChessPlay.player1?.textColor = UIColor.grayColor()
            ChessPlay.player2?.textColor = UIColor.grayColor()
            return
        }
        
        if ChessPlay.steps.count == 9{
            ChessPlay.isOver = true
            ChessPlay.winBoard?.textColor = UIColor(red:0.26, green:0.52, blue:0.96, alpha:1)
            ChessPlay.winBoard?.text = "Tie!"
            ChessPlay.replay!.hidden = false
            ChessPlay.restore!.hidden = false
            ChessPlay.player1?.textColor = UIColor.grayColor()
            ChessPlay.player2?.textColor = UIColor.grayColor()
            return
        }
        
        ChessPlay.whoPlay = !ChessPlay.whoPlay
    }
    

}




