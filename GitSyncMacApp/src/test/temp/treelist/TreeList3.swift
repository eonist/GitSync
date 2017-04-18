import Foundation
@testable import Element
@testable import Utils

class TreeList3:FastList3{
    override func onListItemUpInside(_ buttonEvent:ButtonEvent) {
        
        if let selectable:ISelectable = buttonEvent.origin as? ISelectable{
            Swift.print("selectable: " + "\(selectable)")
            Swift.print("selectable.selected: " + "\(selectable.getSelected())")
            if(selectable.selected){
                    Swift.print("selected 🎉")
            }else{
                Swift.print("already selected 🚫")
            }
            
        }else{
            
        }
        super.onListItemUpInside(buttonEvent)
    }
}
