import Cocoa
@testable import Utils
@testable import Element

class CommitsView:Element {
    static var selectedIdx:Int = 1
    static let w:CGFloat = MainView.w
    static let h:CGFloat = MainView.h-48
    //var topBar:CommitsTopBar?
    var list:CommitsList?//TODO: ⚠️️ make lazy
    
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        //topBar = addSubView(CommitsTopBar(width-12,36,self))
        //add a container
        createList()/*creates the GUI List*/
    }
    func createList(){
        let dp = CommitDPCache.read()/*Creates the dp based on cached data from previous app runs*/
        list = addSubView(CommitsList.init(CommitsView.w, CommitsView.h, CGSize(24,102), dp, self,"commitsList"))/*24 should be allowed to be nan no?*/
        //⚠️️list!.selectAt(dpIdx: CommitsView.selectedIdx)
    }
    /**
     * Eventhandler when a CommitsListItem is clicked
     */
    func onListSelect(_ event:ListEvent){
        Swift.print("CommitsView.onListSelect()")
        //Sounds.play?.play()
        
        //RepoView.selectedListItemIndex = list!.selectedIndex
        CommitsView.selectedIdx = list!.selectedIdx!
        
        Swift.print("event.index: " + "\(event.index)")
        let commitData:[String:String] = list!.dp.getItemAt(event.index)!
        //(Navigation.currentView as! CommitDetailView).setCommitData(commitData)//updates the UI elements with the selected commit item
        Navigation.setView(.commitDetail(commitData))
    }
    override func onEvent(_ event:Event) {
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
