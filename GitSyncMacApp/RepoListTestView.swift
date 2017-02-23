import Cocoa
@testable import Utils
@testable import Element
@testable import GitSyncMac

class RepoListTestView:TitleView{
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
        let treeList = card.addSubView(SliderTreeList(140, 192, 24, Node(xml),card))
        _ = treeList
        func onTreeListEvent(event:Event) {//adds local event handler
            if(event.type == SelectEvent.select && event.immediate === treeList){
                Swift.print("event.origin: " + "\(event.origin)")
                
                let selectedIndex:Array = TreeListParser.selectedIndex(treeList)
                Swift.print("selectedIndex: " + "\(selectedIndex)")
                //print("_scrollTreeList.database.xml.toXMLString(): " + _scrollTreeList.database.xml.toXMLString());
                let selectedXML:XML = XMLParser.childAt(treeList.node.xml, selectedIndex)!
                //print("selectedXML: " + selectedXML);
                Swift.print("selectedXML.toXMLString():")
                Swift.print(selectedXML)//EXAMPLE output: <item title="Ginger"></item>
            }
        }
        treeList.event = onTreeListEvent//add local event listener
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
        theMenu.addItem(withTitle: "Action 1", action: Selector(("action1:")), keyEquivalent: "")
        theMenu.addItem(withTitle: "Action 2", action: Selector(("action2:")), keyEquivalent: "")
        
        for item: AnyObject in theMenu.items {
            if let menuItem = item as? NSMenuItem {
                menuItem.target = self
            }
        }
        
        NSMenu.popUpContextMenu(theMenu, with: event, for: self)
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
