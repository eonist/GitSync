import Cocoa
@testable import Utils
@testable import Element
@testable import GitSyncMac

class RepoListTestView:TitleView{
    var treeList:TreeList?
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
        if(event.type == SelectEvent.select && event.immediate === treeList){
            Swift.print("event.origin: " + "\(event.origin)")
            
            let selectedIndex:Array = TreeListParser.selectedIndex(treeList!)
            Swift.print("selectedIndex: " + "\(selectedIndex)")
            //print("_scrollTreeList.database.xml.toXMLString(): " + _scrollTreeList.database.xml.toXMLString());
            let selectedXML:XML = XMLParser.childAt(treeList!.node.xml, selectedIndex)!
            //print("selectedXML: " + selectedXML);
            Swift.print("selectedXML.toXMLString():")
            Swift.print(selectedXML)//EXAMPLE output: <item title="Ginger"></item>
        }
    }
    override func mouseUpInside(_ event:MouseEvent) {
        Swift.print("mouseUpInside: " + "\(event)")
        super.mouseUpInside(event)
    }
    override func rightMouseUp(with event: NSEvent) {
        Swift.print("rightMouseUp: " + "\(event)")
        super.rightMouseUp(with:event)
        popUpMenu(event)
    }
    
    func action1(sender: AnyObject) {
        Swift.print("Urk, action 1")
    }
    
    func action2(sender: AnyObject) {
        Swift.print("Urk, action 2")
    }
    
    func popUpMenu(_ event:NSEvent) {
        Swift.print("popUpMenu: " + "\(popUpMenu)" )
        let theMenu = NSMenu(title: "Contextual menu")
        let action1MenuItem = NSMenuItem(title: "Action 1", action: #selector(action1), keyEquivalent: "")
        theMenu.addItem(action1MenuItem)
        //theMenu.addItem(withTitle: "Action 1", action: Selector(("action1:")), keyEquivalent: "")
        theMenu.addItem(withTitle: "Action 2", action: Selector(("action2:")), keyEquivalent: "")
        
        
        
        NSMenu.popUpContextMenu(theMenu, with: event, for: self)
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
