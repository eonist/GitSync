import Foundation
@testable import Element

protocol GraphAreaKind {
    //    typealias ItemAt = (Int)->Int?//add this later
    var points:[CGPoint] {get set}
    var graphDots:[Element] {get set}
    var graphLine:GraphLine {get set}
    func item(at:Int) -> Int?
    var count:Int {get}
}

