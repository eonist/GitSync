import Foundation
@testable import Utils
@testable import Element

class FastList3Modifier {
    /**
     * Sets selectedIndex in fastList and makes the appropriate UI changes to the visibleItems
     * PARAM: index: dataProvider index
     * NOTE: Does not unselect prev selected. Implement this else where?
     * IMPORTANT: ⚠️️ Only selects if it's not already selected. or unselects if its selected
     */
    static func select(_ list:FastListable3, _ index:Int, _ isSelected:Bool = true){
        Swift.print("isSelected: " + "\(isSelected)")
        list.selectedIdx = index/*set the cur selectedIdx in fastList*/
        if let match = list.pool.first(where:{$0.idx == index}){//was-> for (i,_) in list.visibleItems.enumerate(){
            Swift.print("match: " + "\(match)")
            if let selectable = match as? ISelectable {
                Swift.print("selectable: " + "\(selectable)")
                if selectable.getSelected() != isSelected{
                    Swift.print("inside")
                    selectable.setSelected(isSelected)
                }
            }
           
        }
    }
}
