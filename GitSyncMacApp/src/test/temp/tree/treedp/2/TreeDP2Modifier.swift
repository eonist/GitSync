import Foundation
@testable import Utils

class TreeDP2Modifier {
    /**
     * NOTE: after this method is called, send event to FastList UI Component, the times were added
     */
    static func open(_ dp:TreeDP2, _ at:Int){
        let idx3d:[Int] = dp.hashList[at]
        Swift.print("at: " + "\(at)")
        //Swift.print("dp.hashList.dict: " + "\(dp.hashList.dict.sortedByValue)")
        Swift.print("idx3d: " + "\(idx3d)")
        dp.tree.setProp(idx3d,("isOpen","true"))//updates tree
        let count:Int = HashList2Modifier.addDescendants(&dp.hashList, at, dp.tree)//adds items to HashList (via HashListModifier.addDescendants)
        Swift.print("dp.hashList: " + "\(dp.hashList)")
        TreeDP2Parser.values(dp, [], "title").forEach{
            Swift.print("title: " + "\($0)")
        }
        dp.onEvent(DataProviderEvent(DataProviderEvent.add, at, at+count, dp))
    }
    /**
     * NOTE: after this method is called, send event to FastList UI component, that items were removed
     */
    static func close(_ dp:TreeDP2, _ at:Int){
        Swift.print("at: " + "\(at)")
        //Swift.print("dp.hashList.dict: " + "\(dp.hashList.dict.sortedByValue)")
        let idx3d:[Int] = dp.hashList[at]
        Swift.print("idx3d: " + "\(idx3d)")
        dp.tree.setProp(idx3d,("isOpen","false"))//update tree
        let count:Int = HashList2Modifier.removeDescendants(&dp.hashList, at, dp.tree)//remove items from HashList (via HashListModifier.removeDescendants)
        Swift.print("dp.hashList: " + "\(dp.hashList)")
        TreeDP2Parser.values(dp, [], "title").forEach{
            Swift.print("title: " + "\($0)")
        }
        dp.onEvent(DataProviderEvent(DataProviderEvent.remove, at, at+count, dp))
    }
}
