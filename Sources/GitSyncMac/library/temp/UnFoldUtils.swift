import Foundation
@testable import Element
@testable import Utils

class UnFoldUtils{
    /**
     * New
     * TODO: ⚠️️ In the future you will use a json method that can take an [Any] that contains str and int for the path. so you can do path:["app",0,"repoView"] etc
     */
    static func unFold(_ fileURL:String, _ path:String, _ parent:Element){
        JSONParser.dictArr(JSONParser.dict(fileURL.content?.json)?[path])?.forEach{
            if let element:Element = UnFoldUtils.unFold($0,parent) {
                parent.addSubview(element)
            }
        }
    }
    static func unFold(_ dict:[String:Any], _ parent:IElement? = nil) -> Element?{
        guard let type:String = dict["type"] as? String else {fatalError("type must be string")}
        switch true{
            case type == "\(TextInput.self)":
                return TextInput.unFold(dict,parent)
            case type == "\(CheckBoxButton.self)":
                return CheckBoxButton.unFold(dict,parent)
            case type == "\(TextButton.self)":
                return TextButton.unFold(dict,parent)
            case type == "\(Text.self)":
                //return Text.unFold(dict,parent)
                return Text(100,100,"soemthine", parent, "header" )
            default:
                fatalError("Type is not unFoldable: \(type)")
                //return nil/*we return nil here instead of fatalError, as this method could be wrapped in a custom method to add other types etc*/
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
