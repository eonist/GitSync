import Cocoa
@testable import Utils
@testable import Element
//@testable import GitSyncMac
/**
 * TODO: should remember previous selected item between transitions
 */
class RepoView:Element {
    static var repoListFilePath:String = "~/Desktop/repo2.xml"/*📝*///"~/Desktop/assets/xml/list.xml"
    static var selectedListItemIndex:[Int] = []
    static var _treeDP:TreeDP? = nil
    static var treeDP:TreeDP {
        guard let treeDP = _treeDP else{
            _treeDP = TreeDP(RepoView.repoListFilePath.tildePath)
            return _treeDP!
        };return treeDP
    }
    
    //Continue here: 
        //Try to test treeList in minimalview again, but with bigger mask and check the performance
    
    var treeList:TreeList3?// {return RepoView.list}
    var contextMenu:RepoContextMenu?
    
    override func resolveSkin() {
        //Swift.print("RepoView.resolveSkin()")
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        //treeList = addSubView(SliderTreeList(width, height-24, 24, RepoView.node,self))
        treeList = addSubView(TreeList3(width, height-24, CGSize(24,24), RepoView.treeDP, self))
        contextMenu = RepoContextMenu(treeList!)
        //if(RepoView.selectedListItemIndex.count > 0){TreeListModifier.selectAt(treeList!, RepoView.selectedListItemIndex)}
    }
    override func onEvent(_ event:Event) {
        if(event.type == SelectEvent.select && event.immediate === treeList){
            Swift.print("RepoView.onTreeListEvent() selectedIndex: " + "\(treeList?.selectedIdx3d)")
            //print("_scrollTreeList.database.xml.toXMLString(): " + _scrollTreeList.database.xml.toXMLString());
            onTreeListSelect()
        }else if(event.type == ButtonEvent.rightMouseDown){
            contextMenu!.rightClickItemIdx = TreeList3Parser.index(treeList!, event.origin as! NSView)
            Swift.print("RightMouseDown() rightClickItemIdx: " + "\(contextMenu!.rightClickItemIdx)")
            NSMenu.popUpContextMenu(contextMenu!, with: (event as! ButtonEvent).event!, for: self)
        }
    }
}
extension RepoView{
    func onTreeListSelect(){
        Swift.print("RepoView.onTreeListSelect()")
        //Sounds.play?.play()
       
        let selectedIndex:[Int] = treeList!.selectedIdx3d!
        RepoView.selectedListItemIndex = selectedIndex
        //TODO: Use the RepoItem on the bellow line see AutoSync class for implementation
        if let repoItemDict:[String:String] = treeList!.treeDP.tree[selectedIndex]?.props{//NodeParser.dataAt(treeList!.node, selectedIndex)
            var repoItem:RepoItem
            if(repoItemDict["hasChildren"] != nil || repoItemDict["isOpen"] != nil){/*Support for folders*/
                repoItem = RepoItem()
                if(repoItemDict.hasKey(RepoItemType.title)){repoItem.title = repoItemDict[RepoItemType.title]!}
                if(repoItemDict.hasKey(RepoItemType.active)){repoItem.active = repoItemDict[RepoItemType.active]!.bool}
            }else{
                repoItem = RepoUtils.repoItem(repoItemDict)
            }
            //(Navigation.currentView as! RepoDetailView).setRepoData(repoItem)//updates the UI elements with the selected repo data
            Navigation.setView(.repoDetail(repoItem))
        }
    }
}
