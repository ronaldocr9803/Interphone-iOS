
import Foundation
enum KeyUserDefaults: String{
    case email = "email"
    case seeIntroduction = "seeIntroduction"
    case loginModel = "loginModel"
    case shopModel = "shopModel"
}
class UserDefaultManager {
    static let share = UserDefaultManager()
    lazy var userDefaults: UserDefaults = {
        UserDefaults.standard
    }()
    
    func set<T>(key: KeyUserDefaults, value: T){
        userDefaults.set(value, forKey: key.rawValue)
    }
    func get<T>(key: KeyUserDefaults, type: T.Type )-> T{
        switch type {
        case is Int.Type:
            guard let result = (userDefaults.integer(forKey: key.rawValue) as? T) else { return (0 as! T) }
            return result
        case is String.Type:
            guard let result = (userDefaults.string(forKey: key.rawValue) as? T) else { return ("" as! T) }
            return result
        case is Bool.Type:
            guard let result = (userDefaults.bool(forKey: key.rawValue) as? T) else { return (false as! T) }
            return result
        default:
            fatalError("\(type) not found")
        }
    }
    
    func setObject<T>(key: KeyUserDefaults, value: T) where T: Codable{
        _ = try? userDefaults.setObject(value, forKey: key.rawValue) as? T
    }
    
    func getObject<T>(key: KeyUserDefaults)-> T? where T: Codable{
        return try? userDefaults.getObject(forKey: key.rawValue, castTo: T.self)
    }
    
}




protocol ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}


extension UserDefaults: ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }
    
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
}

enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
    
    var errorDescription: String? {
        rawValue
    }
}


