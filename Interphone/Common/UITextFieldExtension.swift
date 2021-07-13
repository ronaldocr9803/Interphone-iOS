//
//  UITextFieldExtension.swift
//  VisamaneIOS
//
//  Created by Nguyễn Hữu Tá on 9/11/20.
//  Copyright © 2020 Nguyễn Hữu Tá. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
struct Constraints{
    let attr1 : NSLayoutConstraint.Attribute
    let relatedBy:  NSLayoutConstraint.Relation
    var toItem : Any?
    let attr2: NSLayoutConstraint.Attribute
    let multiplier: CGFloat = 1
    let constant : CGFloat
}

extension UIView{
    func makeConstraints(maker: ()-> [Constraints]){
        self.translatesAutoresizingMaskIntoConstraints = false
        let list = maker()
        list.forEach { (constraints) in
            NSLayoutConstraint(item: self, attribute: constraints.attr1, relatedBy: constraints.relatedBy,
                               toItem: constraints.toItem, attribute: constraints.attr2,
                               multiplier: constraints.multiplier, constant: constraints.constant).isActive = true
        }
    }
    
    
}
extension UITextField {
    func setIcon(_ image: UIImage) {
        let sizeRightView = CGSize(width: Constants.defaultHeight, height: Constants.defaultHeight)
        let sizeIcon = CGSize(width: 16, height: 14)
        
        
        let iconView = UIImageView(frame: CGRect(origin: .zero, size: sizeIcon))
        iconView.image = image
        iconView.tintColor = .black
        let containerView = UIView(frame: CGRect(origin: .zero, size: sizeRightView))
        containerView.addSubview(iconView)
        
        let haftValue = sizeRightView.width / 2
        iconView.center = CGPoint(x: haftValue, y: haftValue)
        
        rightView = containerView
        rightViewMode = .always
    }
    
    
    func maxLength(max: Int)-> Disposable{
        return self.rx.controlEvent(.editingChanged).subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if let text = self.text{
                let value = String(text.prefix(max))
                self.text = value
            }
        })
    }
    
}


@IBDesignable
class DropDownTextField: UITextField{
    
    //in code
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        
    }
    // in story board or xib
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    override func prepareForInterfaceBuilder() {
        initView()
    }
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: Constants.defaultHeight)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    private func initView(){
        addBorder(radius: 4.0, lineWidth: 1.0, color: Color.colorStroke)
        defaultHeight()
        setIcon(UIImage(named: "ic_drop_down")!)
    }
}
