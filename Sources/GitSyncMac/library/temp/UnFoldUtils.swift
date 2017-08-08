import Cocoa
@testable import Element
@testable import Utils
/**
 * TODO: ⚠️️ rename unFold to unfold
 */
class UnFoldUtils{
    /**
     * New
     * TODO: ⚠️️ In the future you will use a json method that can take an [Any] that contains str and int for the path. so you can do path:["app",0,"repoView"] etc
     */
    static func unFold(_ fileURL:String, _ path:String, _ parent:Element){
//        Swift.print("UnFoldUtils.unFold()")
        JSONParser.dictArr(JSONParser.dict(fileURL.content?.json)?[path])?.forEach{ dict in
            guard let element:Element = UnFoldUtils.unFold(dict,parent) else{fatalError("unFold failed")}
            parent.addSubview(element)
        }
//        Swift.print("after unFold fileUrl")
    }
    /**
     * Initiates and returns a UI Component
     */
    static func unFold(_ dict:[String:Any], _ parent:ElementKind? = nil) -> Element?{
//        Swift.print("UnFoldUtils.unFold")
        guard let type:String = dict["type"] as? String else {fatalError("type must be string")}
//        Swift.print("type: " + "\(type)")
        switch true{
            case type == "\(TextInput.self)":
                return TextInput.unfold(dict,parent)
            case type == "\(RadioButton.self)":
                return RadioButton.unfold(radioButtonUnfoldDict:dict,parent)
            case type == "\(CheckBoxButton.self)":
                return CheckBoxButton.unfold(dict,parent)
            case type == "\(TextButton.self)":
                return TextButton.unfold(dict,parent)
            case type == "\(Text.self)":
                return Text.unfold(dict,parent)
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
    /**
     * PARAM: path: Basically the id path to search a hierarchy with
     * This method is recursive
     * IMPROVMENT: ⚠️️ Might need to change view to generic, because not all NSViews are unfoldable, think containers etc
     */
    static func applyData(_ view:UnFoldable, _ path:[String],_ value:Any){
        if var unfoldable:UnFoldable = retrieveUnFoldable(view, path)/*, let last = path.last*/{
            Swift.print("unfoldable: " + "\(unfoldable)")
            unfoldable.value = value
        }
    }
    /**
     * Traverses a hierarchy and find the Unfoldable at the correct path
     */
    static func retrieveUnFoldable(_ parent:UnFoldable, _ path:[String]) -> UnFoldable?{
        
        guard let parentView = parent as? NSView else{
            Swift.print("parent isnt a nsview")
            return nil
        }
        
        func isMatch(_ unfoldable:UnFoldable) -> Bool{
            if let element = unfoldable as? Element, path.count == 1, element.id == path[0] {
                Swift.print("found a match")
                return true
            }else{
                Swift.print("no match")
                return false
            }
        }
        if isMatch(parent) {//check if parent it self is a match
            return parent
        }else {//check if children can be a match
            for subView in parentView.subviews{
                if let unfoldable = subView as? UnFoldable  {
                    if isMatch(unfoldable) {
                        return unfoldable
                    }else {
                        let retVal =  retrieveUnFoldable(unfoldable, path.slice2(1, path.count))//removes first item in path
                        if retVal != nil {
                            return retVal
                        }
                    }
                }
            }
        }
        
        
        
        
        
        
        //check if item is a match
        
        
        //check if any subItem is a match
        
        
//        Swift.print("unfoldable: unfoldable:\(unfoldable) path: \(path) element.id: \((unfoldable as! ElementKind).id) path[0]: \(path[0])")
//       
//
//        
//        if let element = unfoldable as? Element, path.count == 1, element.id == path[0] {
//            Swift.print("found a match")
//            return unfoldable
//        }else if path.count > 1 && !view.subviews.isEmpty{
//            Swift.print("no match, keep searching")
//            for subView in view.subviews{
//                if let unfoldable = subView as? UnFoldable  {
//                    let retVal =  retrieveUnFoldable(unfoldable, path.slice2(1, path.count))//removes first item in path
//                    if retVal != nil {
//                        return retVal
//                    }
//                }
//            }
//        }else{
//            Swift.print("no match, cant keep searching")
//        }
        
//        
//        Swift.print("view: " + "\(view)")
//                for subView in view.subviews{
//            if let unFoldable:UnFoldable = subView as? UnFoldable,let element = subView as? Element,let id:String = element.id{
//                Swift.print("id: " + "\(id)" + " path[0]: " + "\(path[0]) path: \(path)")
//                if path.count == 1 && path[0] == id{
//                    Swift.print("found the match")
//                    return unFoldable
//                }else if path.count > 1{//keep searching down hierarchy
//                    Swift.print("no match")
//                    
//                }
//            }
//        }
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
        let unfoldable:UnFoldable? = retrieveUnFoldable(view, path)
//        Swift.print("unfoldable: " + "\(String(describing: unfoldable))")
        let value:T? = unfoldable?.value as? T
//        Swift.print("value: " + "\(String(describing: value))")
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
