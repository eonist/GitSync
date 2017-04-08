import Cocoa
@testable import Utils
@testable import Element

protocol Containable3{
    var maskSize:CGSize{get}
    var contentSize:CGSize{get}
    var itemSize:CGSize{get}
    var contentContainer:Element? {get}
}
