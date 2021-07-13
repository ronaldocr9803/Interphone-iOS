//
//  DeliveryBoxVC.swift
//  Interphone
//
//  Created by Thang Lai on 09/07/2021.
//

import UIKit

class DeliveryBoxVC: ViewController<DeliveryBoxVM> {

    @IBOutlet weak var boxTableView: UITableView!
    override var titleScreen: String {
        return "宅配BOX"
    }
    
    override func makeUI() {
        super.makeUI()
        boxTableView.register(cellType: NotificationTableViewCell.self)
        boxTableView.delegate = self
    }


    override func bindViewModel() {
        super.bindViewModel()
        let input = DeliveryBoxVM.Input()
        let output = viewModel.transform(input: input)
        output.listDeliveryBoxes.drive(boxTableView.rx.items){ (tableView, index, model) in
            let cell = tableView.dequeueReusableCell(for: IndexPath(item: index, section: 0), cellType: NotificationTableViewCell.self)
            cell.fillData(deliveryBox: model)
            return cell
        }.disposed(by: disposeBag)
        
        boxTableView.rx.modelSelected(MockDeliveryBox.self)
            .asDriver()
            .drive(onNext: { (deliveryBox) in
                self.navigator.show(segue: .deliveryBoxDetail(deliveryBox: deliveryBox), sender: self)
                
            }).disposed(by: disposeBag)
    }
}

extension DeliveryBoxVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
