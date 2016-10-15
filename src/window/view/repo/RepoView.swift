import Foundation

class RepoView:Element {
    var topBar:TopBar?
    var treeList:TreeList?
    override func resolveSkin() {
        Swift.print("RepoView.resolveSkin()")
        super.resolveSkin()
        
        topBar = addSubView(TopBar(width-24,36,self))
        
        let xml:NSXMLElement = FileParser.xml("~/Desktop/repo2.xml".tildePath)
        treeList = addSubView(TreeList(width, height-24, NaN, Node(xml), self))
        
        
        let listCard:Card = container.addSubView(Card(NaN, NaN, "List: ", container, "listCard"))
        let xml = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)
        let dp:DataProvider = DataProvider(xml)
        let list:List = listCard.addSubView(List(140, 73, NaN, dp,listCard))
        list.selectAt(1)
    }
}

/**
 * Add,Remove,Edit,Cut,Paste
 */
class TopBar:Element{
    var editButton:Button?
    var removeButton:Button?
    var addButton:Button?
    
    override func resolveSkin() {
        Swift.print("TopBar.resolveSkin()")
        super.resolveSkin()
        editButton = addSubView(Button(NaN,NaN,self,"edit"))
        removeButton = addSubView(Button(NaN,NaN,self,"remove"))
        addButton = addSubView(Button(NaN,NaN,self,"add"))
        
        
    }
}