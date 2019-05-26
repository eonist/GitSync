import Foundation
@testable import Utils
@testable import Element

protocol ElementConfigurable{
    var elementConfig:ElementConfig {get}
    var size:CGSize {get}
    var parent:ElementKind? {get}
    var id:String? {get}
}
extension ElementConfigurable{
    var size:CGSize {return elementConfig.size}
    var id:String? {return elementConfig.id}
    var parent:ElementKind? {fatalError("err")}
}
struct ElementConfig{/*Default Element config*/
    var size:CGSize
    let id:String?
    init(_ dict:[String:Any]){
        let width:CGFloat = UnfoldUtils.value(dict, "width")
        let height:CGFloat = UnfoldUtils.value(dict, "height")
        size = CGSize(width,height)
        id = UnfoldUtils.value(dict, "id")
    }
}

