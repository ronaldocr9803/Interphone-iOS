//
//  ViewModel.swift
//  Ramen
//
//  Created by Duc Do on 2/24/20.
//  Copyright © 2020 goodcreate. All rights reserved.
//

import Foundation
import RxSwift

class ViewModel {
    
    let loading = RxActivityIndicator()
    var dataManager: DataManager
    var disposeBag = DisposeBag()
    
    lazy var trackingError: PublishSubject<Error> = {
        return PublishSubject()
    }()
    lazy var navigatorSubject: PublishSubject<Navigator.Scene> = {
        return PublishSubject()
    }()
    
    
    init(provider: DataManager) {
        self.dataManager = provider
    }
    
    deinit {
        printLog(self, "Deinited")
    }
    
}
class ViewModelFactory{
    static func of<T: ViewModel>(type: T.Type, data: DataManager)->T{
        switch type {
        case is SplashVM.Type:
            return SplashVM(provider: data) as! T
        case is MainVM.Type:
            return MainVM(provider: data) as! T
        case is HomeViewModel.Type:
            return HomeViewModel(provider: data) as! T
        case is MyAccountVM.Type:
            return MyAccountVM(provider: data) as! T
        case is VisitorHistoryVM.Type:
            return VisitorHistoryVM(provider: data) as! T
        case is SettingsVM.Type:
            return SettingsVM(provider: data) as! T
        case is MenuVM.Type:
            return MenuVM(provider: data) as! T
        case is ListNotificationsVM.Type:
            return ListNotificationsVM(provider: data) as! T
//        case is MainSlideMenuViewModel.Type:
//            return MainSlideMenuViewModel(provider: data) as! T
        default:
            fatalError("\(type) not found")
        }
    }
    
}
