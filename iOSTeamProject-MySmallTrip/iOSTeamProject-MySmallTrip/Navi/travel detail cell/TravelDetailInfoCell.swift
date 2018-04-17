//
//  TravelDetailInfoCell.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by sungnni on 2018. 4. 16..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit

class TravelDetailInfoCell: UITableViewCell {
    
    @IBOutlet weak var travelName: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var price: UILabel!
    
    var travel: TravelDetail? {
        willSet {
            guard let travel = newValue else { return }
            updateUI(travel: travel)
        }
    }
    
    func updateUI(travel: TravelDetail) {
        travelName.text = travel.name
        cityName.text = travel.city.name + ", " + travel.city.nationality
        self.price.text = "₩ " + String(travel.price)
    }
    
}
