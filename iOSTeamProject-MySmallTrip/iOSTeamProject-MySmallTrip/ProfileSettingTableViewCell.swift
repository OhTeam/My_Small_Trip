//
//  ProfileSettingTableViewCell.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by 최용석 on 2018. 4. 18..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit

class ProfileSettingTableViewCell: UITableViewCell {
    
    private let leftContent: UILabel = UILabel()
    var leftText: String? {
        didSet {
            leftContent.text = leftText
        }
    }
    
    private let rightContent: UILabel = UILabel()
    var rightText: String? {
        didSet {
            rightContent.text = rightText
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        // Left Content
        let marginGuide: UILayoutGuide = self.contentView.layoutMarginsGuide

        self.leftContent.textAlignment = .left
        self.leftContent.font = UIFont.systemFont(ofSize: 16)
        self.leftContent.textColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1)
        self.leftContent.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(leftContent)

        // Left Content Layout
        self.leftContent.widthAnchor.constraint(equalTo: marginGuide.widthAnchor, multiplier: 0.3).isActive = true
        self.leftContent.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        self.leftContent.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        self.leftContent.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true

        // Right Content
        self.rightContent.textAlignment = .right
        self.rightContent.font = UIFont.systemFont(ofSize: 16)
        self.rightContent.textColor = UIColor(displayP3Red: 145/255, green: 146/255, blue: 158/255, alpha: 1)
        self.rightContent.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(rightContent)

        // Right Content Layout
        self.rightContent.widthAnchor.constraint(equalTo: marginGuide.widthAnchor, multiplier: 0.7).isActive = true
        self.rightContent.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        self.rightContent.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        self.rightContent.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
