import Foundation
@testable import Element
/**
 * Consider adding default data methods in an extension that prints error if called to, or not as you probably wont be able to as easily override it etc
 */
protocol UnFoldable {
    //unfold
    //data 
    var data:[String:Any] {get set}//this should probably be just any? TODO: Rename to unfoldData, as data is ambigiouse
//    static func unfold<T>(_ unfoldDict:[String:Any], _ parent:IElement?) -> T
    //init(unfoldDict:[String:Any], parent:ElementKind?)
}
extension UnFoldable{
    var data: [String : Any] {
        get {fatalError("error")}
        set {fatalError("error")}
    }
    /**
     * New
     * NOTE: Can't use generics because subscript doesn't support generics other than in classes
     */
    func retrieve<T>(_ path: [String]) -> T?{
        return UnFoldUtils.retrieve(self, path) as? T
    }
    /**
     * New
     */
    func apply(_ path:[String],_ value:Any){
        UnFoldUtils.applyData(self, path, value)
    }
}
