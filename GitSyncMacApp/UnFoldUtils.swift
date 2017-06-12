import Foundation
@testable import Element
@testable import Utils

class UnFoldUtils{
    static func unFold(_ dict:[String:Any]) -> IElement?{
        guard let type:String = dict["type"] as? String else {fatalError("type must be string")}
        switch true{
            case type == "\(TextInput.self)":
                return TextInput.unFold(dict)
            case type == "\(CheckBoxButton.self)":
                return nil
            default:
                return nil
        }
    }
    /**
     * String
     */
    static func string(_ dict:[String:Any],_ key:String) -> String?{
        if let value:Any = dict[key] {
            if let str = value as? String {return str}
            else {fatalError("type not supported: \(value)")}
        };return nil
    }
    /**
     * cgFloat
     */
    static func cgFloat(_ dict:[String:Any],_ key:String) -> CGFloat{
        if let value:Any = dict[key] {
            if let str = value as? String {return str.cgFloat}
            else if let int = value as? Int {return int.cgFloat}
            else {fatalError("type not supported: \(value)")}
        };return NaN
    }
}
