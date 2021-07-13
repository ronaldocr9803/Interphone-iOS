//
//  StringExtension.swift
//  Ramen
//
//  Created by Nguyễn Hữu Tá on 2/27/20.
//  Copyright © 2020 goodcreate. All rights reserved.
//

import Foundation
extension String{
    var localized: String {
      return NSLocalizedString(self, comment: "\(self)_comment")
    }
    
    func localized(_ args: CVarArg...) -> String {
      return String(format: localized, args)
    }
    
    /// How to use
    // "hello".localized
    // "hello %@! you are %d years old".localized("Raka", 25)
    // "hello %@! you are %d years old".localized(["Sama", 25])
    
    func isNotEmpty() -> Bool{
        return !self.isEmpty
    }
    
    var trim: String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
}
