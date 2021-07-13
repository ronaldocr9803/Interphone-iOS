//
//  MainVC.swift
//  ios-template-app
//
//  Created by OpenYourEyes on 05/01/2021.
//

import UIKit
import RxSwift
class MainVC: ViewController<MainVM> {

    
    override var titleScreen: String {
        return appString.app_name.toString
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let obserable = Observable<Int>.create { observer -> Disposable in
            print("Creating observable")
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1, execute: {
                observer.onNext(2)
            })
            return Disposables.create()
        }
        
        obserable.map { value -> Int in
            print("Multiplying by 2")
            return value * 2
        }
        let doubleSharedObservable = obserable.map { value -> Int in
            print("Multiplying by 2")
            return value * 2
        }
        doubleSharedObservable.subscribe { value in
            print("Subscription A")
        }
        
        doubleSharedObservable.subscribe { value in
            print("Subscription B")
        }
        
        
        
        let bh = BehaviorSubject.init(value: 3)
        bh.share().share().subscribe { (value) in
            print("A \(value)")
        }
        
        bh.share().share().subscribe { (value) in
            print("B \(value)")
        }


    }

}
