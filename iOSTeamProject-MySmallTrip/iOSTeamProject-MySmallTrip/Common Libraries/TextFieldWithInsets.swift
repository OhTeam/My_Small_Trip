//
//  TextFieldWithInsets.swift
//  iOSTeamProject-MySmallTrip
//
//  Created by 최용석 on 2018. 4. 21..
//  Copyright © 2018년 ohteam. All rights reserved.
//

import UIKit

class TextFieldWithInsets: UITextField {
    public var textInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet { setNeedsDisplay() }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, textInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, textInsets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, textInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, textInsets))
    }
}
