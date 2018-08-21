//
//  DetailPhotoViewController.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 24..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit
import Alamofire

class DetailPhotoViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    var data: Data?
    
    var image: String? {
        willSet(imgUrl) {

            Alamofire
                .request(imgUrl!)
                .responseData { (response) in
                    
                    switch response.result {
                    case .success(let value):
                        
                        self.data = value
                        print(value)
                        print(self.data)
                        self.viewDidLoad()
                        
                    case .failure(let error):
                        print("\n---------- [ cityImage load fail ] -----------\n")
                        print(error.localizedDescription)
                    }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let image = image {
            imageView.image = UIImage(data: data!)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let data = data {
            imageView.image = UIImage(data: data)
        }
    
    }
}
