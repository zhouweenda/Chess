//
//  ChessStep.swift
//  Chess
//
//  Created by 周闻达 on 16/3/16.
//  Copyright © 2016年 周闻达. All rights reserved.
//

import Foundation
import UIKit


enum ChessStatus{
    case black
    case white
    case `nil`
}

class ChessInfo {
    var pos: CGPoint?
    fileprivate var x: Int = -1
    fileprivate var y: Int = -1
    var chessStatus: ChessStatus?
    var left: ChessInfo?
    var right: ChessInfo?
    var top: ChessInfo?
    var bottom: ChessInfo?
    var isSide = false
    
    init(pos: CGPoint){
        self.pos = pos
        self.x = Int(pos.x)
        self.y = Int(pos.y)
        self.chessStatus = ChessStatus.nil
    }
    
    func initPosition(){
        if self.x == 0{
            self.left = nil
            self.isSide = true
        } else {
            self.left = GoChessPlay.chessViews[self.y][self.x-1].chessInfo!
        }
        if self.x == 18{
            self.right = nil
            self.isSide = true
        } else {
            self.right = GoChessPlay.chessViews[self.y][self.x+1].chessInfo!
        }
        if self.y == 0{
            self.top = nil
            self.isSide = true
        } else {
            self.top = GoChessPlay.chessViews[self.y-1][self.x].chessInfo!
        }
        if self.y == 18{
            self.bottom = nil
            self.isSide = true
        } else {
            self.bottom = GoChessPlay.chessViews[self.y+1][self.x].chessInfo!
        }
    
    }
    
    
    
}
