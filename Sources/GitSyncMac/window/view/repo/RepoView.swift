import Cocoa
@testable import Utils
@testable import Element
//@testable import GitSyncMac
/**
 * TODO: should remember previous selected item between transitions
 */
class RepoView:Element {
    static var repoList:String = "~/Desktop/repo2.xml"/*📝*///"~/Desktop/assets/xml/list.xml"
    static var selectedListItemIndex:[Int] = []
    static var node:Node {/*loads 1 time*/
        let xml:XML = FileParser.xml(RepoView.repoList.tildePath)
        return Node(xml)
    }
    var treeList:TreeList?// {return RepoView.list}
    var contextMenu:RepoContextMenu?
    
    override func resolveSkin() {
        //Swift.print("RepoView.resolveSkin()")
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        treeList = addSubView(SliderTreeList(width, height-24, 24, RepoView.node,self))
        contextMenu = RepoContextMenu(treeList!)
        if(RepoView.selectedListItemIndex.count > 0){TreeListModifier.selectAt(treeList!, RepoView.selectedListItemIndex)}
    }
    override func onEvent(_ event:Event) {
        if(event.type == SelectEvent.select && event.immediate === treeList){
            let selectedIndex:Array = TreeListParser.selectedIndex(treeList!)
            Swift.print("RepoView.onTreeListEvent() selectedIndex: " + "\(selectedIndex)")
            //print("_scrollTreeList.database.xml.toXMLString(): " + _scrollTreeList.database.xml.toXMLString());
            onTreeListSelect()
        }else if(event.type == ButtonEvent.rightMouseDown){
            contextMenu!.rightClickItemIdx = TreeListParser.index(treeList!, event.origin as! NSView)
            Swift.print("RightMouseDown() rightClickItemIdx: " + "\(contextMenu!.rightClickItemIdx)")
            NSMenu.popUpContextMenu(contextMenu!, with: (event as! ButtonEvent).event!, for: self)
        }
    }
}
extension RepoView{
    func onTreeListSelect(){
        Swift.print("RepoView.onTreeListSelect()")
        //Sounds.play?.play()
        Navigation.setView("\(RepoDetailView.self)")
        let selectedIndex:Array = TreeListParser.selectedIndex(treeList!)
        RepoView.selectedListItemIndex = selectedIndex
        //TODO: Use the RepoItem on the bellow line see AutoSync class for implementation
        let repoItemDict:[String:String] = NodeParser.dataAt(treeList!.node, selectedIndex)
        var repoItem:RepoItem
        if(repoItemDict["hasChildren"] != nil || repoItemDict["isOpen"] != nil){/*Support for folders*/
            repoItem = RepoItem()
            repoItem.title = repoItemDict[RepoItemType.title]!
        }else{
            repoItem = RepoUtils.repoItem(repoItemDict)
        }
        (Navigation.currentView as! RepoDetailView).setRepoData(repoItem)//updates the UI elements with the selected repo data
    }
}
