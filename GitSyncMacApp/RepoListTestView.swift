import Cocoa
@testable import Utils
@testable import Element
@testable import GitSyncMac

//Continue here: 
    //1. Draw prompt windows for GitSync, Unified, easy to use.
    //2. Implement promt windows for TreeListRightCLick rename and new file and folder and delete
    //3. A templating system for promts?

class RepoListTestView:TitleView{
    var treeList:TreeList?
    var rightClickItemIdx:[Int]?
    var clipBoard:XML?
    
    override init(_ width:CGFloat, _ height:CGFloat, _ parent:IElement? = nil, _ id:String? = "") {
        //self.title = "Resolve merge conflict:"//Title: Resolve sync conflict:
        super.init(width, height, parent, "listTransitionTestView")
    }
    override func resolveSkin() {
        Swift.print("RepoListTestView.resolveSkin()")
        super.resolveSkin()
        Swift.print(ElementParser.stackString(self))
        createGUI()
    }
    func createGUI(){
        let xml:XML = FileParser.xml("~/Desktop/assets/xml/treelist.xml".tildePath)
        treeList = addSubView(SliderTreeList(140, 192, 24, Node(xml),self))
        treeList!.event = onTreeListEvent//add event listener
        
        Swift.print("selected: " + "\(TreeListParser.selected(treeList!))")
        Swift.print("selectedIndex: " + "\(TreeListParser.selectedIndex(treeList!))")//Output:  [2,2,0]
        Swift.print("selected Title: " + "\(XMLParser.attributesAt(treeList!.node.xml, TreeListParser.selectedIndex(treeList!))!["title"])")//Output: Oregano
        TreeListModifier.unSelectAll(treeList!)
        
        TreeListModifier.selectAt(treeList!, [2])
        TreeListModifier.collapseAt(treeList!, [])//closes the treeList
        TreeListModifier.explodeAt(treeList!,[])//opens the treeList
        
        _ = treeList!.node.removeAt([1])
        treeList!.node.addAt([1], "<item title=\"Fish\"/>".xml)/*new*/
    }
    func onTreeListEvent(event:Event) {//adds local event handler
        //Swift.print("event: " + "\(event)")
        if(event.type == SelectEvent.select && event.immediate === treeList){
            Swift.print("event.origin: " + "\(event.origin)")
            let selectedIndex:Array = TreeListParser.selectedIndex(treeList!)
            Swift.print("selectedIndex: " + "\(selectedIndex)")
            //print("_scrollTreeList.database.xml.toXMLString(): " + _scrollTreeList.database.xml.toXMLString());
            let selectedXML:XML = XMLParser.childAt(treeList!.node.xml, selectedIndex)!
            //print("selectedXML: " + selectedXML);
            Swift.print("selectedXML.toXMLString():")
            Swift.print(selectedXML)//EXAMPLE output: <item title="Ginger"></item>
        }else if(event.type == ButtonEvent.rightMouseDown){
            rightClickItemIdx = TreeListParser.index(treeList!, event.origin as! NSView)
            Swift.print("RightMouseDown() rightClickItemIdx: " + "\(rightClickItemIdx)")
            popUpMenu((event as! ButtonEvent).event!)
        }
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

/**
 * Right click Context menu methods
 */
extension RepoListTestView{
    /**
     * TODO: A bug is that when you add a folder and its the last item then the list isnt resized
     */
    func newFolder(sender:AnyObject) {
        Swift.print("newFolder")
        let idx = rightClickItemIdx!
        let a:String = "<item title=\"New folder\" isOpen=\"false\" hasChildren=\"true\"></item>"
        treeList!.node.addAt(newIdx(idx), a.xml)//"<item title=\"New folder\"/>"
        Swift.print("Promt folder name popup")
    }
    /**
     * Returns a new idx
     * NOTE: isFolder -> add within, is not folder -> add bellow
     */
    func newIdx(_ idx:[Int]) -> [Int] {
        var idx = idx
        let child:XML = XMLParser.childAt(treeList!.node.xml, idx)!
        let itemData = TreeListUtils.itemData(child)
        if(itemData.hasChildren){//isFolder, add within
            idx += [0]
        }else{//is not folder, add bellow
            idx[idx.count-1] = idx.last! + 1
        }
        return idx
    }
    func newRepo(sender:AnyObject) {
        Swift.print("newRepo")
        let idx = rightClickItemIdx!
        Swift.print("idx: " + "\(idx)")
        treeList!.node.addAt(newIdx(idx), "<item title=\"New repo\"/>".xml)
        Swift.print("Promt repo name popup")
    }
    func rename(sender: AnyObject) {
        Swift.print("rename")
        Swift.print("Promt rename popup")
    }
    func cut(sender: AnyObject) {
        Swift.print("cut")
        let idx = rightClickItemIdx!
        clipBoard = treeList!.node.removeAt(idx)
    }
    func paste(sender: AnyObject) {
        Swift.print("paste")
        if(clipBoard != nil){
            //"<item title=\"Fish\"/>".xml
            let idx = rightClickItemIdx!
            treeList!.node.addAt(newIdx(idx), clipBoard!)
        }
    }
    func delete(sender: AnyObject) {
        Swift.print("delete")
        let idx = rightClickItemIdx!
        _ = treeList!.node.removeAt(idx)
    }
    func popUpMenu(_ event:NSEvent) {
        Swift.print("popUpMenu: " + "\(popUpMenu)" )
        let menu = NSMenu(title: "Contextual menu")
        let menuItems:[(title:String,selector:Foundation.Selector)] = [("New folder", #selector(newFolder)),("New repo", #selector(newRepo)),("Rename", #selector(rename)),("Cut", #selector(cut)),("Paste", #selector(paste)),("Delete", #selector(delete))]
        menuItems.forEach{
            let menuItem = NSMenuItem(title: $0.title, action: $0.selector, keyEquivalent: "")
            menu.addItem(menuItem)
        }
        NSMenu.popUpContextMenu(menu, with: event, for: self)
    }

}
