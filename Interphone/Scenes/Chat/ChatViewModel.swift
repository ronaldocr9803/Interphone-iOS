//
//  ChatViewModel.swift
//  Interphone
//
//  Created by Thang Lai on 12/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

struct MockChatData {
    let date: String
    let time: String
    let hasSeen: Bool
    let textMessage: String
    let sender: Bool //true if it is not you
}


class ChatViewModel: ViewModel {
    struct Input {
    }
    
    struct Output {
        let listNotifications: Driver<[MockChatData]>
    }
}

extension ChatViewModel: ViewModelType {
    func currentTime() -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        return "\(hour):\(minutes)"
    }
    
    func transform(input: ChatViewModel.Input) -> ChatViewModel.Output {
        var listNoti: [MockChatData] = []
        for i in 1..<20 {
            listNoti.append(
                MockChatData(
                    date: "Today",
                    time: currentTime(),
                    hasSeen: true,
                    textMessage: "some thing message \(i) some thing messagesome thing messagesome thing messagesome thing messagesome thing messagesome thing message",
                    sender: i % 3 == 0 ? true : false)
            )
        }
        let items: BehaviorRelay<[MockChatData]> = BehaviorRelay(value: listNoti)
        return Output(listNotifications: items.asDriver())
    }
    
    
}
