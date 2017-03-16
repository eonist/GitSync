import Foundation
@testable import Element
@testable import Utils

protocol Containable2:class {//TODO: RENAME TO displaceable
    var maskFrame:CGFloat{get}//used to represent the maskHeight aka the visible part.
    var itemSize:CGSize{get}//item of one item, used to calculate interval
    var itemsHeight:CGFloat{get}//total height of the items
    
    var contentContainer:Element? {get}
    //func setProgress(_ progress:CGFloat)
}
