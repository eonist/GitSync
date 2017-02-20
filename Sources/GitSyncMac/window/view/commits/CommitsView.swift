import Cocoa
@testable import Utils
@testable import Element

class CommitsView:Element {
    static var selectedIdx:Int = 1
    static let w:CGFloat = MainView.w
    static let h:CGFloat = MainView.h-48
    //var topBar:CommitsTopBar?
    var list:CommitsList?
    
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        //topBar = addSubView(CommitsTopBar(width-12,36,self))
        //add a container
        
        createList()/*creates the GUI List*/
    }
    func createList(){
        //let dp:DataProvider = DataProvider()
        //dp.addItems([["title":"brown"],["title":"pink"],["title":"purple"]])
        //let xml = FileParser.xml("~/Desktop/commits.xml".tildePath)
        //Swift.print("dp.count(): " + "\(dp.count)")
        //Swift.print("CommitsView.width: " + "\(width)")
        list = addSubView(CommitsList(CommitsView.w, CommitsView.h, 102, DataProvider(), self,"commitsList"))
        list!.selectAt(dpIdx: CommitsView.selectedIdx)
    }
    
    /**
     * Eventhandler when a CommitsListItem is clicked
     */
    func onListSelect(_ event:ListEvent){
        Swift.print("CommitsView.onListSelect()")
        Sounds.play?.play()
        Navigation.setView("\(CommitDetailView.self)")
        //RepoView.selectedListItemIndex = list!.selectedIndex
        CommitsView.selectedIdx = list!.selectedIdx!
        
        Swift.print("event.index: " + "\(event.index)")
        let commitData:Dictionary<String,String> = list!.dataProvider.getItemAt(event.index)!
        (Navigation.currentView as! CommitDetailView).setCommitData(commitData)//updates the UI elements with the selected commit item
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


//Continue here: 
    //parsing log now works.
        //lets try and parse the last 20 items from every repo and combine them in a dataprovider ✅
            //store in a array-dictionary and create the dp after you have sorted the the arr-dict ✅
                //then try to populate the GUI ✅
                    //remember to store the relative date and compacted body. You should not do any data processing when you display in the GUI ✅
                        //You can always get the full body from the hash when going to CommentDetailView


//TODO: Use RegExp to convert the commit data item to an Triplet item in an array ✅
    //or find the first two linebreaks and split at these integers, then you will have 3 seperate string parts <---easier


//Figure out how to seperate each commit item. With a special char combo that indicates start and end?
    //20 last commits
    //get commit count: (git rev-list HEAD --count) - 1
    //let length:Int = commitCount > 20 ? 20 : commitCount//20 = maxCount
    //for _ in 0..<length{
        //replace 31 with i bellow:
        //let logItem:String = git show head~31  --pretty=oneline --no-patch//--no-patch suppresses the diff output of git show
        //convert the logItem to Tupple

    //}
    //return array of Tupples


//on refresh
    //load all commit log items into one dataprovider
        //remember to attach repo name to the commitData tuple


//Actually do optimization later:
    //Store each Tupple array in its own dataProvider item
        //so that we don't have to reload every log item for every refresh
        //also store these DataProvider items when the app closes
            //Then re-use them on App start

    //When a refresh occurs
        //only grab the log items that are newer than the newst logItem in the dataProvider
        //then prepend these to the dataProvider
