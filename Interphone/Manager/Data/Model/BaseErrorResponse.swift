//
//  BaseErrorResponse.swift
//  ios-template-app
//
//  Created by OpenYourEyes on 05/01/2021.
//

import Foundation
class BaseErrorResponse: Codable, LocalizedError{
    static var success = 200
    static var tokenExpired = 401
    
    var detail: String?
    var code: Int?
    
    init(errorMessage: String, errorCode: Int = 0) {
        detail = errorMessage
        code = errorCode
    }
    
    func tokenExpired()-> Bool{
        //The Token is expired
        //Invalid Token
        return code == BaseErrorResponse.tokenExpired
    }
    var errorDescription: String?{
        return detail ?? "try again"
    }
}
