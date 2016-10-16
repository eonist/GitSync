import Foundation

class RepoView:Element {
    var topBar:TopBar?
    var list:List?
    override func resolveSkin() {
        Swift.print("RepoView.resolveSkin()")
        
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        topBar = addSubView(TopBar(width-24,36,self))
        
        let xml = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)//~/Desktop/repo2.xml
        let dp:DataProvider = DataProvider(xml)
        list = addSubView(List(width, height-24, NaN, dp,self))
        list!.selectAt(0)
        
        
    }
    func onAddButtonClick(){
        Swift.print("addButton.click")
        list!.dataProvider.addItemAt(["title":"New repo","local-path":"","remote-path":"","interval":"30","keychain-item-name":"","branch":"master","broadcast":"true","subscribe":"true","auto-sync":"true"], 0)
        ListModifier.selectAt(list!, 0)
        //list!.onEvent(ListEvent(ListEvent.select,0,list!))
    }
    func onRemoveButtonClick(){
        Swift.print("onRemoveButton()")
    }
    func onEditButtonClick(){
        Swift.print("onEditButton()")
        Navigation.setView(String(RepoDetailView))
        
        let repoItem = list!.dataProvider.getItemAt(list!.sel)!
        repoDetailView!.setRepoData(repoItem)//updates the UI elements with the selected repo data
    }
    
    override func onEvent(event:Event) {
        if(event.type == ButtonEvent.upInside && event.origin === topBar!.addButton){onAddButtonClick()}
        else if(event.type == ButtonEvent.upInside && event.origin === topBar!.removeButton){onRemoveButtonClick()}
        else if(event.type == ButtonEvent.upInside && event.origin === topBar!.editButton){onEditButtonClick()}
        //else if(event.type == ListEvent.select){super.onEvent(event)}//forward this event to the parent
        //else if(event.type == SelectEvent.select && event.immediate === list){super.onEvent(event)}//forward this event to the parent
        
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
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        editButton = addSubView(Button(NaN,NaN,self,"edit"))
        removeButton = addSubView(Button(NaN,NaN,self,"remove"))
        addButton = addSubView(Button(NaN,NaN,self,"add"))
    }
}