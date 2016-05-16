//
//  ViewController.swift
//  Chess
//
//  Created by 周闻达 on 16/3/7.
//  Copyright © 2016年 周闻达. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var navigation = UINavigationController()
    var fiveChessController = UIViewController()
    
    @IBAction func goFiveChess(sender: AnyObject) {
        self.navigationController?.pushViewController(self.fiveChessController, animated: true)
    }
    
    @IBOutlet weak var myBtn: UIButton!
    @IBOutlet weak var sysBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myBtn.titleLabel?.font = UIFont(name: "iconfont", size: 30)
        self.myBtn.setTitle("\u{e605}", forState: UIControlState.Normal)
        self.myBtn.setTitleColor(UIColor(red:0.01, green:0.65, blue:0.54, alpha:1), forState: UIControlState.Normal)
        
        self.sysBtn.titleLabel?.font = UIFont(name: "iconfont", size: 30)
        self.sysBtn.setTitle("\u{e604}", forState: UIControlState.Normal)
        self.sysBtn.setTitleColor(UIColor(red:0.01, green:0.65, blue:0.54, alpha:1), forState: UIControlState.Normal)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

