//
//  ButtonExtension.swift
//  VisamaneIOS
//
//  Created by Nguyễn Hữu Tá on 9/7/20.
//  Copyright © 2020 Nguyễn Hữu Tá. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
extension UIButton{
    func text(title:String = "", for state: UIControl.State = .normal) {
        self.setTitle(title, for: state)
    }
    var click: RxCocoa.SharedSequence<DriverSharingStrategy, Void> {
        return self.rx.tap.asDriver().throttle(.seconds(1))
    }
    
}

protocol IBaseButton {
    var defaultBackgrounColor: UIColor { get }
    var textColor: UIColor { get }
}
class BaseButton: UIButton{
    
}

@IBDesignable
class PrimaryButton: UIButton{
    
    @IBInspectable var startEnable: Bool = false
    @IBInspectable var defaultBackgrounColor: UIColor = Color.primary  {
        didSet {
            self.backgroundColor = defaultBackgrounColor
        }
    }
    override open var isEnabled: Bool {
        didSet {
            if self.isEnabled {
                addBorder(radius: 14, lineWidth: 0, color: .clear)
                self.backgroundColor = defaultBackgrounColor
                self.setTitleColor(Color.white, for: .normal)
            }
            else {
                addBorder(radius: 8, lineWidth: 0, color: .clear)
                self.backgroundColor = Color.disable
                self.setTitleColor(Color.white, for: .disabled)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
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
    
    private func initView(){
        defaultHeight()
        isEnabled = startEnable
    }
}

@IBDesignable
class SecondButton: UIButton{
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
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
    
    private func initView(){
        defaultHeight()
        backgroundColor = Color.backgroundController
        addBorder(radius: 14, lineWidth: 2, color: Color.primary)
    }
}
