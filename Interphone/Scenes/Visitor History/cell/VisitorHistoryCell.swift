//
//  VisitorHistoryCell.swift
//  Interphone
//
//  Created by Thang Lai on 06/07/2021.
//

import UIKit

class VisitorHistoryCell: UITableViewCell, NibReusable {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var dateTimeVisit: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var status: UILabel!
    
    var additionalSeparator:UIView = UIView()

    override func awakeFromNib() {
        super.awakeFromNib()
        configCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configCell() {
        dateTimeVisit.text = "10/19 09:01"
        name.text = "山田 太郎"
        location.text = "玄関"
        status.text = "応答"
        avatar.loadImage(url: "https://picsum.photos/200/300")
        
    }
    
}
