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
        
    }
}

/**
 * Add,Remove,Edit,Cut,Paste
 */
class TopBar:Element{
    var addButton:Button?
    var removeButton:Button?
    var editButton:Button?
    override func resolveSkin() {
        Swift.print("TopBar.resolveSkin()")
        super.resolveSkin()
        addButton = addSubView(Button(NaN,NaN,self,"add"))
        removeButton = addSubView(Button(NaN,NaN,self,"remove"))
        editButton = addSubView(Button(NaN,NaN,self,"edit"))
    }
}