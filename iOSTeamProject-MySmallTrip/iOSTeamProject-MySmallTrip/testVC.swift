//
//  testVC.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 17..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit

class testVC: UIViewController {

    
    @IBOutlet private weak var tokenLabel: UILabel!
    @IBOutlet private weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tokenLabel.text = FBUser.standards.token
        userNameLabel.text = FBUser.standards.userName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
