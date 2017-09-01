import Foundation
@testable import Element

class UnfoldModifier {
    enum UnfoldError:Error {
        case PathDoesNotExist//"Can't find unfoldable for path: \(path)"
    }

    /**
     * PARAM: path: Basically the id path to search a hierarchy with
     * This method is recursive
     * IMPROVMENT: ⚠️️ Might need to change view to generic, because not all NSViews are unfoldable, think containers etc
     */
   
    static func applyData(_ view:UnFoldable, _ path:[String],_ value:Any)  {
        do {
            var unfoldable:UnFoldable = try UnfoldParser.instance(parent:view, path)/*, let last = path.last*/
            Swift.print("unfoldable: path: \(path) " + "\(unfoldable) id: \((unfoldable as! ElementKind).id)")
            unfoldable.value = value
        } catch {
            Swift.print("error: " + "\(error)")
        }
    }
}




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
