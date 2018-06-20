//
//  FiveChessViewController.swift
//  Chess
//
//  Created by 周闻达 on 16/3/14.
//  Copyright © 2016年 周闻达. All rights reserved.
//

import UIKit

class FiveChessViewController: UIViewController {

    var chessPlay: FiveChessPlay?
    
    @IBAction func close(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chessPlay = FiveChessPlay(parentView: self.view)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
