//
//  ReachabilityManager.swift
//  Ramen
//
//  Detech if device is available connect to internet via WWAN or Cellular
//
//
//  Created by Duc Do on 2/24/20.
//  Copyright © 2020 goodcreate. All rights reserved.
//

import Foundation
import RxSwift
import Reachability

class ReachabilityManager {

    static let shared = ReachabilityManager()

    fileprivate let reachability: Reachability?

    let _reach = ReplaySubject<Bool>.create(bufferSize: 1)
    var reach: Observable<Bool> {
        return _reach.asObservable()
    }

    init() {
        
        reachability = try? Reachability.init()
        reachability?.whenReachable = { reachability in
            DispatchQueue.main.async {
                self._reach.onNext(true)
            }
        }

        reachability?.whenUnreachable = { reachability in
            DispatchQueue.main.async {
                self._reach.onNext(false)
            }
        }

        do {
            try reachability?.startNotifier()
            _reach.onNext(reachability?.connection != Reachability.Connection.unavailable)
        } catch {
            print("Unable to start notifier")
        }
    }
    func stopNotifier(){
        reachability?.stopNotifier()
    }
    
    
    func isConnection()-> Bool{
        return reachability?.connection != Reachability.Connection.unavailable
    }
}
