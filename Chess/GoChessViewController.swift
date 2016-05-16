//
//  GoChessViewController.swift
//  Chess
//
//  Created by 周闻达 on 16/3/15.
//  Copyright © 2016年 周闻达. All rights reserved.
//

import UIKit

class GoChessViewController: UIViewController {
    
    var chessPlay: GoChessPlay?
    
    @IBAction func close(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chessPlay = GoChessPlay(parentView: self.view)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
