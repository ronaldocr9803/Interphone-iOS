//
//  AccountInfoView.swift
//  Interphone
//
//  Created by Thang Lai on 06/07/2021.
//

import UIKit

class AccountInfoView: UIView {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var info: UILabel!
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
        self.info.textAlignment = .right
    }
}
