//
//  AppNetworking.swift
//  VisamaneIOS
//
//  Created by Nguyễn Hữu Tá on 9/8/20.
//  Copyright © 2020 Nguyễn Hữu Tá. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

struct AppNetworking: NetworkingType {
    typealias T = AppApi
    let provider: RemoteProvider<AppApi>

}

extension NetworkingType {
    static func appNetworking() -> AppNetworking {
        return AppNetworking(provider: newProvider(plugins))
    }
}

extension AppNetworking: AppRemoteProvider {
    
    func setToken(token: String) {
        T.token = "Bearer \(token)"
    }
    
    func login(body: [String: Any]) -> Single<LoginModel> {
        return provider.requestAPI(.login(body: body))
    }
}
