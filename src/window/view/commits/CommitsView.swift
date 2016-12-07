import Cocoa

class CommitsView:Element {
    static let w:CGFloat = MainView.w
    static let h:CGFloat = MainView.h-48
    //var topBar:CommitsTopBar?
    var list:CommitsList?
    
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        //topBar = addSubView(CommitsTopBar(width-12,36,self))
        //add a container
        createList()
    }
    func createList(){
        //let dp:DataProvider = DataProvider()
        //dp.addItems([["title":"brown"],["title":"pink"],["title":"purple"]])
        let xml = FileParser.xml("~/Desktop/commits.xml".tildePath)
        let dp:DataProvider = DataProvider(xml)
        Swift.print("dp.count(): " + "\(dp.count)")
        //Swift.print("CommitsView.width: " + "\(width)")
        list = addSubView(CommitsList(CommitsView.w, CommitsView.h, 102, dp, self,"commitsList"))
        ListModifier.selectAt(list!, 1)
    }
    func onListSelect(event:ListEvent){
        Swift.print("CommitsView.onListSelect()")
        Sounds.play?.play()
        Navigation.setView(String(CommitDetailView))
        //RepoView.selectedListItemIndex = list!.selectedIndex
        
        let commitData:Dictionary<String,String> = list!.dataProvider.getItemAt(event.index)!
        (Navigation.currentView as! CommitDetailView).setCommitData(commitData)//updates the UI elements with the selected commit item
    }
    override func onEvent(event:Event) {
        if(event.type == ListEvent.select){onListSelect(event as! ListEvent)}
        //else {super.onEvent(event)}//forward other events
    }
}
/*
class CommitsTopBar:Element{
    var reposButton:Button?
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        reposButton = addSubView(Button(16,16,self,"repos"))
    }
    func onReposButtonClick(){
        Swift.print("onReposButtonClick()")
        Navigation.setView(MenuView.repos)
    }
    override func onEvent(event:Event) {
        if(event.assert(ButtonEvent.upInside, reposButton)){onReposButtonClick()}
    }
}
*/