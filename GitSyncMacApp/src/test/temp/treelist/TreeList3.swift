import Foundation
@testable import Element
@testable import Utils

class TreeList3:FastList3{
    override func onListItemSelected(_ selectEvent:SelectEvent) {
        
        if let selectable:ISelectable = selectEvent.origin as? ISelectable{
            Swift.print("selectable: " + "\(selectable)")
            Swift.print("selectable.selected: " + "\(selectable.getSelected())")
            if(selectable.selected){
                    Swift.print("selected 🎉")
            }else{
                Swift.print("already selected 🚫")
            }
            
        }else{
            
        }
        super.onListItemSelected(selectEvent)
    }
}
