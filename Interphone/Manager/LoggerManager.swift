//
//  LoggerManager.swift
//  Ramen
//
//  Created by Duc Do on 2/20/20.
//  Copyright © 2020 goodcreate. All rights reserved.
//

import Foundation

public func printLog<T>(_ typeOf : T,_ message:Any) {
    let dksMessage = "\(LogEvent.i.rawValue) \(type(of: typeOf)) : \(message)"
    #if DEBUG
    print(dksMessage)
    #endif
    
}
public func printError<T>(_ typeOf : T,_ message:Any) {
    let dksMessage = "\(LogEvent.e.rawValue) \(type(of: typeOf)) : \(message)"
    #if DEBUG
    print(dksMessage)
    #endif
}



internal enum LogEvent: String {
    case e = "[DKS] [‼️]" // error
    case i = "[DKS] [ℹ️]" // info
    case d = "[DKS] [💬]" // debug
    case v = "[DKS] [🔬]" // verbose
    case w = "[DKS] [⚠️]" // warning
    case s = "[DKS] [🔥]" // severe
}

