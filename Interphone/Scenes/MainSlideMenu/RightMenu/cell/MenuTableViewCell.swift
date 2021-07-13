//
//  MenuTableViewCell.swift
//  Interphone
//
//  Created by Thang Lai on 08/07/2021.
//

import UIKit

class MenuTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleMenu: UILabel!
    var menuItem: SlideMenuItem!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    func fillData(menu: SlideMenuItem){
        menuItem = menu
        icon.image = menu.getIcon()
        titleMenu.text = menu.getTitle()
    }
    
}
