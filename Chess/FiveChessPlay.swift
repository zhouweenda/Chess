//
//  FiveChessPlay.swift
//  Chess
//
//   Created by 周闻达 on 16/3/14.
//  Copyright © 2016年 周闻达. All rights reserved.
//

import Foundation
import UIKit

class FiveChessPlay: NSObject{
    
    private static var chessboard: UIView?
    static var chessViews = [[FiveChessView]]()
    static var whoPlay:Bool = true
    static var isOver = false
    static var steps = [CGPoint]()
    static var player1: UILabel?
    static var player2: UILabel?
    static var winBoard: UILabel?
    static var regret: UIButton?
    
    init(parentView: UIView){
        super.init()
        
        FiveChessPlay.chessboard = UIView()
        FiveChessPlay.chessboard!.frame = CGRect(x: 10, y: 100, width: 355, height: 355)
        
        FiveChessPlay.chessViews = [[FiveChessView]]()
        FiveChessPlay.whoPlay = true
        FiveChessPlay.isOver = false
        FiveChessPlay.steps = [CGPoint]()
        
        var x: CGFloat = 0, y: CGFloat = 0
        var myChessView: FiveChessView!
        var innerChessViews: [FiveChessView]!
        
        for chess_y in 0...18{
            x = 0
            innerChessViews = [FiveChessView]()
            for chess_x in 0...18{
                myChessView = FiveChessView(pos: CGPoint(x: x, y: y), chessPos: CGPoint(x: chess_x, y: chess_y))
                innerChessViews.append(myChessView)
                FiveChessPlay.chessboard!.addSubview(myChessView)
                x += (355.0/19.0)
            }
            y += (355.0/19.0)
            FiveChessPlay.chessViews.append(innerChessViews)
        }
        parentView.addSubview(FiveChessPlay.chessboard!)
        
        
        FiveChessPlay.winBoard = UILabel()
        FiveChessPlay.winBoard?.frame = CGRect(x: 50, y: 500, width: 200, height: 50)
        parentView.addSubview(FiveChessPlay.winBoard!)
        
        FiveChessPlay.player1 = UILabel()
        FiveChessPlay.player2 = UILabel()
        FiveChessPlay.player1?.frame = CGRect(x: 10, y: 50, width: 100, height: 40)
        FiveChessPlay.player1?.textColor = UIColor(red:0.2, green:0.66, blue:0.33, alpha:1)
        FiveChessPlay.player1?.text = "Player1"
        FiveChessPlay.player2?.frame = CGRect(x: 265, y: 50, width: 100, height: 40)
        FiveChessPlay.player2?.textColor = UIColor.grayColor()
        FiveChessPlay.player2?.text = "Player2"
        FiveChessPlay.player2?.textAlignment = NSTextAlignment.Right
        parentView.addSubview(FiveChessPlay.player1!)
        parentView.addSubview(FiveChessPlay.player2!)
        
        
        FiveChessPlay.regret = UIButton(type: UIButtonType.System)
        FiveChessPlay.regret!.setTitle("悔棋", forState: UIControlState.Normal)
        FiveChessPlay.regret!.frame = CGRect(x: 162, y: 550, width: 50, height: 50)
        FiveChessPlay.regret!.hidden = true
        parentView.addSubview(FiveChessPlay.regret!)
        
        FiveChessPlay.regret!.addTarget(self, action: "onRegretClick", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    dynamic func onRegretClick(){
        if FiveChessPlay.steps.count <= 0{
            return
        }
        let lastPos = FiveChessPlay.steps.popLast()
        let x = Int(lastPos!.x)
        let y = Int(lastPos!.y)
        FiveChessPlay.chessViews[y][x].oneChess!.removeFromSuperview()
        FiveChessPlay.chessViews[y][x].oneChess = nil
        FiveChessPlay.chessViews[y][x].val = nil
        
        if FiveChessPlay.whoPlay{
            FiveChessPlay.player1?.textColor = UIColor.grayColor()
            FiveChessPlay.player2?.textColor = UIColor(red:0.91, green:0.26, blue:0.21, alpha:1)
        } else {
            FiveChessPlay.player2?.textColor = UIColor.grayColor()
            FiveChessPlay.player1?.textColor = UIColor(red:0.2, green:0.66, blue:0.33, alpha:1)
        }
        
        FiveChessPlay.whoPlay = !FiveChessPlay.whoPlay
        FiveChessPlay.regret!.hidden = true
    }
    
    
    static func checkWin() -> Bool{
        var wins: Int = 1
        var initWin: Int?
        for chessPos in FiveChessPlay.steps{
            let x = Int(chessPos.x)
            let y = Int(chessPos.y)
            initWin = FiveChessPlay.chessViews[y][x].val
            wins = 1
            if self.checkRight(initWin, wins: &wins, x: x, y: y) {
                for i in 0...4{
                    FiveChessPlay.chessViews[y][x+i].oneChess?.backgroundColor = UIColor.redColor()
                }
                return true
            }
            wins = 1
            if self.checkDown(initWin, wins: &wins, x: x, y: y) {
                for i in 0...4{
                    FiveChessPlay.chessViews[y+i][x].oneChess?.backgroundColor = UIColor.redColor()
                }
                return true
            }
            wins = 1
            if self.checkRightBottom(initWin, wins: &wins, x: x, y: y) {
                for i in 0...4{
                    FiveChessPlay.chessViews[y+i][x+i].oneChess?.backgroundColor = UIColor.redColor()
                }
                return true
            }
            wins = 1
            if self.checkRightTop(initWin, wins: &wins, x: x, y: y) {
                for i in 0...4{
                    FiveChessPlay.chessViews[y-i][x+i].oneChess?.backgroundColor = UIColor.redColor()
                }
                return true
            }
        }
        
        //NSLog("*************")
        return false
    }
    
    private static func checkRightTop(initWin: Int?, inout wins: Int, x: Int, y: Int) -> Bool{
        if x + 1 > 18 || y - 1 < 0{
            return false
        }
        if FiveChessPlay.chessViews[y-1][x+1].val == nil{
            return false
        }
        if initWin == FiveChessPlay.chessViews[y-1][x+1].val{
            wins += 1
            //NSLog("right-top: \(wins)")
            if(wins == 5){
                return true
            }
            if self.checkRightTop(initWin, wins: &wins, x: x+1, y: y-1){
                return true
            }
        }
        return false
    }
    
    
    private static func checkRightBottom(initWin: Int?, inout wins: Int, x: Int, y: Int) -> Bool{
        if x + 1 > 18 || y + 1 > 18{
            return false
        }
        if FiveChessPlay.chessViews[y+1][x+1].val == nil{
            return false
        }
        if initWin == FiveChessPlay.chessViews[y+1][x+1].val{
            wins += 1
            //NSLog("right-bottom: \(wins)")
            if(wins == 5){
                return true
            }
            if self.checkRightBottom(initWin, wins: &wins, x: x+1, y: y+1){
                return true
            }
        }
        return false
    }
    
    private static func checkDown(initWin: Int?, inout wins: Int, x: Int, y: Int) -> Bool{
        if y + 1 > 18{
            return false
        }
        if FiveChessPlay.chessViews[y+1][x].val == nil{
            return false
        }
        if initWin == FiveChessPlay.chessViews[y+1][x].val{
            wins += 1
            //NSLog("down: \(wins)")
            if(wins == 5){
                return true
            }
            if self.checkDown(initWin, wins: &wins, x: x, y: y+1){
                return true
            }
        }
        return false
    }
    
    private static func checkRight(initWin: Int?, inout wins: Int, x: Int, y: Int) -> Bool{
        if x + 1 > 18 {
            return false
        }
        if FiveChessPlay.chessViews[y][x+1].val == nil{
            return false
        }
        if initWin == FiveChessPlay.chessViews[y][x+1].val{
            wins += 1
            //NSLog("right: \(wins)")
            if(wins == 5){
                return true
            }
            if self.checkRight(initWin, wins: &wins, x: x+1, y: y){
                return true
            }
        }
        return false
    }
    
}
