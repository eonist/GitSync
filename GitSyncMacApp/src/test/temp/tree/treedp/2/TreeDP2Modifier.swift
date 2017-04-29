import Foundation
@testable import Utils

class TreeDP2Modifier {
    /**
     * NOTE: after this method is called, send event to FastList UI Component, the times were added
     */
    static func open(_ dp:TreeDP2, _ idx2d:Int){
        let idx3d:[Int] = dp.hashList[idx2d]
        //Swift.print("at: " + "\(at)")
        //Swift.print("dp.hashList.dict: " + "\(dp.hashList.dict.sortedByValue)")
        //Swift.print("idx3d: " + "\(idx3d)")
        dp.tree.setProp(idx3d,("isOpen","true"))//updates tree
        let count:Int = HashList2Modifier.addDescendants(&dp.hashList, idx2d, dp.tree)//adds items to HashList (via HashListModifier.addDescendants)
        //Swift.print("dp.hashList: " + "\(dp.hashList)")
        //TreeDP2Parser.values(dp, [], "title").forEach{Swift.print("title: " + "\($0)")}
        dp.onEvent(DataProviderEvent(DataProviderEvent.add, idx2d, idx2d+count, dp))
    }
    /**
     * NOTE: after this method is called, send event to FastList UI component, that items were removed
     */
    static func close(_ dp:TreeDP2, _ idx2d:Int){
        //Swift.print("at: " + "\(at)")
        let idx3d:[Int] = dp.hashList[idx2d]
        //Swift.print("idx3d: " + "\(idx3d)")
        let count:Int = HashList2Modifier.removeDescendants(&dp.hashList, idx2d, dp.tree)//remove items from HashList (via HashListModifier.removeDescendants)
        dp.tree.setProp(idx3d,("isOpen","false"))//update tree
        //Swift.print("dp.hashList: " + "\(dp.hashList)")
        //TreeDP2Parser.values(dp, [], "title").forEach{Swift.print("title: " + "\($0)")}
        dp.onEvent(DataProviderEvent(DataProviderEvent.remove, idx2d, idx2d+count, dp))
    }
}
