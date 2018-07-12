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

    var wishListButton: WishListButton = WishListButton()
    
    @IBOutlet weak var travelImageView: UIImageView!
    
    @IBOutlet weak var travelName: UILabel!
    @IBOutlet weak var cityName: UILabel!

    @IBOutlet weak var price: UILabel!
    
    var productInfo: Travel? {
        didSet {
            travelName.text = productInfo!.name
            
            let cityName = productInfo!.city.name.capitalized
            let nationality = productInfo!.city.nationality.capitalized
            
            self.cityName.text = cityName.removePlusCharacter(of: cityName) + ", " + nationality.removePlusCharacter(of: nationality)
            
            if let price = productInfo?.price {
                let strPrice = String(price)
                self.price.text = strPrice.stringChangePrice(strPrice)
            }
            
            // wishList Check
            wishListButton.tag = productInfo!.pk
            wishListButton.checkWishList(wishListButton)
            
            // 핸드폰 사이즈에 따른 wishList button layout 재조정
            wishListBtnLayout()
            self.contentView.layoutIfNeeded()
            
            // add Image
            if let imageUrl = productInfo?.image {
            
                let productImageUrl = URL(string: (imageUrl))
                Alamofire
                    .request(productImageUrl!)
                    .responseData { (response) in
                        switch response.result {
                        case .success(let value):
                            self.travelImageView.contentMode = .scaleAspectFill
                            self.travelImageView.clipsToBounds = true
                            self.travelImageView.image = UIImage(data: value)
                            self.reloadInputViews()
                            
                        case .failure(let error):
                            print("\n---------- [ cityImage load fail ] -----------\n")
                            print(error.localizedDescription)
                        }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        wishListBtnLayout()
        self.contentView.addSubview(wishListButton)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
   
}


// MARK: - WishList Button
extension ProductListTableViewCell {
    
    func wishListBtnLayout() {
        
        let padding: CGFloat = 10
        let iconSize = WishListButton.standards.iconSize
        let x = self.contentView.frame.width - (padding + iconSize)

        wishListButton.frame = CGRect(x: x, y: padding, width: iconSize, height: iconSize)
    }
}
