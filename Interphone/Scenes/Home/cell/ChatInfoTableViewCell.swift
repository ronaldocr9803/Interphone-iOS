//
//  ChatInfoTableViewCell.swift
//  Interphone
//
//  Created by Thang Lai on 05/07/2021.
//

import UIKit

class ChatInfoTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func bindData(icon: UIImage, text: String) {
        self.numberLabel.text = text
        self.iconImageView.image = icon
        
    }
    
}
