import Foundation
@testable import Utils
@testable import Element
/**
 * TODO: should remember previous selected item between transitions
 */
class RepoView:Element {
    static var repoList:String = "~/Desktop/assets/xml/list.xml"
    var topBar:TopBar?
    static var dp:DataProvider?
    //var list:List?
    var treeList:TreeList?
    static var selectedListItemIndex:Int = -1
    override func resolveSkin() {
        Swift.print("RepoView.resolveSkin()")
        
        self.skin = SkinResolver.skin(self)//super.resolveSkin()//
        topBar = addSubView(TopBar(width-12,44,self))
        
        if(RepoView.dp == nil){/*loads 1 time*/
            let xml = FileParser.xml(RepoView.repoList.tildePath)//~/Desktop/repo2.xml
            RepoView.dp = DataProvider(xml)
        }
        let xml:XML = FileParser.xml("~/Desktop/assets/xml/treelist.xml".tildePath)
        treeList = addSubView(SliderTreeList(140, 192, 24, Node(xml),self))
        treeList!.event = onTreeListEvent//add event listener
        //list = addSubView(List(width, height-24, NaN, RepoView.dp,self))
        //if(RepoView.selectedListItemIndex != -1){list!.selectAt(RepoView.selectedListItemIndex)}
    }
    func onTreeListEvent(event:Event) {//adds local event handler
        //Swift.print("event: " + "\(event)")
        if(event.type == SelectEvent.select && event.immediate === treeList){
            //Swift.print("event.origin: " + "\(event.origin)")
            let selectedIndex:Array = TreeListParser.selectedIndex(treeList!)
            Swift.print("RepoView.onTreeListEvent() selectedIndex: " + "\(selectedIndex)")
            //print("_scrollTreeList.database.xml.toXMLString(): " + _scrollTreeList.database.xml.toXMLString());
            let selectedXML:XML = XMLParser.childAt(treeList!.node.xml, selectedIndex)!
            //print("selectedXML: " + selectedXML);
            //Swift.print("selectedXML.toXMLString():")
            //Swift.print(selectedXML)//EXAMPLE output: <item title="Ginger"></item>
        }
    }
    /*
    func onAddButtonClick(){
        Swift.print("addButton.click")
        Sounds.play?.play()
        list!.dataProvider.addItemAt(["title":"New repo","local-path":"~/Desktop/","remote-path":"https://github.com/userName/repoName.git","interval":"0","keychain-item-name":"","branch":"master","broadcast":"false","subscribe":"true","auto-sync":"false"], 0)
        ListModifier.selectAt(list!, 0)
        let repoItem:Dictionary<String,String> = list!.dataProvider.getItemAt(list!.selectedIndex)!
        Navigation.setView("\(RepoDetailView.self)")
        (Navigation.currentView as! RepoDetailView).setRepoData(repoItem)//updates the UI elements with the selected repo data
        //list!.onEvent(ListEvent(ListEvent.select,0,list!))
    }
 
    func onBackButtonClick(){
        Swift.print("onBackButtonClick()")
        Navigation.setView(MenuView.commits)
    }
    func onListSelect(){
        Sounds.play?.play()
        Navigation.setView("\(RepoDetailView.self)")
        RepoView.selectedListItemIndex = list!.selectedIndex
        let repoItem:Dictionary<String,String> = list!.dataProvider.getItemAt(RepoView.selectedListItemIndex)!
        (Navigation.currentView as! RepoDetailView).setRepoData(repoItem)//updates the UI elements with the selected repo data
    }
     */
    override func onEvent(_ event:Event) {
        if(event.type == ButtonEvent.upInside && event.origin === topBar!.addButton){onAddButtonClick()}
        //else if(event.type == ButtonEvent.upInside && event.origin === topBar!.backButton){onBackButtonClick()}
        else if(event.type == ListEvent.select){onListSelect()}
        //else if(event.type == SelectEvent.select && event.immediate === list){super.onEvent(event)}//forward this event to the parent
    }
}

/**
 * Add,Remove,Edit,Cut,Paste
 */
class TopBar:Element{
    //var backButton:Button?
    //var editButton:Button?
    //var removeButton:Button?
    var addButton:Button?
    override func resolveSkin() {
        Swift.print("TopBar.resolveSkin()")
        self.skin = SkinResolver.skin(self)//super.resolveSkin()//
        //backButton = addSubView(Button(NaN,NaN,self,"back"))
        addButton = addSubView(Button(NaN,NaN,self,"add"))
    }
}
