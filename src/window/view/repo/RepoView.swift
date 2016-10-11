import Foundation

class RepoView:Element {
    private var topBar:TopBar?
    var treeList:TreeList?
    override func resolveSkin() {
        Swift.print("RepoView.resolveSkin()")
        super.resolveSkin()
        
        topBar = addSubView(TopBar(width-24,24,self))
        
        //let xml:NSXMLElement = FileParser.xml("~/Desktop/repo2.xml".tildePath)
        //treeList = addSubView(TreeList(width, height-24, NaN, Node(xml), self))
        
    }
}

/**
 * Add,Remove,Edit,Cut,Paste
 */
private class TopBar:Element{
    var removeButton:TextButton?
    var addButton:TextButton?
    override func resolveSkin() {
        Swift.print("TopBar.resolveSkin()")
        super.resolveSkin()
        addButton = addSubView(TextButton(NaN,24,"Add",self,"add"))
        removeButton = addSubView(TextButton(NaN,24,"Remove",self,"remove"))
        
        /*
        StyleManager.addStyle("TopBar Button#add{float:left;clear:none;line:none;corner-radius:0px;line-thickness:0px;}")//fill:green;
        StyleManager.addStyle("TopBar Button#add{fill:white,~/Desktop/gitsync/assets/svg/add.svg grey8;}")
        StyleManager.addStyle("TopBar Button#add{width:24px,16px;height:24px,16px;margin:0px,4px;}")
        addButton = addSubView(Button(24,24,self,"add"))
        */
        
    }
}