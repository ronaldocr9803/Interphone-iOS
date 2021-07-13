//
//  LocalizableDelegate.swift
//  Ramen
//
//  Created by Nguyễn Hữu Tá on 2/27/20.
//  Copyright © 2020 goodcreate. All rights reserved.
//

import Foundation
protocol LocalizableDelegate {
    var rawValue: String { get }    //localize key
    var table: String? { get }
    var toString: String { get }
}
extension LocalizableDelegate {

    //returns a localized value by specified key located in the specified table
    var toString: String {
        return Bundle.main.localizedString(forKey: rawValue, value: nil, table: table)
    }

    // file name, where to find the localized key
    // by default is the Localizable.string table
    var table: String? {
        return nil
    }
}
