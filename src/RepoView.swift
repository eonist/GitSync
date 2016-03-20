import Foundation

//Load all the xml items

//try to load a list with just the titles first
//Create RepoListItem
//Create RepoList
//Hock up the add and remove functionality
//adding a repo-item shows a InputModalView with the repo-URL,name,branch,etc
//removing a repo-item just removes the item from the List
//save to xml after each remove and add and each repo-settings-update
class RepoView:Element{
    var topBar:TopBar?
    var list:List?
    override func resolveSkin() {
        Swift.print("RepoView.resolveSkin()")
        super.resolveSkin()
        topBar = addSubView(TopBar(width,48,self))
        
        
        let dp:DataProvider = DataProvider()
        dp.addItems([["title":"brown"],["title":"pink"],["title":"purple"]])
        list = addSubView(List(width, height-48, NaN, dp, self))
        ListModifier.selectAt(list!, 1)
    }
    override func onEvent(event: Event) {
        if(event.type == ButtonEvent.upInside && event.origin === topBar!.addButton){
            Swift.print("addButton.click")
            list!.dataProvider.addItemAt(["title":"blue"], 0)
        }else if(event.type == ButtonEvent.upInside && event.origin === topBar!.removeButton){
            Swift.print("removeButton.click")
            list!.dataProvider.removeItemAt(0)//use selected index here
        }
    }
}
class TopBar:Element{
    var addButton:Button?
    var removeButton:Button?
    override func resolveSkin() {
        StyleManager.addStyle("TopBar{fill:grey;float:left;clear:left;corner-radius:0px 4px 0px 0px;}")
        super.resolveSkin()
        //add buttons here
        StyleManager.addStyle("Button#add{fill:green;float:left;clear:none;line:none;corner-radius:0px;line-thickness:0px;}")
        StyleManager.addStyle("Button#remove{fill:red;float:left;clear:none;line:none;corner-radius:0px;line-thickness:0px;}")
        addButton = addSubView(Button(48,48,self,"add"))
        removeButton = addSubView(Button(48,48,self,"remove"))
        
        
        //hoock up the buttons to eventHandlers
        //add the list 
        //try adding and removing items
        
        
    }
    
}
