import Foundation
@testable import Element
@testable import Utils

class TreeList3:FastList3{
    override func onListItemUpInside(_ buttonEvent:ButtonEvent) {
        super.onListItemUpInside(buttonEvent)
        if let selectable:ISelectable = buttonEvent.origin as! ISelectable, selectable.selected{
            Swift.print("already selected 🚫")
        }else{/*not selected*/
            Swift.print("selected 🎉")
        }
    }
}
