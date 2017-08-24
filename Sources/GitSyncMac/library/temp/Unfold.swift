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
     * New
     * TODO:    Move into parser and modifier
     * TODO: ⚠️️ In the future you will use a json method that can take an [Any] that contains str and int for the path. so you can do path:["app",0,"repoView"] etc
     */
    static func unFold(_ fileURL:String, _ path:String, _ parent:Element){
//      Swift.print("UnFoldUtils.unFold()")
        JSONParser.dictArr(JSONParser.dict(fileURL.content?.json)?[path])?.forEach{ dict in
            guard let element:Element = Unfold.unFold(dict,parent) else{fatalError("unFold failed")}
            parent.addSubview(element)
        }
//      Swift.print("after unFold fileUrl")
    }
    /**
     * We store types as an array as its easier/more dynamic than a swich
     */
    static let unfoldables:[UnFoldable.Type] = [Text.self,TextInput.self,RadioButton.self,CheckBoxButton.self,TextButton.self,Text.self,FilePicker.self]
    
    static let unfoldableDict:[String:UnFoldable.UnFoldMethod] = unfoldables.reduce([:])  {
        var dict:[String:UnFoldable.UnFoldMethod] = $0
        dict["\($1)"] = ($1 as UnFoldable.Type).unfold
        return dict
    }
    /**
     * Initiates and returns a UI Component
     */
    static func unFold(_ dict:[String:Any], _ parent:ElementKind? = nil) -> Element?{
        guard let type:String = dict["type"] as? String else {fatalError("type must be string")}
        guard let unfoldMethod:UnFoldable.UnFoldMethod = unfoldableDict[type] else {fatalError("Type is not unFoldable: \(type)")}/*we return nil here instead of fatalError, as this method could be wrapped in a custom method to add other types etc*/
        Swift.print("type: " + "\(type)")
        return unfoldMethod(dict,parent) as? Element
    }
    /**
     * String
     */
    static func value(_ dict:[String:Any],_ key:String) -> String?{
        if let value:Any = dict[key] {
            if let str = value as? String {return str}
            else {fatalError("type not supported: \(value)")}
        };return nil
    }
    /**
     * cgFloat
     */
    static func value(_ dict:[String:Any],_ key:String) -> CGFloat{
        if let value:Any = dict[key] {
            if let str = value as? String {return str.cgFloat}
            else if let int = value as? Int {return int.cgFloat}
            else {fatalError("type not supported: \(value)")}
        };return NaN
    }
    /**
     * PARAM: path: Basically the id path to search a hierarchy with
     * This method is recursive
     * IMPROVMENT: ⚠️️ Might need to change view to generic, because not all NSViews are unfoldable, think containers etc
     */
    static func applyData(_ view:UnFoldable, _ path:[String],_ value:Any){
        if var unfoldable:UnFoldable = retrieveUnFoldable(parent:view, path)/*, let last = path.last*/{
//            Swift.print("unfoldable: " + "\(unfoldable)")
            unfoldable.value = value
        }
    }
    private static func isMatch(_ unfoldable:UnFoldable, _ id:String) -> Bool{
        if let element = unfoldable as? ElementKind, element.id == id {
//            Swift.print("found a match")
            return true
        }else{
//            Swift.print("no match")
            return false
        }
    }
    /**
     * Traverses a hierarchy and find the Unfoldable at the correct path
     */
    static func retrieveUnFoldable(parent:UnFoldable, _ path:[String]) -> UnFoldable?{
        guard let parentView = parent as? NSView else{
//            Swift.print("parent isn't a nsview")
            return nil
        }
        for subView in parentView.subviews{
            if let sub = subView as? UnFoldable  {
                if isMatch(sub, path[0]){
                    if path.count > 1 {
                        return retrieveUnFoldable(parent:sub, path.slice2(1, path.count))//removes first item in path//retrieve(sub, path)
                    }else{
                        return sub
                    }
                }
            }
        }
        return nil
    }
    
    /**
     * Retrieve value from hierarchy with PARAM: path
     * NOTE: Similar to apply data but retrives data instead of applying
     * PARAM: pathBasically the id path to search a hierarchy with
     * This method is recursive
     */
//    static func retrieveData(_ view:UnFoldable, _ path:[String]) -> [String:Any]?{
//        return retrieve(view, path)?.data
//    }
    /**
     * EXAMPLE: let repo:String = UnFoldUtils.retrive(self,Key.repo,[TextInput.Key.inputText])
     */
    static func retrieveValue<T>(_ view:UnFoldable, _ path:[String]) -> T?{
        let unfoldable:UnFoldable? = retrieveUnFoldable(parent:view, path)
//        Swift.print("unfoldable: " + "\(unfoldable)")
//        Swift.print("unfoldable?.value: " + "\(unfoldable?.value)")
        let value:T? = unfoldable!.value as? T
//        Swift.print("value: " + "\(value)")
        return value
    }
    
    /**
     *
     */
//    static func retrieveData(_ view:Element, _ id:String) -> [String:Any]?{
//        for subView in view.subviews {
//            if let unFoldable:UnFoldable = subView as? UnFoldable,
//                let element = subView as? IElement,
//                id == element.id {
//                    return unFoldable.data
//            }
//        }
//        return nil
//    }
    /**
     * Apply data to unfoldable items to all subviews in an Element
     * TODO:    ⚠️️  probably do .first instead
     */
//    static func applyData(_ view:Element, _ data:[String:[String:Any]]){
//        Swift.print("applyData")
//        view.subviews.forEach{ subView in
////            Swift.print("subView: " + "\((subView))")
////            if let subView = subView as? ElementKind, let isUnfoldable = subView as? UnFoldable{
////                 Swift.print("(subview as! ElementKind).id: " + "\((subView as! ElementKind).id!)")
//
////                Swift.print("isUnfoldable: " + "\(isUnfoldable)")
////            }
//            if var unFoldable:UnFoldable = subView as? UnFoldable,
//                let element = subView as? ElementKind,
//                let id:String = element.id,
//                let value:[String:Any] = data[id] {
//                    Swift.print("set data to unfoldable")
//                    unFoldable.data = value
//            }
//        }
//    }
    /**
     *
     */
    /*static func applyData(_ dict:[String:Any]){
     guard let type:String = dict["type"] as? String else {fatalError("type must be string")}
     switch true{
     case type == "\(TextInput.self)":
     return TextInput.unFold(dict,parent)
     case type == "\(CheckBoxButton.self)":
     return CheckBoxButton.unFold(dict,parent)
     case type == "\(TextButton.self)":
     return TextButton.unFold(dict,parent)
     case type == "\(Text.self)":
     return Text.unFold(dict,parent)
     default:
     fatalError("Type is not unFoldable: \(type)")
     //return nil/*we return nil here instead of fatalError, as this method could be wrapped in a custom method to add other types etc*/
     }
     }*/
}
