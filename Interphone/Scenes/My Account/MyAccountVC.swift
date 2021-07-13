//
//  MyAccountVC.swift
//  Interphone
//
//  Created by Thang Lai on 06/07/2021.
//

import UIKit

class MyAccountVC: ViewController<MyAccountVM> {

    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var accountNumber: UILabel!
    @IBOutlet weak var passCodeView: AccountInfoView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editAccountButton: UIView!
    
    override var titleScreen: String {
        return "マイアカウント"
    }
    
    override func hideBackButton() -> Bool {
        return true
    }
    
    override func localizationText() {
        accountName.text = "山田 太郎"
        //make font:
        //accountName.font =
        //accountNumber.font
        
        
    }
    
    override func makeUI() {
        
        
        self.passCodeView.title.text = "エントランス"
        self.passCodeView.info.text = "654321"
        self.passCodeView.info.textAlignment = .right
        
        self.editAccountButton.setOnClickListener { (_) in
        }
        
        tableView.register(cellType: AccountInfoCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        
//        tableView.separatorInset = .zero
//        tableView.layoutMargins = .zero
        
    }



}

extension MyAccountVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: AccountInfoCell.self)
        if indexPath.row == 0 {
            cell.configureCell(title: "携帯電話番号", info: "090-888-8888")
        } else {
            cell.configureCell(title: "メールアドレス", info: "yamada@gmail.com.vn")
        }
//        cell.makeFullWidthSeperator()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
}
