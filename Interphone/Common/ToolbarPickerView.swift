//
//  ToolbarPickerView.swift
//  VisamaneIOS
//
//  Created by Nguyễn Hữu Tá on 9/15/20.
//  Copyright © 2020 Nguyễn Hữu Tá. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
protocol ToolbarPickerViewDelegate: class{
    func didTapDone(pickerView: UIPickerView, rowSelected: Int)
}

class ToolbarPickerView: UIPickerView, UIPickerViewDelegate{

    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        toolbar.tintColor = .black
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([ spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        return toolbar
    }()
    private weak var toolbarDelegate: ToolbarPickerViewDelegate?
    private weak var textField: UITextField!
    private weak var triggerSelected: BehaviorRelay<Int>?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        
    }

    func applyWithTextFiled(_ textField: UITextField,_ selected: BehaviorRelay<Int>?){
        self.textField = textField
        self.triggerSelected = selected
        textField.inputView = self
        textField.inputAccessoryView = toolbar
    }
    
    @objc func doneTapped() {
        let row = self.selectedRow(inComponent: 0)
        self.textField.resignFirstResponder()
        self.triggerSelected?.accept(row)
        self.toolbarDelegate?.didTapDone(pickerView: self, rowSelected: row)
    }
}
