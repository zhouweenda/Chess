//
//  ChessPlay.swift
//  Chess
//
//  Created by 周闻达 on 16/3/7.
//  Copyright © 2016年 周闻达. All rights reserved.
//

import Foundation
import UIKit

class ChessPlay: NSObject{
    private static var chessboard: UIView?
    private var chessLine1: CALayer?
    private var chessLine2: CALayer?
    private var chessLine3: CALayer?
    private var chessLine4: CALayer?
    static var chessViews = [[ChessView]]()
    static var whoPlay:Bool = true
    static var winBoard: UILabel?
    static var isOver = false
    static var player1: UILabel?
    static var player2: UILabel?
    static var steps = [CGPoint]()
    static var huangGuan: UILabel!
    static var replay: UIButton?
    static var restore: UIButton?
    
    init(parentView: UIView){
        super.init()
        
        ChessPlay.chessboard = UIView()
        ChessPlay.chessboard!.frame = CGRect(x: 35, y: 150, width: 300, height: 300)
        self.chessLine1 = CALayer()
        self.chessLine1!.frame = CGRect(x: 0, y: 100, width: 300, height: 2)
        self.chessLine1!.backgroundColor = UIColor.brownColor().CGColor
        ChessPlay.chessboard!.layer.addSublayer(self.chessLine1!)
        self.chessLine2 = CALayer()
        self.chessLine2!.frame = CGRect(x: 0, y: 200, width: 300, height: 2)
        self.chessLine2!.backgroundColor = UIColor.brownColor().CGColor
        ChessPlay.chessboard!.layer.addSublayer(self.chessLine2!)
        self.chessLine3 = CALayer()
        self.chessLine3!.frame = CGRect(x: 100, y: 0, width: 2, height: 300)
        self.chessLine3!.backgroundColor = UIColor.brownColor().CGColor
        ChessPlay.chessboard!.layer.addSublayer(self.chessLine3!)
        self.chessLine4 = CALayer()
        self.chessLine4!.frame = CGRect(x: 200, y: 0, width: 2, height: 300)
        self.chessLine4!.backgroundColor = UIColor.brownColor().CGColor
        ChessPlay.chessboard!.layer.addSublayer(self.chessLine4!)
        parentView.addSubview(ChessPlay.chessboard!)
        
        ChessPlay.chessViews = [[ChessView]]()
        ChessPlay.whoPlay = true
        ChessPlay.isOver = false
        ChessPlay.steps = [CGPoint]()
        
        var x:CGFloat = 0, y:CGFloat = 1
        var myChessView: ChessView!
        var innerChessViews: [ChessView]!
        
        for chess_y in 0...2{
            x = 1
            innerChessViews = [ChessView]()
            for chess_x in 0...2{
                myChessView = ChessView(pos: CGPoint(x: x, y: y), chessPos: CGPoint(x: chess_x, y: chess_y))
                innerChessViews.append(myChessView)
                ChessPlay.chessboard!.addSubview(myChessView)
                x += 100
            }
            ChessPlay.chessViews.append(innerChessViews)
            y += 100
        }
        
        ChessPlay.winBoard = UILabel()
        ChessPlay.winBoard?.frame = CGRect(x: 50, y: 500, width: 200, height: 50)
        parentView.addSubview(ChessPlay.winBoard!)
        
        ChessPlay.player1 = UILabel()
        ChessPlay.player2 = UILabel()
        ChessPlay.player1?.frame = CGRect(x: 35, y: 65, width: 100, height: 40)
        ChessPlay.player1?.textColor = UIColor(red:0.2, green:0.66, blue:0.33, alpha:1)
        ChessPlay.player1?.text = "Player1"
        ChessPlay.player2?.frame = CGRect(x: 235, y: 65, width: 100, height: 40)
        ChessPlay.player2?.textColor = UIColor.grayColor()
        ChessPlay.player2?.text = "Player2"
        ChessPlay.player2?.textAlignment = NSTextAlignment.Right
        parentView.addSubview(ChessPlay.player1!)
        parentView.addSubview(ChessPlay.player2!)
        
        
        ChessPlay.huangGuan = UILabel()
        //ChessPlay.huangGuan!.transform = CGAffineTransformMakeRotation(CGFloat(1.0/5.0*M_PI))
        ChessPlay.huangGuan!.font = UIFont(name: "iconfont", size: 40)
        ChessPlay.huangGuan!.text = "\u{e603}"
        ChessPlay.huangGuan!.textColor = UIColor(red:0.98, green:0.74, blue:0.02, alpha:1)
        ChessPlay.huangGuan!.hidden = true
        parentView.addSubview(ChessPlay.huangGuan!)
        
        ChessPlay.replay = UIButton(type: UIButtonType.System)
        ChessPlay.restore = UIButton(type: UIButtonType.System)
        ChessPlay.restore!.setTitle("复盘", forState: UIControlState.Normal)
        ChessPlay.restore!.frame = CGRect(x: 200, y: 500, width: 50, height: 50)
        ChessPlay.restore!.hidden = true
        parentView.addSubview(ChessPlay.restore!)
        ChessPlay.replay!.setTitle("重新开始", forState: UIControlState.Normal)
        ChessPlay.replay!.frame = CGRect(x: 260, y: 500, width: 100, height: 50)
        ChessPlay.replay!.hidden = true
        parentView.addSubview(ChessPlay.replay!)
        
        ChessPlay.replay!.addTarget(self, action: "onReplayClick", forControlEvents: UIControlEvents.TouchUpInside)
        ChessPlay.restore!.addTarget(self, action: "onRestoreClick", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    dynamic func onReplayClick(){
        ChessPlay.reInit()
    }
    
    dynamic func onRestoreClick(){
        ChessPlay.reInit()
    }
    
    
    static func reInit(){
        
        for chessView in ChessPlay.chessViews{
            for innerChessView in chessView{
                innerChessView.removeFromSuperview()
            }
        }
        ChessPlay.chessViews = [[ChessView]]()
        var x:CGFloat = 0, y:CGFloat = 1
        var myChessView: ChessView!
        var innerChessViews: [ChessView]!

        for chess_y in 0...2{
            x = 1
            innerChessViews = [ChessView]()
            for chess_x in 0...2{
                myChessView = ChessView(pos: CGPoint(x: x, y: y), chessPos: CGPoint(x: chess_x, y: chess_y))
                innerChessViews.append(myChessView)
                self.chessboard!.addSubview(myChessView)
                x += 100
            }
            ChessPlay.chessViews.append(innerChessViews)
            y += 100
        }
        
        ChessPlay.whoPlay = true
        ChessPlay.isOver = false
        ChessPlay.steps = [CGPoint]()
        
        ChessPlay.winBoard!.text = ""
        ChessPlay.player1?.textColor = UIColor(red:0.2, green:0.66, blue:0.33, alpha:1)
        ChessPlay.player2?.textColor = UIColor.grayColor()
        ChessPlay.replay!.hidden = true
        ChessPlay.restore!.hidden = true
        ChessPlay.huangGuan!.hidden = true
        
    }
    
    static func checkWin() -> Bool{
        var wins: Int = 1
        var initWin: Int?
        for y in 0...2{
            for x in 0...2{
                initWin = ChessPlay.chessViews[y][x].val
                wins = 1
                if self.checkRight(initWin, wins: &wins, x: x, y: y) {
                    return true
                }
                wins = 1
                if self.checkDown(initWin, wins: &wins, x: x, y: y) {
                    return true
                }
                wins = 1
                if self.checkRightBottom(initWin, wins: &wins, x: x, y: y) {
                    return true
                }
                wins = 1
                if self.checkRightTop(initWin, wins: &wins, x: x, y: y) {
                    return true
                }
            }
        }
        
        //NSLog("*************")
        return false
    }
    
    private static func checkRightTop(initWin: Int?, inout wins: Int, x: Int, y: Int) -> Bool{
        if x + 1 > 2 || y - 1 < 0{
            return false
        }
        if ChessPlay.chessViews[y-1][x+1].val == nil{
            return false
        }
        if initWin == ChessPlay.chessViews[y-1][x+1].val{
            wins += 1
            //NSLog("right-top: \(wins)")
            if(wins == 3){
                return true
            }
            if self.checkRightTop(initWin, wins: &wins, x: x+1, y: y-1){
                return true
            }
        }
        return false
    }

    
    private static func checkRightBottom(initWin: Int?, inout wins: Int, x: Int, y: Int) -> Bool{
        if x + 1 > 2 || y + 1 > 2{
            return false
        }
        if ChessPlay.chessViews[y+1][x+1].val == nil{
            return false
        }
        if initWin == ChessPlay.chessViews[y+1][x+1].val{
            wins += 1
            //NSLog("right-bottom: \(wins)")
            if(wins == 3){
                return true
            }
            if self.checkRightBottom(initWin, wins: &wins, x: x+1, y: y+1){
                return true
            }
        }
        return false
    }
    
    private static func checkDown(initWin: Int?, inout wins: Int, x: Int, y: Int) -> Bool{
        if y + 1 > 2{
            return false
        }
        if ChessPlay.chessViews[y+1][x].val == nil{
            return false
        }
        if initWin == ChessPlay.chessViews[y+1][x].val{
            wins += 1
            //NSLog("down: \(wins)")
            if(wins == 3){
                return true
            }
            if self.checkDown(initWin, wins: &wins, x: x, y: y+1){
                return true
            }
        }
        return false
    }
    
    private static func checkRight(initWin: Int?, inout wins: Int, x: Int, y: Int) -> Bool{
        if x + 1 > 2 {
            return false
        }
        if ChessPlay.chessViews[y][x+1].val == nil{
            return false
        }
        if initWin == ChessPlay.chessViews[y][x+1].val{
            wins += 1
            //NSLog("right: \(wins)")
            if(wins == 3){
                return true
            }
            if self.checkRight(initWin, wins: &wins, x: x+1, y: y){
                return true
            }
        }
        return false
    }
    
    
}

