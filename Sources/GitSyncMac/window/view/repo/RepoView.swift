import Cocoa
@testable import Utils
@testable import Element
//@testable import GitSyncMac
/**
 * TODO: should remember previous selected item between transitions
 */
class RepoView:Element {
    static var repoList:String = "~/Desktop/repo2.xml"//"~/Desktop/assets/xml/list.xml"
    static var selectedListItemIndex:[Int] = []
    static var node:Node?
    var treeList:TreeList?// {return RepoView.list}
    var contextMenu:ContextMenu?
    
    override func resolveSkin() {
        Swift.print("RepoView.resolveSkin()")
        self.skin = SkinResolver.skin(self)//super.resolveSkin()//
        
        if(RepoView.node == nil){/*loads 1 time*/
            let xml = FileParser.xml(RepoView.repoList.tildePath)//
            RepoView.node = Node(xml)
        }
        treeList = addSubView(SliderTreeList(width, height-24, 24, RepoView.node!,self))
        contextMenu = ContextMenu(treeList!)
        if(RepoView.selectedListItemIndex.count > 0){TreeListModifier.selectAt(treeList!, RepoView.selectedListItemIndex)}
    }
    override func onEvent(_ event:Event) {
        if(event.type == SelectEvent.select && event.immediate === treeList){
            //Swift.print("event.origin: " + "\(event.origin)")
            let selectedIndex:Array = TreeListParser.selectedIndex(treeList!)
            Swift.print("RepoView.onTreeListEvent() selectedIndex: " + "\(selectedIndex)")
            //print("_scrollTreeList.database.xml.toXMLString(): " + _scrollTreeList.database.xml.toXMLString());
            //Swift.print("selectedXML.toXMLString():")
            //Swift.print(selectedXML)//EXAMPLE output: <item title="Ginger"></item>
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
            repoItem = RepoUtils.emptyRepoItem
            repoItem.title = repoItemDict["title"]!
        }else{
            repoItem = RepoUtils.repoItem(repoItemDict)
        }
        (Navigation.currentView as! RepoDetailView).setRepoData(repoItem)//updates the UI elements with the selected repo data
    }
}
/**
 * Right click context menu
 */
class ContextMenu:NSMenu{
    var rightClickItemIdx:[Int]?
    var clipBoard:XML?
    var treeList:TreeList
    init(_ treeList:TreeList) {
        self.treeList = treeList//Element - mac
        super.init(title:"Contextual menu")
        var menuItems:[(title:String,selector:Foundation.Selector)] = []
        menuItems.append(("New folder", #selector(newFolder)))
        menuItems.append(("New repo", #selector(newRepo)))
        menuItems.append(("Copy", #selector(duplicate)))
        menuItems.append(("Copy", #selector(doCopy)))
        menuItems.append(("Cut", #selector(cut)))
        menuItems.append(("Paste", #selector(paste)))
        menuItems.append(("Delete", #selector(delete)))
        menuItems.append(("Move up", #selector(moveUp)))
        menuItems.append(("Move down", #selector(moveDown)))
        menuItems.append(("Move top", #selector(moveToTop)))
        menuItems.append(("Move bottom", #selector(moveToBottom)))
        menuItems.append(("Open in finder", #selector(openInFinder)))
        menuItems.append(("Open URL", #selector(openURL)))
        //continue here: add Open in github
        menuItems.forEach{
            let menuItem = NSMenuItem(title: $0.title, action: $0.selector, keyEquivalent: "")
            self.addItem(menuItem)
            menuItem.target = self
        }
        self.insertItem(NSMenuItem.separator(), at: 6)/*Separator*/
        self.insertItem(NSMenuItem.separator(), at: 11)/*Separator*/
    }
    required init(coder decoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
/**
 * Right click Context menu methods
 */
extension ContextMenu{
    /**
     * Returns a new idx
     * NOTE: isFolder -> add within, is not folder -> add bellow
     */
    func newIdx(_ idx:[Int]) -> [Int] {
        var idx = idx
        let itemData:ItemData = TreeListUtils.itemData(treeList.node.xml, idx)
        if(itemData.hasChildren){//isFolder, add within
            idx += [0]
        }else{//is not folder, add bellow
            idx[idx.count-1] = idx.last! + 1
        }
        return idx
    }
    /**
     * TODO: A bug is that when you add a folder and its the last item then the list isnt resized
     */
    func newFolder(sender:AnyObject) {
        Swift.print("newFolder")
        let idx = rightClickItemIdx!
        let a:String = "<item title=\"New folder\" isOpen=\"false\" hasChildren=\"true\"></item>"
        treeList.node.addAt(newIdx(idx), a.xml)//"<item title=\"New folder\"/>"
        Swift.print("Promt folder name popup")
    }
    
    func newRepo(sender:AnyObject) {
        Swift.print("newRepo")
        let idx = rightClickItemIdx!
        Swift.print("idx: " + "\(idx)")
        let xml:XML = ["title":"New repo","local-path":"~/Desktop/test","remote-path":"https://github.com/eonist/test.git","interval":"30","keychain-item-name":"eonist","branch":"master","broadcast":"true","subscribe":"true","auto-sync":"true"].xml
        Swift.print("xml.xmlString: " + "\(xml.xmlString)")
        treeList.node.addAt(newIdx(idx), xml)
        //Swift.print("Promt repo name popup")
    }
    func duplicate(sender: AnyObject) {
        Swift.print("duplicate")
        let idx = rightClickItemIdx!
        Swift.print("idx: " + "\(idx)")
        let xml:XML = treeList.node.xml.childAt(idx)!
        treeList.node.addAt(newIdx(idx), xml.copy() as! XML)
    }
    func doCopy(sender: AnyObject) {
        Swift.print("copy")
        let idx = rightClickItemIdx!
        Swift.print("idx: " + "\(idx)")
        let xml:XML = treeList.node.xml.childAt(idx)!
        clipBoard = xml
        Swift.print("clipBoard: " + "\(clipBoard)")
    }
    func cut(sender: AnyObject) {
        Swift.print("cut")
        let idx = rightClickItemIdx!
        Swift.print("idx: " + "\(idx)")
        clipBoard = treeList.node.removeAt(idx)
        Swift.print("clipBoard: " + "\(clipBoard)")
    }
    func paste(sender: AnyObject) {
        Swift.print("paste")
        if(clipBoard != nil){
            //"<item title=\"Fish\"/>".xml
            Swift.print("clipBoard: " + "\(self.clipBoard)")
            let idx = rightClickItemIdx!
            treeList.node.addAt(newIdx(idx), clipBoard!.copy() as! XML)
        }
    }
    func delete(sender: AnyObject) {
        Swift.print("delete")
        let idx = rightClickItemIdx!
        _ = treeList.node.removeAt(idx)
    }
    /*move up down top bottom.*/
    func moveUp(sender: AnyObject){
        let idx = rightClickItemIdx!
        _ = TreeListModifier.moveUp(treeList, idx)
    }
    func moveDown(sender: AnyObject){
        let idx = rightClickItemIdx!
        _ = TreeListModifier.moveDown(treeList, idx)
    }
    func moveToTop(sender: AnyObject){
        let idx = rightClickItemIdx!
        _ = TreeListModifier.moveToTop(treeList, idx)
    }
    func moveToBottom(sender: AnyObject){
        let idx = rightClickItemIdx!
        _ = TreeListModifier.moveToBottom(treeList, idx)
    }
    func openInFinder(sender: AnyObject){
        let idx = rightClickItemIdx!
        let itemData:ItemData = TreeListUtils.itemData(treeList.node.xml, idx)
        if(!itemData.hasChildren){//only repos can be opened in finder
            let repoItem = RepoUtils.repoItem(treeList.node.xml, idx)
            if(FileAsserter.exists(repoItem.localPath.tildePath)){//make sure local-path exists
                Swift.print("repoItem.localPath: " + "\(repoItem.localPath)")
                FileUtils.showFileInFinder(repoItem.localPath)
            }
        }
    }
    func openURL(sender:AnyObject){
        let idx = rightClickItemIdx!
        let itemData:ItemData = TreeListUtils.itemData(treeList.node.xml, idx)
        if(!itemData.hasChildren){//only repos can be opened in finder
            let repoItem = RepoUtils.repoItem(treeList.node.xml, idx)
            NetworkUtils.openURLInDefaultBrowser(repoItem.remotePath)
        }  
    }
}
