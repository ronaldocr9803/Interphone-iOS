//
//  VisitorHistoryVC.swift
//  Interphone
//
//  Created by Thang Lai on 06/07/2021.
//

import UIKit

class VisitorHistoryVC: ViewController<VisitorHistoryVM> {

    @IBOutlet weak var historyVisitTableView: UITableView!
    override var titleScreen: String {
        return "来客履歴"
    }
    
    override func hideBackButton() -> Bool {
        return true
    }
    
    override func makeUI() {
        historyVisitTableView.register(cellType: VisitorHistoryCell.self)
        historyVisitTableView.delegate = self
        historyVisitTableView.dataSource = self

        
    }

}



extension VisitorHistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: VisitorHistoryCell.self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
