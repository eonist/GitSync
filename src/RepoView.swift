import Foundation



//adding a repo-item transitions in the RepoItemDetailView: repo-URL,name,branch,etc (should also have a backButton)

//save to xml after each remove and add and each repo-settings-update

//next is to create the activity list and load in the last 5 commits from each repo. and then sync repos

class RepoView:Element{//rename to RepoListView
    var topBar:TopBar?
    var list:List?
    override func resolveSkin() {
        Swift.print("RepoView.resolveSkin()")
        super.resolveSkin()
        topBar = addSubView(TopBar(width,48,self))
        
        //let dp:DataProvider = DataProvider()
        //dp.addItems([["title":"brown"],["title":"pink"],["title":"purple"]])
        
        let xml = FileParser.xml("~/Desktop/repo.xml")
        let dp:DataProvider = DataProvider(xml)
        RepoData.sharedInstance.dp = dp
        
        list = addSubView(List(width, height-48, NaN, dp, self))
        ListModifier.selectAt(list!, 1)
    }
    override func onEvent(event: Event) {
        if(event.type == ButtonEvent.upInside && event.origin === topBar!.addButton){
            Swift.print("addButton.click")
            list!.dataProvider.addItemAt(["title":"New repo"], 0)
            
            
            //you need to store the repodata in the list.dp and have everything pull from there
            
            
            //ListModifier.selectAt(list!, 0)
        }else if(event.type == ButtonEvent.upInside && event.origin === topBar!.removeButton){
            Swift.print("removeButton.click")
            list!.dataProvider.removeItemAt(0)//use selected index here
        }else if(event.type == ListEvent.select){
            Swift.print("RepoView select")
            super.onEvent(event)//forward this event to the parent
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
