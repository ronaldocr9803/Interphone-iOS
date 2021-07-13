//
//  AuthRemoteProvider.swift
//  Ramen
//
//  Created by Duc Do on 2/24/20.
//  Copyright © 2020 goodcreate. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON
import Moya

protocol AppRemoteProvider {
    func setToken(token: String)
    func login(body: [String: Any]) -> Single<LoginModel>
}

enum AppApi {
    static var token: String = ""
    case login(body: [String: Any])
}

extension AppApi: TargetType {
    var baseURL: URL {
        return Configs.Network.baseUrl
    }
    
    var path: String {
        switch self {
        case .login:
            return "auth/login/app"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login(_):
            return .post
        default:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .login(_):
            return ["Content-Type" : "application/json"]
        default:
            return ["Authorization": AppApi.token ,
                    "Content-Type" : "application/json" ]
        }
    }
    
    private var parameters: [String: Any]? {
        switch self {
        case .login(let body):
            return body
        default:
            return nil
        }
        
    }
    
    private var parameterEncoding: ParameterEncoding {
        switch self {
        case .login:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
    
    public var task: Task {
        if let parameters = parameters {
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
        return .requestPlain
    }
    
    var sampleData: Data {
        return Data()
    }
}


extension Dictionary {
    var toQueryString: String {
        return self.reduce("") { (result, arg1) -> String in
            let (key, value) = arg1
            if result.isEmpty{
                return "?\(key)=\(value)"
            }else{
                return result + "&\(key)=\(value)"
            }
        }
    }
}
