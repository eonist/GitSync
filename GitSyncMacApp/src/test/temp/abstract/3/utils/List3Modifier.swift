
import Foundation
@testable import Utils

class ListModifier3 {
    /**
     * Selects the first item that has PARAM title as its title
     */
    static func select(_ list: Listable3, _ title:String) {
        let index:Int = list.dp.getItemIndex(list.dataProvider.getItem(title)!)
        selectAt(list,index)
    }
    /**
     * Selects an item in the itemContainer
     */
    static func selectAt(_ list:Listable3, _ index:Int) {
        let selectable:ISelectable = list.lableContainer!.subviews[index] as! ISelectable
        if(!selectable.getSelected()) {selectable.setSelected(true)}
        SelectModifier.unSelectAllExcept(selectable, list.lableContainer!)
    }
}
