//
//  DeliveryBoxDetailVC.swift
//  Interphone
//
//  Created by Thang Lai on 12/07/2021.
//

import UIKit

class DeliveryBoxDetailVC: ViewController<DeliveryBoxDetailVM> {

    @IBOutlet weak var backToListButton: UIView!
    override var titleScreen: String {
        return "宅配BOX"
    }
    
    override func makeUI() {
        self.backToListButton.setOnClickListener { (_) in
            self.navigator.pop(sender: self)
        }
    }


}
