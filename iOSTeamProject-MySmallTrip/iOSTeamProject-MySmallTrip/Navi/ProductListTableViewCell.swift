//
//  ProductListTableViewCell.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 12..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit
import Alamofire

class ProductListTableViewCell: UITableViewCell {

    @IBOutlet weak var travelImageView: UIImageView!
    
    @IBOutlet weak var travelName: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var price: UILabel!
    
    var productInfo: Travel? {
        didSet {
            
            
            travelName.text = productInfo?.name
            cityName.text = (productInfo?.city.name)! + ", " + (productInfo?.city.nationality)!
            
            if let price = productInfo?.price {
                self.price.text = "₩ " + String(price)
            }
            
            
            let productImageUrl = URL(string: (productInfo?.images[0].productImg)!)
            Alamofire
                .request(productImageUrl!)
                .responseData { (response) in
                    switch response.result {
                    case .success(let value):
                        
                        self.travelImageView.contentMode = .scaleAspectFill
                        self.travelImageView.clipsToBounds = true
                        self.travelImageView.image = UIImage(data: value)
                        
                    case .failure(let error):
                        print("\n---------- [ cityImage load fail ] -----------\n")
                        print(error.localizedDescription)
                    }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
