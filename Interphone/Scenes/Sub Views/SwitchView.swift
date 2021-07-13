//
//  SwitchView.swift
//  Interphone
//
//  Created by Thang Lai on 07/07/2021.
//

import UIKit

class SwitchView: UIView {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var stateSwitch: UISwitch!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
        setupView()
    }
    
    private func setupView() {
    }
    
}
