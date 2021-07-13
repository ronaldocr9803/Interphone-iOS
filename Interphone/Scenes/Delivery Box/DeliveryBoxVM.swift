//
//  DeliveryBoxVM.swift
//  Interphone
//
//  Created by Thang Lai on 09/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

struct MockDeliveryBox {
    let name: String
}

class DeliveryBoxVM: ViewModel {
    struct Input {
    }
    
    struct Output {
        let listDeliveryBoxes: Driver<[MockDeliveryBox]>
    }
    
}

extension DeliveryBoxVM: ViewModelType {
    func transform(input: DeliveryBoxVM.Input) -> DeliveryBoxVM.Output {
        var listNoti: [MockDeliveryBox] = []
        for i in 1..<20 {
            listNoti.append(MockDeliveryBox(name: "Mock Delivery \(i)"))
        }
        let items: BehaviorRelay<[MockDeliveryBox]> = BehaviorRelay(value: listNoti)
        return Output(listDeliveryBoxes: items.asDriver())
    }
    
    
}
