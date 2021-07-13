//
//  Result.swift
//  Ramen
//
//  Created by Duc Do on 2/24/20.
//  Copyright © 2020 goodcreate. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
enum Result<T> {
    case success(T)
    case failure(Error)
}

extension ObservableType {
    func mapToResult() -> Observable<Result<Element>> {
        return self.map { Result<Element>.success($0) }
            .catchError{ Observable.just(Result<Element>.failure($0)) }
    }
    
    
    func mapToResult(_ trackingError: PublishSubject<Error>) -> Observable<Element?> {
        return self.map { response -> Element in
            if response is BaseErrorResponse{
                throw response as! BaseErrorResponse
            }
            return response
        }.catchError { error in
            trackingError.onNext(error)
            return Observable.just(nil)
        }
    }
}

func postDelay(timeDelay: DispatchTimeInterval, completion: @escaping () -> ()){
    
    func toDouble(_ interval: DispatchTimeInterval) -> Double? {
        var result: Double? = 0
        
        switch interval {
        case .seconds(let value):
            result = Double(value)
        case .milliseconds(let value):
            result = Double(value)*0.001
        case .microseconds(let value):
            result = Double(value)*0.000001
        case .nanoseconds(let value):
            result = Double(value)*0.000000001
        case .never:
            result = nil
        @unknown default:
            result = nil
        }
        return result
    }
    guard let time = toDouble(timeDelay) else {
        completion()
        return
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + time){
        completion()
    }
}

extension Thread {
    
    var threadName: String {
        if let currentOperationQueue = OperationQueue.current?.name {
            return "OperationQueue: \(currentOperationQueue)"
        } else if let underlyingDispatchQueue = OperationQueue.current?.underlyingQueue?.label {
            return "DispatchQueue: \(underlyingDispatchQueue)"
        } else {
            let name = __dispatch_queue_get_label(nil)
            return String(cString: name, encoding: .utf8) ?? Thread.current.description
        }
    }
}
