import Foundation
@testable import Utils
@testable import Element

extension RepoItem{
    /**
     * New
     */
    var dict:[String:String] {return ReflectUtils.dictionary(instance:self)}
    /**
     * Creates repoDetailData from tree attribs at idx3d
     * //TODO: ⚠️️ Use the RepoItem on the bellow line see AutoSync class for implementation
     */
    static func repoItem(treeDP:TreeDP,idx3d:[Int]) -> RepoItem {
        if let tree:Tree = treeDP.tree[idx3d], let repoItemDict = tree.props{//NodeParser.dataAt(treeList!.node, selectedIndex)
            var repoItem:RepoItem
            let hasIsOpenAttrib:Bool = TreeAsserter.hasAttribute(RepoView.treeDP.tree, idx3d, "isOpen")
            
//            Swift.print("hasIsOpenAttrib: " + "\(hasIsOpenAttrib)")
            if !tree.children.isEmpty  || hasIsOpenAttrib {/*Support for folders*/
                repoItem = RepoItem()
                if let title:String = repoItemDict[Key.title] {repoItem.title = title}
                if let active:String = repoItemDict[Key.active] {repoItem.active = active.bool}
            }else{
                repoItem = RepoUtils.repoItem(dict:repoItemDict)
            }
            
            return repoItem//RepoDetailData.init(repoItem:repoItem)
        }else{
            fatalError("Unable to derive repoItem from TreeDP")
        }
    }
}
