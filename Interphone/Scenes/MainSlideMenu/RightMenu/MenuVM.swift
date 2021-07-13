//
//  MenuVM.swift
//  Interphone
//
//  Created by Thang Lai on 08/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

class MenuVM: ViewModel {
    struct Input {
    }
    
    struct Output {
        let menuItems: Driver<[SlideMenuItem]>
    }
    
    private let menuItems: BehaviorRelay<[SlideMenuItem]> = BehaviorRelay(value: [])
}

extension MenuVM: ViewModelType {
    func transform(input: MenuVM.Input) -> MenuVM.Output {
        let items: BehaviorRelay<[SlideMenuItem]> = BehaviorRelay(value: [
            .notifications,
            .chat,
            .intercom,
            .deliveryBox,
            .family,
            .myAccount,
            .settings
            ])
        return Output(menuItems: items.asDriver())
    }
    
    
}
