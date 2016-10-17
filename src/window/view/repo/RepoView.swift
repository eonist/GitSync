import Foundation
/**
 * TODO: should remember previouse selected item between transitions
 */
class RepoView:Element {
    var topBar:TopBar?
    var list:List?
    override func resolveSkin() {
        Swift.print("RepoView.resolveSkin()")
        
        super.resolveSkin()//self.skin = SkinResolver.skin(self)//
        topBar = addSubView(TopBar(width-12,36,self))
        
        let xml = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)//~/Desktop/repo2.xml
        let dp:DataProvider = DataProvider(xml)
        list = addSubView(List(width, height-24, NaN, dp,self))
        list!.selectAt(0)
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
    /*func onRemoveButtonClick(){
        Swift.print("onRemoveButton()")
    }*/
    /*func onEditButtonClick(){
        Swift.print("onEditButton()")
        Navigation.setView(String(RepoDetailView))
        
        let repoItem:Dictionary<String,String> = list!.dataProvider.getItemAt(list!.selectedIndex)!
        (Navigation.currentView as! RepoDetailView).setRepoData(repoItem)//updates the UI elements with the selected repo data
    }*/
    override func onEvent(event:Event) {
        if(event.type == ButtonEvent.upInside && event.origin === topBar!.addButton){onAddButtonClick()}
        else if(event.type == ButtonEvent.upInside && event.origin === topBar!.backButton){onBackButtonClick()}
        //else if(event.type == ButtonEvent.upInside && event.origin === topBar!.removeButton){onRemoveButtonClick()}
        //else if(event.type == ButtonEvent.upInside && event.origin === topBar!.editButton){onEditButtonClick()}
        //else if(event.type == ListEvent.select){super.onEvent(event)}//forward this event to the parent
        //else if(event.type == SelectEvent.select && event.immediate === list){super.onEvent(event)}//forward this event to the parent
    }
}

/**
 * Add,Remove,Edit,Cut,Paste
 */
class TopBar:Element{
    var backButton:Button?
    //var editButton:Button?
    //var removeButton:Button?
    var addButton:Button?
    override func resolveSkin() {
        Swift.print("TopBar.resolveSkin()")
        super.resolveSkin()//self.skin = SkinResolver.skin(self)//
        //editButton = addSubView(Button(NaN,NaN,self,"edit"))
        //removeButton = addSubView(Button(NaN,NaN,self,"remove"))
        backButton = addSubView(Button(NaN,NaN,self,"back"))
        addButton = addSubView(Button(NaN,NaN,self,"add"))
    }
}