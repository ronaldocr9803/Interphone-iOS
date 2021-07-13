//
//  DataManager.swift
//  Ramen
//
//  Created by Duc Do on 2/24/20.
//  Copyright © 2020 goodcreate. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol DataManager: AppRemoteProvider {
    //variable
    var token: String { get }
    
    //functionnal
    func onLogout()
}
