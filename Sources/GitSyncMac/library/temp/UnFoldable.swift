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
extension Element:UnFoldable{
    subscript(path: [String]) -> T? {
        get {
            return UnFoldUtils.retrieve(self, path)
        }
        set {
            UnFoldUtils.applyData(self, <#T##path: [String]##[String]#>, <#T##value: Any##Any#>)
        }
    }
}
