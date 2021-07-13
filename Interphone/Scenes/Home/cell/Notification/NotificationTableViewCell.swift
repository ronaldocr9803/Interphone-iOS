//
//  NotificationTableViewCell.swift
//  ios-template-app
//
//  Created by Thang Lai on 03/07/2021.
//

import UIKit

class NotificationTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    func fillData(notification: MockNotification){
        title.text = notification.name

    }
    
    func fillData(deliveryBox: MockDeliveryBox) {
        
    }
    
}
