import Foundation
@testable import Element
/**
 * Consider adding default data methods in an extension that prints error if called to, or not as you probably wont be able to as easily override it etc
 */
protocol UnFoldable:class {
    typealias UnFoldMethod = ([String:Any]) throws -> UnFoldable
    static func unfold(dict:[String:Any]) throws -> UnFoldable
    var value:Any {get set}
}
extension UnFoldable{
    static func unfold(dict:[String:Any]) throws -> UnFoldable{
        fatalError("error must be overridden in \(self)")
    }
    /**
     * Returns the UI component data
     */
    var value: Any {
        get {fatalError("error: \(self)")}
        set {fatalError("error: in \(self) \(newValue)")}
    }
    /**
     * New
     * NOTE: Can't use generics because subscript doesn't support generics other than in classes
     */
    func retrieve<T>(_ path: [String]) throws -> T{
        return try UnfoldParser.value(self, path)
    }
    /**
     * EXAMPLE: self.apply([PrefsType.login,TextInput.Key.inputText],prefs.login)
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
