//
//  TestViewController.swift
//  Chess
//
//  Created by 周闻达 on 16/3/8.
//  Copyright © 2016年 周闻达. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    var circleView: CircleView?
    var crossView: CrossView?
    
    @IBAction func close(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func start(sender: UIButton) {
        
        self.circleView = CircleView()
        self.circleView?.frame = CGRect(x: 100, y: 100, width: 0, height: 0)
        self.view.addSubview(self.circleView!)
        self.circleView!.play()
        
        
        self.crossView = CrossView()
        self.crossView?.frame = CGRect(x: 100,y: 300, width: 0, height: 0)
        self.view.addSubview(self.crossView!)
        self.crossView!.play()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
