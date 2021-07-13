//
//  KafkaRefresh+Rx.swift
//  Ramen
//
//  Created by Duc Do on 2/20/20.
//  Copyright © 2020 goodcreate. All rights reserved.
//

import RxCocoa
import RxSwift
import KafkaRefresh

extension Reactive where Base: KafkaRefreshControl {

    public var isAnimating: Binder<Bool> {
        return Binder(self.base) { refreshControl, active in
            if active {
                refreshControl.beginRefreshing()
            } else {
                refreshControl.endRefreshing()
            }
        }
    }
}
