//
//  GoChessPlay.swift
//  Chess
//
//  Created by 周闻达 on 16/3/15.
//  Copyright © 2016年 周闻达. All rights reserved.
//

import Foundation
import UIKit

class GoChessPlay: NSObject{
    
    fileprivate static var chessboard: UIView?
    static var chessViews = [[GoChessView]]()
    static var whoPlay:Bool = true
    static var isOver = false
    static var steps = [ChessInfo]()
    static var player1: UILabel?
    static var player2: UILabel?
    static var winBoard: UILabel?
    
    init(parentView: UIView){
        super.init()
        
        GoChessPlay.chessboard = UIView()
        GoChessPlay.chessboard!.frame = CGRect(x: 10, y: 100, width: 355, height: 355)
        GoChessPlay.chessboard!.backgroundColor = UIColor(red:0.91, green:0.7, blue:0.43, alpha:1)
        GoChessPlay.chessboard!.layer.cornerRadius = 6.0
        
        GoChessPlay.chessViews = [[GoChessView]]()
        GoChessPlay.whoPlay = true
        GoChessPlay.isOver = false
        GoChessPlay.steps = [ChessInfo]()
        
        var x: CGFloat = 0, y: CGFloat = 0
        var myChessView: GoChessView!
        var innerChessViews: [GoChessView]!
        
        for chess_y in 0...18{
            x = 0
            innerChessViews = [GoChessView]()
            for chess_x in 0...18{
                if chess_x == 3 && (chess_y == 3 || chess_y == 9 || chess_y == 15) || chess_x == 9 && (chess_y == 3 || chess_y == 9 || chess_y == 15) || chess_x == 15 && (chess_y == 3 || chess_y == 9 || chess_y == 15) {
                    myChessView = GoChessView(pos: CGPoint(x: x, y: y), chessPos: CGPoint(x: chess_x, y: chess_y), showStarPoint: true)
                } else {
                    myChessView = GoChessView(pos: CGPoint(x: x, y: y), chessPos: CGPoint(x: chess_x, y: chess_y))
                }
                innerChessViews.append(myChessView)
                GoChessPlay.chessboard!.addSubview(myChessView)
                x += (355.0/19.0)
            }
            y += (355.0/19.0)
            GoChessPlay.chessViews.append(innerChessViews)
        }
        parentView.addSubview(GoChessPlay.chessboard!)
        
        for chess_y in 0...18{
            for chess_x in 0...18{
                GoChessPlay.chessViews[chess_y][chess_x].chessInfo!.initPosition()
            }
        }
        
        
        GoChessPlay.winBoard = UILabel()
        GoChessPlay.winBoard?.frame = CGRect(x: 50, y: 500, width: 200, height: 50)
        parentView.addSubview(GoChessPlay.winBoard!)
        
        GoChessPlay.player1 = UILabel()
        GoChessPlay.player2 = UILabel()
        GoChessPlay.player1?.frame = CGRect(x: 10, y: 50, width: 100, height: 40)
        GoChessPlay.player1?.textColor = UIColor(red:0.2, green:0.66, blue:0.33, alpha:1)
        GoChessPlay.player1?.text = "Player1"
        GoChessPlay.player2?.frame = CGRect(x: 265, y: 50, width: 100, height: 40)
        GoChessPlay.player2?.textColor = UIColor.gray
        GoChessPlay.player2?.text = "Player2"
        GoChessPlay.player2?.textAlignment = NSTextAlignment.right
        parentView.addSubview(GoChessPlay.player1!)
        parentView.addSubview(GoChessPlay.player2!)
        
    }
    
    fileprivate static func findStepsByPos(_ pos: CGPoint) -> Int{
        var i = 0
        for stepInfo in GoChessPlay.steps{
            if stepInfo.pos!.x == pos.x && stepInfo.pos!.y == pos.y{
                return i
            }
            i += 1
        }
        return -1
    }
    
    fileprivate static func deleteChess(_ chessInfo: ChessInfo){
        let x = Int(chessInfo.pos!.x)
        let y = Int(chessInfo.pos!.y)
        GoChessPlay.chessViews[y][x].oneChess?.removeFromSuperview()
        GoChessPlay.chessViews[y][x].chessInfo?.chessStatus = ChessStatus.nil
    }
    
    static func canPlay(_ chessInfo: ChessInfo) -> Bool{
        let myVal = GoChessPlay.whoPlay ? ChessStatus.black : ChessStatus.white
        var isCheck = [Int](repeating: 0, count: GoChessPlay.steps.count)
        var flat = [ChessInfo]()
        
        let i = GoChessPlay.findStepsByPos(chessInfo.pos!)
        flat = [ChessInfo]()
        flat.append(chessInfo)
        isCheck[i] = 1
        checkFlat(chessInfo, flat: &flat, myVal: myVal, isCheck: &isCheck)
            
        var canEat = true
        for flatChessInfo in flat{
            if !self.isEat(flatChessInfo, myVal: myVal){
                canEat = false
                break
            }
        } 
        if canEat{
            for chessInfo in flat{
                GoChessPlay.deleteChess(chessInfo)
            }
        }
        
        let canPlay = canEat ? false : true
        
        return canPlay
    }
    
    static func checkEat(){
        
        //print("******************\(GoChessPlay.steps.count)")
        
        let myVal = GoChessPlay.whoPlay ? ChessStatus.black : ChessStatus.white
        var isCheck = [Int](repeating: 0, count: GoChessPlay.steps.count)
        var flat = [ChessInfo]()
        var i = -1
        //print("We will check \(myVal==ChessStatus.BLACK ? "black" : "white")")
        for chessInfo in GoChessPlay.steps{
            i += 1
            //print("check chess: \(Int(chessInfo.pos!.x)),\(Int(chessInfo.pos!.y)) \(chessInfo.chessStatus==ChessStatus.BLACK ? "black" : "white") isCheck:\(isCheck[i])")
            flat = [ChessInfo]()
            if isCheck[i] == 1{
                continue
            }
            if chessInfo.chessStatus != myVal{
                isCheck[i] = 1
                continue
            }
            flat.append(chessInfo)
            isCheck[i] = 1
            checkFlat(chessInfo, flat: &flat, myVal: myVal, isCheck: &isCheck)
            //print("\(i) @ \(flat.count)")
            
            var canEat = true
            for flatChessInfo in flat{
                if !self.isEat(flatChessInfo, myVal: myVal){
                    canEat = false
                    break
                }
            }
            
            if canEat{
                for chessInfo in flat{
                    GoChessPlay.deleteChess(chessInfo)
                }
            }
            
        }
        
    }
    
    fileprivate static func isEat(_ flatChessInfo: ChessInfo, myVal: ChessStatus) -> Bool{
        if flatChessInfo.left != nil && flatChessInfo.left!.chessStatus == ChessStatus.nil{
            return false
        }
        if flatChessInfo.top != nil && flatChessInfo.top!.chessStatus == ChessStatus.nil{
            return false
        }
        if flatChessInfo.right != nil && flatChessInfo.right!.chessStatus == ChessStatus.nil{
            return false
        }
        if flatChessInfo.bottom != nil && flatChessInfo.bottom!.chessStatus == ChessStatus.nil{
            return false
        } else {
            return true
        }
    }
    
    fileprivate static func checkFlat(_ chessInfo: ChessInfo, flat: inout [ChessInfo], myVal: ChessStatus, isCheck: inout [Int]){
        var posIndex = -1
        if chessInfo.left != nil && chessInfo.left!.chessStatus == myVal{
            posIndex = GoChessPlay.findStepsByPos(CGPoint(x: chessInfo.left!.pos!.x, y: chessInfo.left!.pos!.y))
            if isCheck[posIndex] == 0{
                flat.append(chessInfo.left!)
                isCheck[posIndex] = 1
                checkFlat(chessInfo.left!, flat: &flat, myVal: myVal, isCheck: &isCheck)
            }
        }
        if chessInfo.right != nil && chessInfo.right!.chessStatus == myVal{
            posIndex = GoChessPlay.findStepsByPos(CGPoint(x: chessInfo.right!.pos!.x, y: chessInfo.right!.pos!.y))
            if isCheck[posIndex] == 0{
                flat.append(chessInfo.right!)
                isCheck[posIndex] = 1
                checkFlat(chessInfo.right!, flat: &flat, myVal: myVal, isCheck: &isCheck)
            }
        }
        if chessInfo.top != nil && chessInfo.top!.chessStatus == myVal{
            posIndex = GoChessPlay.findStepsByPos(CGPoint(x: chessInfo.top!.pos!.x, y: chessInfo.top!.pos!.y))
            if isCheck[posIndex] == 0{
                flat.append(chessInfo.top!)
                isCheck[posIndex] = 1
                checkFlat(chessInfo.top!, flat: &flat, myVal: myVal, isCheck: &isCheck)
            }
        }
        if chessInfo.bottom != nil && chessInfo.bottom!.chessStatus == myVal{
            posIndex = GoChessPlay.findStepsByPos(CGPoint(x: chessInfo.bottom!.pos!.x, y: chessInfo.bottom!.pos!.y))
            if isCheck[posIndex] == 0{
                flat.append(chessInfo.bottom!)
                isCheck[posIndex] = 1
                checkFlat(chessInfo.bottom!, flat: &flat, myVal: myVal, isCheck: &isCheck)
            }
        }
        return
    }
    
    
}


