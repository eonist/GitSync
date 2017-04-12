import Cocoa
@testable import Utils
@testable import Element

protocol Containable3{
    var maskSize:CGSize {get}
    var contentSize:CGSize {get}
    var contentContainer:Element? {get}
}
extension Containable3{
    var width:CGFloat {return maskSize.width}
    var height:CGFloat {return maskSize.height}
}
