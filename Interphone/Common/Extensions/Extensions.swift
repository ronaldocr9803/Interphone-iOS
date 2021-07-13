//
//  Extensions.swift
//  Zaimane
//
//  Created by Benjie on 9/2/20.
//  Copyright © 2020 WillGroup. All rights reserved.
//

import Foundation
import UIKit

extension UInt8 {
    
    func toString() -> String {
        var str = String(self, radix: 16).uppercased()
        if str.count == 1 {
            str = "0" + str
        }
        return str
    }
    
    func toHexString() -> String {
        var str = self.toString()
        str = "0x\(str)"
        return str
    }
}

extension String {
    func toUInt8() -> [UInt8] {
       let strToUInt8:[UInt8] = [UInt8](self.utf8)
       return strToUInt8
    }
}

extension StringProtocol {
    subscript(bounds: CountableClosedRange<Int>) -> SubSequence {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(start, offsetBy: bounds.count)
        return self[start..<end]
    }
    
    subscript(bounds: CountableRange<Int>) -> SubSequence {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(start, offsetBy: bounds.count)
        return self[start..<end]
    }
    
    func index(of string: Self, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    
    var hexaData: Data { .init(hexa) }
    var hexaBytes: [UInt8] { .init(hexa) }
    private var hexa: UnfoldSequence<UInt8, Index> {
        sequence(state: startIndex) { startIndex in
            guard startIndex < self.endIndex else { return nil }
            let endIndex = self.index(startIndex, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            defer { startIndex = endIndex }
            return UInt8(self[startIndex..<endIndex], radix: 16)
        }
    }

}


extension Sequence where Element == UInt8 {
    var data: Data { .init(self) }
    var hexa: String { map { .init(format: "%02x", $0) }.joined() }
}

extension UITextField {

    func glowWithColor(_ color: UIColor){
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.7
    }
    
    func removeGlow(){
        layer.masksToBounds = true
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 0
        layer.shadowOpacity = 0
    }
}

extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}

extension UIButton {
    
    open override var isEnabled: Bool{
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
        }
    }
}

func calculateKeyboardSize(_ notification: Notification?, completion: @escaping (CGSize) -> Void) {
    var _kbSize:CGSize!
    
    if let info = notification?.userInfo {

        let frameEndUserInfoKey = UIResponder.keyboardFrameEndUserInfoKey
        
        //  Getting UIKeyboardSize.
        if let kbFrame = info[frameEndUserInfoKey] as? CGRect {
            
            let screenSize = UIScreen.main.bounds
            
            //Calculating actual keyboard displayed size, keyboard frame may be different when hardware keyboard is attached (Bug ID: #469) (Bug ID: #381)
            let intersectRect = kbFrame.intersection(screenSize)
            
            if intersectRect.isNull {
                _kbSize = CGSize(width: screenSize.size.width, height: 0)
            } else {
                _kbSize = intersectRect.size
            }
            completion(_kbSize)
            
        }
    }

}

extension UITableViewCell {
    func makeFullWidthSeperator() {
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
    }
}
