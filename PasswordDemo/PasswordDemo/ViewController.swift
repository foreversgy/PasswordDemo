//
//  ViewController.swift
//  PasswordDemo
//
//  Created by Shiguoyan on 2018/9/19.
//  Copyright © 2018年 演兽. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let password = PasswordView(frame: CGRect(x: 0, y: 0, width: 160, height: 40))
        password.center = self.view.center
        password.backgroundColor = UIColor.red
        self.view.backgroundColor = UIColor.orange
        self.view.addSubview(password)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

