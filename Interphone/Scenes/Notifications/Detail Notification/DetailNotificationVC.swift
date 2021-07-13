//
//  DetailNotificationVC.swift
//  Interphone
//
//  Created by Thang Lai on 05/07/2021.
//

import UIKit

class DetailNotificationVC: ViewController<DetailNotificationVM> {

    @IBOutlet weak var titleNoti: UILabel!
    
    override var titleScreen: String {
        return "お知らせ"
    }
    
    override func makeUI() {
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
    }


}
