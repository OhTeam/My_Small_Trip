//
//  PopularCityTableViewCell.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 11..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit
import Alamofire

class PopularCityTableViewCell: UITableViewCell {

    @IBOutlet private weak var cityImageView: UIImageView!
    @IBOutlet private weak var cityNameLabel: UILabel!
    
    var cityInfo: PopularCity? {
        didSet {
            cityNameLabel.text = cityInfo?.name.capitalized
        
            let cityImageUrl = URL(string: (cityInfo?.cityImage)!)

            Alamofire
                .request(cityImageUrl!)
                .responseData { (response) in
                    
                    switch response.result {
                    case .success(let value):
                        
                        self.cityImageView.contentMode = .scaleAspectFill
                        self.cityImageView.clipsToBounds = true
                        self.cityImageView.layer.cornerRadius = 8
                        self.cityImageView.image = UIImage(data: value)
                        
                    case .failure(let error):
                        print("\n---------- [ cityImage load fail ] -----------\n")
                        print(error.localizedDescription)
                    }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
