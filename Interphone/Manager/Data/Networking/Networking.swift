//
//  Networking.swift
//  Ramen
//
//  Created by Duc Do on 2/24/20.
//  Copyright © 2020 goodcreate. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

class DefaultSessionManager: Session {
    static let shared: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 20
        return Session(configuration: configuration, startRequestsImmediately: false)
    }()
}

class RemoteProvider<Target> where Target: Moya.TargetType {
    fileprivate let provider: MoyaProvider<Target>
    
    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider<Target>.neverStub,
         session: Session = DefaultSessionManager.shared,
         plugins: [PluginType] = [],
         trackInflights: Bool = false) {
        self.provider = MoyaProvider(endpointClosure: endpointClosure,
                                     requestClosure: requestClosure,
                                     stubClosure: stubClosure,
                                     session: session,
                                     plugins: plugins,
                                     trackInflights: trackInflights)
    }
    
    private func request(_ token: Target) -> Single<Moya.Response> {
        return provider.rx
            .request(token)
    }
    
    private func requestJSON(_ token: Target) -> Single<JSON> {
        return request(token).map { (response) -> JSON in
            try JSON(data: response.data)
        }
    }
    
    
    func requestAPI<R: Codable>(_ target: Target) -> Single<R> {
        let fullPath = "\(target.baseURL)\(target.path)"
        printLog(self, "Request   -->> \(fullPath)")
        return request(target).map { (response) -> R in
            do{
                return try self.parserData(R.self, from: response)
            }catch{
                throw error
            }
        }
    }
    
    func requestArrayAPI<R: Codable>(_ target: Target) -> Single<[R]> {
        let fullPath = "\(target.baseURL)\(target.path)"
        printLog(self, "Request   -->> \(fullPath)")
        return request(target).map { (response) -> [R] in
            do{
                return try self.parserData([R].self, from: response)
            }catch{
                throw error
            }
        }
    }
    
    private func parserData<T>(_ type: T.Type, from response: Response) throws -> T where T : Decodable{
        let data = response.data
        let fullPath = response.request?.url?.absoluteString ?? ""
        
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        printLog(self, "Response  <<-- \(fullPath) \(json)")
        let statusCode = response.statusCode
        if statusCode == 200{
            do{
                let baseResponse = try JSONDecoder().decode(type, from: data)
                return baseResponse
            }catch{
                do{
                    let errorResponse = try JSONDecoder().decode(BaseErrorResponse.self, from: data)
                    printError(self, "Request failure  <<-- \(errorResponse.detail ?? "")")
                    throw errorResponse
                }catch{
                    self.catchError(error: error)
                    throw error
                }
            }
        }else{
            do{
                let errorResponse = try JSONDecoder().decode(BaseErrorResponse.self, from: data)
                errorResponse.code = statusCode
                throw errorResponse
            }catch{
                self.catchError(error: error)
                throw error
            }
        }
    }
    
    private func catchError(error: Error){
        if error is DecodingError{
            let decodingError = error as! DecodingError
            switch decodingError {
            case .typeMismatch(let key, let value):
                printLog(self, "error \(key), value \(value) and ERROR: \(error.localizedDescription)")
                break
            case .valueNotFound(let key, let value):
                printLog(self, "error \(key), value \(value) and ERROR: \(error.localizedDescription)")
            case .keyNotFound(let key, let value):
                printLog(self, "error \(key), value \(value) and ERROR: \(error.localizedDescription)")
            case .dataCorrupted(let key):
                printLog(self, "error \(key), and ERROR: \(error.localizedDescription)")
            default:
                printLog(self, "ERROR: \(error.localizedDescription)")
            }
        }else{
            printLog(self, "errorCatch: \(error.localizedDescription)")
        }
    }
    
    
    
}
protocol NetworkingType {
    associatedtype T: TargetType
    var provider: RemoteProvider<T> { get }
}

extension NetworkingType {
    static func endpointsClosure<T>() -> (T) -> Endpoint where T: TargetType {
        return { target in
            let endpoint = MoyaProvider.defaultEndpointMapping(for: target)
            // Sign all non-XApp, non-XAuth token requests
            return endpoint
        }
    }
    
    static func APIKeysBasedStubBehaviour<T>(_: T) -> Moya.StubBehavior {
        return .never
    }
    
    static var plugins: [PluginType] {
        var plugins: [PluginType] = []
        #if DEBUG
        plugins.append(NetworkLoggerPlugin())
        #endif
        return plugins
    }
    
    // (Endpoint<Target>, NSURLRequest -> Void) -> Void
    static func endpointResolver() -> MoyaProvider<T>.RequestClosure {
        return { (endpoint, closure) in
            do {
                var request = try endpoint.urlRequest() // endpoint.urlRequest
                request.httpShouldHandleCookies = false
                closure(.success(request))
            } catch {
                printError(self, error.localizedDescription)
            }
        }
    }
    
    static func newProvider<T>(_ plugins: [PluginType]) -> RemoteProvider<T> {
        return RemoteProvider(endpointClosure: endpointsClosure(),
                              requestClosure: endpointResolver(),
                              stubClosure: APIKeysBasedStubBehaviour,
                              plugins: plugins)
    }
}



