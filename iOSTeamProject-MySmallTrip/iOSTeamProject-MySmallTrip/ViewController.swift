//
//  ViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 10..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit
import Alamofire
import FBSDKLoginKit
import FBSDKCoreKit

class ViewController: UIViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


//}

    // 삭제할 부분
    
    var btn: UIButton!
    override func viewDidLoad() {
        
        btn = UIButton()
        btn.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
        btn.backgroundColor = UIColor.Custom.mainColor
        btn.setTitle("test", for: .normal)
        btn.addTarget(self, action: #selector(btnTarget(_:)), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    @objc func btnTarget(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Root", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "RootViewController") as! RootViewController
        self.present(nextVC, animated: false, completion: nil)
    }

}
