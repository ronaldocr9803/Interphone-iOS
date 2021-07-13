//
//  UILableEx.swift
//  Zaimane
//
//  Created by Nguyễn Hữu Tá on 10/16/20.
//  Copyright © 2020 WillGroup. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
    func defaultFont(font: UIFont = Fonts.Default(16)){
        self.font = font
    }

}

@IBDesignable
class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 0.0
    @IBInspectable var rightInset: CGFloat = 0.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
