import Foundation
@testable import Element
@testable import Utils

class TreeList3:FastList3{
    override func onListItemUpInside(_ buttonEvent:ButtonEvent) {
        Swift.print("works")
    }
}
