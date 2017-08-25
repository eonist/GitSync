import Cocoa
@testable import Element
@testable import Utils
/**
 * TODO: ⚠️️ rename unFold to unfold
 * NOTE: https://github.com/Zewo/Reflection  (native swift KVC KeyValueCoding, but complex and brittle)
 * IMPORTANT: ⚠️️ The reason we don't use convenience init is because it cannot be overriden in extensions, But a static func can if its added inside  an extension that uses where and Self:ClassName. Also init cant be defined as a method pointer
 */
class Unfold{
    /**
     * Creats UI components and adds them to a parent
     * TODO: ⚠️️ In the future you will use a json method that can take an [Any] that contains str and int for the path. so you can do path:["app",0,"repoView"] etc
     */
    static func unFold(fileURL:String, path:String, parent:Element){
//        Swift.print("Unfold.unFold")
        guard let jsonDict:[String: Any] = JSONParser.dict(fileURL.content?.json) else{fatalError("fileURL: is incorrect: \(fileURL)")}
        guard let jsonDictItem:Any = jsonDict[path] else{fatalError("path is incorrect: \(path)")}
        guard let jsonArr:[[String:Any]] = JSONParser.dictArr(jsonDictItem) else{fatalError("jsonDictItem: is incorrect")}
        unfold(jsonArr:jsonArr,parent:parent)
    }
    /**
     * New
     */
    static func unfold(jsonArr:[[String:Any]],parent:Element){
        jsonArr.forEach{ dict in
            guard let element:Element = Unfold.unFold(dict:dict) else{fatalError("unFold failed")}
            parent.addSubview(element)
        }
    }
    /**
     * Initiates and returns a UI Component
     */
    private static func unFold(dict:[String:Any]) -> Element?{
        guard let type:String = dict["type"] as? String else {fatalError("type must be string")}
        guard let unfoldMethod:UnFoldable.UnFoldMethod = Unfoldables.dict[type] else {fatalError("Type is not unFoldable: \(type)")}/*we return nil here instead of fatalError, as this method could be wrapped in a custom method to add other types etc*/
        return unfoldMethod(dict) as? Element
    }
}
