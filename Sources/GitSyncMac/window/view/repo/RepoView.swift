import Cocoa
@testable import Utils
@testable import Element
/**
 * TODO: should remember previous selected item between transitions
 * TODO: ⚠️️ Refactor this class so that it doesnt force unwrap
 */
class RepoView:Element {
    static var repoListFilePath:String = "~/Desktop/repo2.xml"/*📝*///"~/Desktop/assets/xml/list.xml"
    static var selectedListItemIndex:[Int] = []
    static var _treeDP:TreeDP? = nil
    static var treeDP:TreeDP {
        guard let treeDP = _treeDP else{
            _treeDP = TreeDP(RepoView.repoListFilePath.tildePath)/*doesnt exists return new DP*/
            return _treeDP!
        };return treeDP/*already exist, return old dp*/
    }
    lazy var treeList:TreeList3 = {
        //if(RepoView.selectedListItemIndex.count > 0){TreeListModifier.selectAt(treeList!, RepoView.selectedListItemIndex)}
        return  self.addSubView(TreeList3(self.width, self.height-60, CGSize(24,24), RepoView.treeDP, self))
    }()// {return RepoView.list}
    lazy var contextMenu:RepoContextMenu = {
        return RepoContextMenu(self.treeList)
    }()
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        _ = treeList
        _ = contextMenu
    }
    override func onEvent(_ event:Event) {
        if(event.type == ListEvent.select && event.immediate === treeList){//if(event.type == SelectEvent.select && event.immediate === treeList){}
            Swift.print("RepoView.onTreeListEvent() selectedIndex: " + "\(treeList.selectedIdx3d)")
            //print("_scrollTreeList.database.xml.toXMLString(): " + _scrollTreeList.database.xml.toXMLString());
            onTreeListSelect()
        }else if(event.type == ButtonEvent.rightMouseDown){
            contextMenu.rightClickItemIdx = TreeList3Parser.index(treeList, event.origin as! NSView)
            Swift.print("RightMouseDown() rightClickItemIdx: " + "\(contextMenu.rightClickItemIdx)")
            NSMenu.popUpContextMenu(contextMenu, with: (event as! ButtonEvent).event!, for: self)
        }
    }
}
extension RepoView{
    func onTreeListSelect(){
        //Sounds.play?.play()
        let selectedIndex:[Int] = treeList.selectedIdx3d!
        RepoView.selectedListItemIndex = selectedIndex
        //TODO: Use the RepoItem on the bellow line see AutoSync class for implementation
        if let repoItemDict:[String:String] = treeList.tree[selectedIndex]?.props{//NodeParser.dataAt(treeList!.node, selectedIndex)
            var repoItem:RepoItem
            if(repoItemDict["hasChildren"] != nil || repoItemDict["isOpen"] != nil){/*Support for folders*/
                repoItem = RepoItem()
                if(repoItemDict.hasKey(RepoItemType.title)){repoItem.title = repoItemDict[RepoItemType.title]!}
                if(repoItemDict.hasKey(RepoItemType.active)){repoItem.active = repoItemDict[RepoItemType.active]!.bool}
            }else{
                repoItem = RepoUtils.repoItem(repoItemDict)
            }
            Navigation.setView(.repoDetail(repoItem))//updates the UI elements with the selected repo data
        }
    }
}
