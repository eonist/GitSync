import Cocoa
@testable import Utils
@testable import Element

class UnfoldParser{
    /**
     * Traverses a hierarchy and find the Unfoldable at the correct path
     * PARAM: path: consists of many element id's
     * TODO: ⚠️️ A problem with this method is that it doesnt keep searching similar named parents. So if you have 2 parents with the same id, it only traverses the first
     */
    static func unfoldable(parent:UnFoldable, _ path:[String]) throws -> UnFoldable{
        guard let parentView = parent as? NSView else{ throw "parent does not exist" }
        for subView in parentView.subviews{
            if let subV = subView as? UnFoldable  {
                if UnfoldAsserter.isMatch(subV, path[0]){//asserts element.id
                    if path.count > 1 {
                        if let unfoldable = try? unfoldable(parent:subV, path.slice2(1, path.count)) {return unfoldable}/*removes first item in path*/ //retrieve(sub, path)
                    }else{
                        return subV
                    }
                }
            }
        }
        throw "unfoldable in parent: \(parent) at path: \(path) was not found"
    }
    /**
     * This method facilitate support for applying values to speccific SubClasses.
     * IMPORTANT: ⚠️️ In order to apply values to SubClasses you need to directly set it from the perspective of the type. Merly using A protocol will only result in applying the value to the super type
     * NOTE: a lot of time was spent researching a way around this and this is what is possible today. Preferably in the future there will be a way to dynamically set variables on subTypes via protocol. But not with swift4
     */
    static func unfoldable<T>(parent:UnFoldable, path:[String]) throws -> T{
        guard let unfoldable:UnFoldable = try? unfoldable(parent:parent,path), let retVal = unfoldable as? T else { throw "type does not match T" }
        return retVal
    }
    /**
     * EXAMPLE: let repo:String = UnFoldUtils.retrive(self,Key.repo,[TextInput.Key.inputText])
     */
    static func value<T>(_ view:UnFoldable, _ path:[String]) throws -> T{
        guard let unfoldable:UnFoldable = try? unfoldable(parent:view, path) else{throw "unable to find unfoldable in view: \(view) at path: \(path)"}
        guard let value:T = unfoldable.value as? T else {throw "value does not match the infered type"}
        return value
    }
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
