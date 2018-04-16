//
//  TravelImageViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 15..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit

class TravelImageViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    var image: UIImage? {
        didSet {
            self.imageView?.image = image
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.image = image

    }

}
