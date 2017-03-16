import Foundation
@testable import Element
@testable import Utils

protocol Containable2:class {
    var maskSize:CGSize{get}
    var contentSize:CGSize{get}
    var itemSize:CGSize{get}
    var contentContainer:Element? {get}
}
