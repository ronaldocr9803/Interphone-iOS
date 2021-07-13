//
//  AppDataManager.swift
//  Ramen
//
//  Created by Duc Do on 2/24/20.
//  Copyright © 2020 goodcreate. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

class AppDataManager: DataManager {
    
    private let appProvider: AppRemoteProvider
    private let userDefaultManager: UserDefaultManager
    var disposeBag = DisposeBag()
    
    //private
    
//    private var _loginModel: LoginModel?{
//        get{
//            return userDefaultManager.getObject(key: .loginModel)
//        }
//        set{
//            userDefaultManager.setObject(key: .loginModel, value: newValue)
//        }
//    }
    
    
    
    //All variable
    var token: String =  ""
    var loginModel: LoginModel? = nil
    init(authProvider: AppRemoteProvider) {
        self.appProvider = authProvider
        userDefaultManager = UserDefaultManager.share
    }
    
    
    
}

extension AppDataManager: AppRemoteProvider {
    func setToken(token: String) {
        
    }
    func login(body: [String: Any]) -> Single<LoginModel> {
        return appProvider.login(body: body)
    }
    
    func onLogout() {
        
    }
    
    
}
