//
//  SettingsVC.swift
//  Interphone
//
//  Created by Thang Lai on 07/07/2021.
//

import UIKit

class SettingsVC: ViewController<SettingsVM> {

    @IBOutlet weak var passCodeInfoView: AccountInfoView!
    @IBOutlet weak var passCodeLabel: UILabel!
    @IBOutlet weak var switchView: SwitchView!
    @IBOutlet weak var switchLabel: UILabel!
    
    override var titleScreen: String {
        return "設定"
    }
    override func hideBackButton() -> Bool {
        return true
    }
    
    override func makeUI() {
        self.passCodeInfoView.title.text = "パスワード"
        self.switchView.title.text = "通知"
        self.passCodeInfoView.title.text = "******"
        
        //change fonts and fontsize of 2 labels
        
    }
    

}
