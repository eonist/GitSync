import Foundation

//update the add repo button to a IconButton

//add a remove button in repoItemDetailView topRight

//add the trashCan SVG to the removeBTN

//add the plus sign to the add repo button

//save to xml after each remove and add and each repo-settings-update (this involves creating the dp->xml method)

//hook up the leftSideBar to app logic

//next is to create the activity list and load in the last 5 commits from each repo. and then sync repos

class RepoView:Element{//rename to RepoListView
    var topBar:TopBar?
    var list:List?
    override func resolveSkin() {
        Swift.print("RepoView.resolveSkin()")
        super.resolveSkin()
        topBar = addSubView(TopBar(width,24,self))
        
        //let dp:DataProvider = DataProvider()
        //dp.addItems([["title":"brown"],["title":"pink"],["title":"purple"]])
        
        let xml = FileParser.xml("~/Desktop/repo.xml")
        let dp:DataProvider = DataProvider(xml)
        
        list = addSubView(List(width, height-24, NaN, dp, self))
        ListModifier.selectAt(list!, 0)
    }
    override func onEvent(event: Event) {
        if(event.type == ButtonEvent.upInside && event.origin === topBar!.addButton){
            Swift.print("addButton.click")
            list!.dataProvider.addItemAt(["title":"New repo","local-path":"","remote-path":"","interval":"30","keychain-item-name":"","branch":"master","broadcast":"true","subscribe":"true","auto-sync":"true"], 0)
            ListModifier.selectAt(list!, 0)
            list!.onEvent(ListEvent(ListEvent.select,0,list!))
        }else if(event.type == ListEvent.select){
            Swift.print("RepoView select")
            super.onEvent(event)//forward this event to the parent
        }
    }
}
