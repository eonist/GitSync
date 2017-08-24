import Foundation
@testable import Element
/**
 * Consider adding default data methods in an extension that prints error if called to, or not as you probably wont be able to as easily override it etc
 */
protocol UnFoldable {
    typealias UnFoldMethod = ([String:Any]) -> UnFoldable
    static func unfold(dict:[String:Any]) -> UnFoldable
    var value:Any {get set}
}
extension UnFoldable{
    static func unfold(dict:[String:Any]) -> UnFoldable{
        fatalError("error must be overridden")
    }
    /**
     * Returns the UI component data
     */
    var value: Any {
        get {fatalError("error")}
        set {fatalError("error")}
    }
    /**
     * New
     * NOTE: Can't use generics because subscript doesn't support generics other than in classes
     */
    func retrieve<T>(_ path: [String]) -> T?{
        return UnfoldParser.retrieveValue(self, path)
    }
    /**
     * New
     */
    func apply(_ path:[String],_ value:Any){
        UnfoldModifier.applyData(self, path, value)
    }
}
//    var data: [String : Any] {
//        get {fatalError("error")}
//        set {fatalError("error")}
//    }
//    var data:[String:Any] {get set}//this should probably be just any? TODO: Rename to unfoldData, as data is ambigiouse
