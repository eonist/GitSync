import Foundation

class RepoView:Element {
    var treeList:TreeList?
    override func resolveSkin() {
        Swift.print("RepoView.resolveSkin()")
        super.resolveSkin()
        let xml:NSXMLElement = FileParser.xml("~/Desktop/repo2.xml".tildePath)
        treeList = addSubView(TreeList(width, height-24, NaN, Node(xml), self))
        
        
        
    }
}

//Add,Remove,Edit,Cut,Paste


class TopBar:Element{
    var removeButton:TextButton?
    var addButton:TextButton?
    
    override func resolveSkin() {
        StyleManager.addStyle("TopBar{float:left;clear:left;corner-radius:0px 4px 0px 0px;padding-left:10px;margin-bottom:12px;}")
        super.resolveSkin()
        
        StyleManager.addStyle("TopBar TextButton#add{width:50px;float:left;clear:none;}")
        addButton = addSubView(TextButton("Add",NaN,24,self,"add"))
        
        StyleManager.addStyle("TopBar TextButton#remove{width:66px;float:right;clear:none;}")
        removeButton = addSubView(TextButton("Remove",NaN,24,self,"remove"))
        
        /*
        StyleManager.addStyle("TopBar Button#add{float:left;clear:none;line:none;corner-radius:0px;line-thickness:0px;}")//fill:green;
        StyleManager.addStyle("TopBar Button#add{fill:white,~/Desktop/gitsync/assets/svg/add.svg grey8;}")
        StyleManager.addStyle("TopBar Button#add{width:24px,16px;height:24px,16px;margin:0px,4px;}")
        
        
        addButton = addSubView(Button(24,24,self,"add"))
        */
        
        
        
    }
}