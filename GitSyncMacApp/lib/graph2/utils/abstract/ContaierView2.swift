import Foundation
@testable import Utils
@testable import Element

class ContaierView2:Containable2 {
    var maskSize:CGSize = CGSize()
    var contentSize:CGSize = CGSize()
    var contentContainer:Element?
    var itemSize:CGSize {fatalError("must be overriden")}//override this for custom value
    var interval:CGFloat{fatalError("must be overriden")}
    var progress:CGFloat{fatalError("must be overriden")}
}
