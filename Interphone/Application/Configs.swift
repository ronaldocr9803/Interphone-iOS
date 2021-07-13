
import Foundation
import UIKit

struct Configs {
    
    struct Network {
        
        enum Environment {
            case development
            case product
        }
        
        static let environment: Environment = .product
        
        static var baseUrl: URL {
            switch environment {
            case .development:
                return URL(string: "google.dev")!
            case .product:
                return URL(string: "google")!
            }
            
        }
    }
}

class Color : UIColor{
    static let primary: UIColor = UIColor(hex: "#C9285C") ?? .red
    static let backgroundController = UIColor(hex: "#f3f5f9")
    static let disable: UIColor = UIColor(hex: "#D2D4D8") ?? .red
    static let textDisable: UIColor = UIColor(hex: "#3C3C43") ?? .red
    static let line: UIColor = UIColor(hex: "#CCCCCC") ?? .red
    static let colorGreen: UIColor = UIColor(hex: "#CEE741") ?? .red
    static let colorBlue: UIColor = UIColor(hex: "#007AFF") ?? .red
    static let colorStroke: UIColor = UIColor(hex: "#E4E4E6") ?? .red
    static let colorRed = UIColor(hex: "#FF0000") ?? .red
    static let seconTextColor = UIColor(hex: "#34454C") ?? .red
    static let colorLine = UIColor(hex: "#E0E0E0") ?? .red
}
class Constants{
    static let defaultHeight = CGFloat(50)
    static let limit: Int = 30
    static let zeroPage: Int = 0
    static let firstPage: Int = 1
}
class Fonts: UIFont{
    static func Default(_ size: CGFloat = 17) -> UIFont{
        return boldSystemFont(ofSize: size)
    }
}

