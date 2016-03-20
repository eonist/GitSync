import Foundation
//topBar with add and remove buttons, use Text buttons at first
//Load all the xml items
//contentView
//try to load a list with just the titles first
//Create RepoListItem
//Create RepoList
//Hock up the add and remove functionality
//adding a repo-item shows a InputModalView with the repo-URL,name,branch,etc
//removing a repo-item just removes the item from the List
//save to xml after each remove and add and each repo-settings-update
class RepoView:Element{
    var topBar:TopBar?
    override func resolveSkin() {
        super.resolveSkin()
        topBar = addSubView(TopBar(width,48,self))
        
        
        StyleManager.addStyle("~/")
        let dp:DataProvider = DataProvider(xml)
        let list:List = listCard.addSubView(List(140, 72, NaN, dp,listCard))
        ListModifier.selectAt(list, 1);
        
        
        list.dataProvider.addItemAt({title:"brown"}, 0);
        //		list.dataProvider.addItem({title:"pink"});// :TODO: doesnt work atm
        //		list.dataProvider.addItems([{title:"purple"}, {title:"turquoise"}]);// :TODO: doesnt work atm
    }
    
}
class TopBar:Element{
    var addButton:Button?
    var removeButton:Button?
    override func resolveSkin() {
        StyleManager.addStyle("TopBar{fill:grey;float:left;clear:left;corner-radius:0px 4px 0px 0px;}")
        super.resolveSkin()
        //add buttons here
        StyleManager.addStyle("Button#add{fill:green;float:left;clear:none;}")
        StyleManager.addStyle("Button#remove{fill:red;float:left;clear:none;}")
        addButton = addSubView(Button(48,48,self,"add"))
        removeButton = addSubView(Button(48,48,self,"remove"))
        
        
        //hoock up the buttons to eventHandlers
        //add the list 
        //try adding and removing items
        
        
    }
    override func onEvent(event: Event) {
        if(event.type == ButtonEvent.upInside && event.origin === addButton){
            Swift.print("addButton.click")
        }else if(event.type == ButtonEvent.upInside && event.origin === removeButton){
            Swift.print("removeButton.click")
        }
    }
}