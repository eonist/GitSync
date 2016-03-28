import Foundation

class RepoView:Element{//rename to RepoListView
    var topBar:TopBar?
    var list:List?
    var nodeList:NodeList?
    override func resolveSkin() {
        //Swift.print("RepoView.resolveSkin()")
        StyleManager.addStyle("RepoView{padding-top:8px;}")//padding-left:6px;padding-right:6px;
        super.resolveSkin()
        topBar = addSubView(TopBar(width-30,24,self))
        
        //let dp:DataProvider = DataProvider()
        //dp.addItems([["title":"brown"],["title":"pink"],["title":"purple"]])
        
        //StyleManager.addStyle("RepoView NodeList List Container SelectTextButton{height:32px;}")
        //StyleManager.addStyle("RepoView NodeList List Container SelectTextButton Text{margin-top:8px;}")
        /*
        let xml = FileParser.xml("~/Desktop/repo.xml")
        let dp:DataProvider = DataProvider(xml)
        list = addSubView(List(width, height-24, NaN, dp, self))
        ListModifier.selectAt(list!, 0)
        */
        
        //let xml = FileParser.xml("~/Desktop/repo2.xml")
        //let node:Node = Node(xml)
        //Swift.print("node.xml.childCount: " + "\(node.xml.childCount)")
        //Swift.print("node.xml.childAt([0])?.childCount: " + "\(node.xml.childAt([])?.childCount)")
        //StyleManager.addStyle("RepoView NodeList{float:left;clear:left;}")
        //nodeList = addSubView(NodeList(width, height-24, NaN, node, self))
        
        //continue here: create the TreeList
        
        let xml:NSXMLElement = FileParser.xml("~/Desktop/repo2.xml")//
        let treeList:TreeList = addSubView(TreeList(width, height-24, NaN, Node(xml), self))
        
        treeList
        
        //continue here: hock up the selectItem to the open detailview
        
    }
    func onAddButtonClick(){
        Swift.print("addButton.click")
        list!.dataProvider.addItemAt(["title":"New repo","local-path":"","remote-path":"","interval":"30","keychain-item-name":"","branch":"master","broadcast":"true","subscribe":"true","auto-sync":"true"], 0)
        ListModifier.selectAt(list!, 0)
        list!.onEvent(ListEvent(ListEvent.select,0,list!))
    }
    func onBackButton(){
        Swift.print("onBackButton()")
    }
    override func onEvent(event:Event) {
        if(event.type == ButtonEvent.upInside && event.origin === topBar!.addButton){onAddButtonClick()}
        else if(event.type == ListEvent.select){super.onEvent(event)}//forward this event to the parent
        else if(event.type == ButtonEvent.upInside && event.origin === topBar!.backButton){onBackButton()}
    }
}
