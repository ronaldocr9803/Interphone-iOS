//
//  UIView.swift
//  Ramen
//
//  Created by Duc Do on 2/24/20.
//  Copyright © 2020 goodcreate. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addBorder(radius: CGFloat = 4.0, lineWidth: CGFloat = 1.0, color: UIColor = Color.gray) {
        layer.borderWidth = lineWidth
        layer.borderColor = color.cgColor
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func addCorner(color: UIColor = Color.clear, borderWidth: CGFloat = 1.0) {
        layer.borderWidth = borderWidth
        layer.borderColor = color.cgColor
        layer.cornerRadius = self.frame.size.height / 2
        layer.masksToBounds = true
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        clipsToBounds = true
    }
    
    
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable var borderColor: UIColor? {
           get {
               guard let borderColor = layer.borderColor else {
                   return nil
               }
               return UIColor(cgColor: borderColor)
           }
           set(value) {
               layer.borderColor = value?.cgColor
           }
       }
    
    @IBInspectable var borderWidth: CGFloat {
          get {
              return layer.borderWidth
          }
          set(value) {
              layer.borderWidth = value
          }
      }
    
    func defaultHeight(height: CGFloat = Constants.defaultHeight){
          self.heightAnchor.constraint(equalToConstant: height).isActive = true
     }

}



extension UIView {
    @discardableResult
    func loadNib<T : UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {    // 3
            return nil
        }
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        return contentView
    }
    
}
extension UIView {
    func setOnClickListener(action : @escaping (UITapGestureRecognizer)-> Void ){
        let tap = MyTapGestureRecognizer(target: self , action: #selector(self.handleTap(_:)))
        tap.action = action
        tap.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
        
    }
    @objc func handleTap(_ sender: MyTapGestureRecognizer) {
        sender.action!(sender)
    }
}
class MyTapGestureRecognizer: UITapGestureRecognizer {
    var action : ((UITapGestureRecognizer)-> Void)? = nil
}
