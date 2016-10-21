import Foundation
/**
 * TODO: should remember previouse selected item between transitions
 */
class RepoView:Element {
    var topBar:TopBar?
    static var dp:DataProvider?
    var list:List?
    static var selectedListItemIndex:Int = -1
    override func resolveSkin() {
        Swift.print("RepoView.resolveSkin()")
        
        self.skin = SkinResolver.skin(self)//super.resolveSkin()//
        topBar = addSubView(TopBar(width-12,NaN,self))
        
        if(RepoView.dp == nil){
            let xml = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)//~/Desktop/repo2.xml
            RepoView.dp = DataProvider(xml)
        }
        
        list = addSubView(List(width, height-24, NaN, RepoView.dp,self))
        if(RepoView.selectedListItemIndex != -1){list!.selectAt(RepoView.selectedListItemIndex)}
    }
    func onAddButtonClick(){
        Swift.print("addButton.click")
        list!.dataProvider.addItemAt(["title":"New repo","local-path":"~/Desktop/","remote-path":"https://github.com/userName/repoName.git","interval":"0","keychain-item-name":"","branch":"master","broadcast":"false","subscribe":"true","auto-sync":"false"], 0)
        ListModifier.selectAt(list!, 0)
        let repoItem:Dictionary<String,String> = list!.dataProvider.getItemAt(list!.selectedIndex)!
        Navigation.setView(String(RepoDetailView))
        (Navigation.currentView as! RepoDetailView).setRepoData(repoItem)//updates the UI elements with the selected repo data
        //list!.onEvent(ListEvent(ListEvent.select,0,list!))
    }
    func onBackButtonClick(){
        Swift.print("onBackButtonClick()")
        Navigation.setView(MenuView.commits)
    }
    func onListSelect(){
        Navigation.setView(String(RepoDetailView))
        RepoView.selectedListItemIndex = list!.selectedIndex
        let repoItem:Dictionary<String,String> = list!.dataProvider.getItemAt(RepoView.selectedListItemIndex)!
        (Navigation.currentView as! RepoDetailView).setRepoData(repoItem)//updates the UI elements with the selected repo data
    }
    override func onEvent(event:Event) {
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