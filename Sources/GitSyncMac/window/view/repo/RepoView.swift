import Cocoa
@testable import Utils
@testable import Element
/**
 * - TODO: ⚠️️ Should remember previous selected item between transitions
 * - TODO: use singleton instead of the bellow ⚠️️
 */
class RepoView: Element, Closable {
    static var selectedListItemIndex: [Int] = []
    static var _treeDP: TreeDP? = nil
    static var treeDP: TreeDP {//TODO: ⚠️️ all this may not be needed, test if you need to invalidate etc.
        guard let treeDP = _treeDP else{
            _treeDP = TreeDP(Config.Bundle.repo.tildePath)/*Doesn't exists return new DP*/
            return _treeDP!
        };return treeDP/*Already exist, return old dp*/
    }
    lazy var treeList: TreeList5 = createTreeList()
    lazy var contextMenu: RepoContextMenu = { return RepoContextMenu(self.treeList) }()
    override func resolveSkin() {
        super.resolveSkin()//self.skin = SkinResolver.skin(self)//
        _ = treeList
        _ = contextMenu
    }
    override func onEvent(_ event: Event) {
        if event.assert(ListEvent.select, treeList) {//if(event.type == SelectEvent.select && event.immediate === treeList){}
            //Swift.print("RepoView.onTreeListEvent() selectedIndex: " + "\(treeList.selectedIdx3d)")
            onTreeListSelect()
        }else if event.type == ButtonEvent.rightMouseDown {
            contextMenu.rightClickItemIdx = TreeList3Parser.index(treeList, event.origin as! NSView)
            //Swift.print("RightMouseDown() rightClickItemIdx: " + "\(contextMenu.rightClickItemIdx)")
            NSMenu.popUpContextMenu(contextMenu, with:(event as! ButtonEvent).event!, for: self)
        }else if event.assert(TreeListEvent.change, event.immediate) {
            RepoView._treeDP = treeList.treeDP/*copy the edited treeList.treeDP to the static ref, this is a quick win, but should be refactored later, maybe on page transition etc*/
        }
    }
}
