import Foundation

class RepoView:Element {
    var topBar:TopBar?
    var list:List?
    override func resolveSkin() {
        Swift.print("RepoView.resolveSkin()")
        super.resolveSkin()
        
        topBar = addSubView(TopBar(width-24,36,self))
        
        let xml = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)//~/Desktop/repo2.xml
        let dp:DataProvider = DataProvider(xml)
        list = addSubView(List(width, height-24, NaN, dp,self))
        list!.selectAt(0)
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