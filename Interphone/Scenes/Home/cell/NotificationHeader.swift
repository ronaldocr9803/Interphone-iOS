//
//  NotificationHeader.swift
//  ios-template-app
//
//  Created by Thang Lai on 03/07/2021.
//

import UIKit

class NotificationHeader: UIView {
    
    @IBOutlet weak var titleHeader: UILabel!
    @IBOutlet weak var seeDetailLabel: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadNib()
    }
    
    func bindData(title: String, image: UIImage) {
        self.titleHeader.text = title
        self.headerImageView.image = image
        
    }

}
