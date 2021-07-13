//
//  ListNotificationsVM.swift
//  Interphone
//
//  Created by Thang Lai on 05/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

struct MockNotification {
    let name: String
}

class ListNotificationsVM: ViewModel {
    struct Input {
    }
    
    struct Output {
        let listNotifications: Driver<[MockNotification]>
    }
    
//    private let listNotification: BehaviorRelay<[SlideMenuItem]> = BehaviorRelay(value: [])
}

extension ListNotificationsVM: ViewModelType {
    func transform(input: ListNotificationsVM.Input) -> ListNotificationsVM.Output {
        var listNoti: [MockNotification] = []
        for i in 1..<20 {
            listNoti.append(MockNotification(name: "Mock Notification \(i)"))
        }
        let items: BehaviorRelay<[MockNotification]> = BehaviorRelay(value: listNoti)
        return Output(listNotifications: items.asDriver())
    }
    
    
}
