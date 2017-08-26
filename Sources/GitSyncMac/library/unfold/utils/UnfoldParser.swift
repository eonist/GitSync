import Cocoa
@testable import Utils
@testable import Element

class UnfoldParser{
    /**
     * Traverses a hierarchy and find the Unfoldable at the correct path
     * PARAM: path: consists of many element id's
     * TODO: ⚠️️ A problem with this method is that it doesnt keep searching similar named parents. So if you have 2 parents with the same id, it only traverses the first
     */
    static func retrieveUnFoldable(parent:UnFoldable, _ path:[String]) -> UnFoldable?{
        guard let parentView = parent as? NSView else{ return nil }
        for subView in parentView.subviews{
            if let sub = subView as? UnFoldable  {
                if UnfoldAsserter.isMatch(sub, path[0]){//asserts element.id
                    if path.count > 1 {
                        return retrieveUnFoldable(parent:sub, path.slice2(1, path.count))/*removes first item in path*/ //retrieve(sub, path)
                    }else{
                        return sub
                    }
                }
            }
        }
        return nil
    }
    /**
     * EXAMPLE: let repo:String = UnFoldUtils.retrive(self,Key.repo,[TextInput.Key.inputText])
     */
    static func retrieveValue<T>(_ view:UnFoldable, _ path:[String]) -> T?{
        let unfoldable:UnFoldable? = retrieveUnFoldable(parent:view, path)
        let value:T? = unfoldable!.value as? T
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
