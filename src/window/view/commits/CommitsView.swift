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
        //let xml = FileParser.xml("~/Desktop/commits.xml".tildePath)
        let dp:DataProvider = Utils.dataProvider()//DataProvider(xml)
        //Swift.print("dp.count(): " + "\(dp.count)")
        //Swift.print("CommitsView.width: " + "\(width)")
        list = addSubView(CommitsList(CommitsView.w, CommitsView.h, 102, dp, self,"commitsList"))
        ListModifier.selectAt(list!, 1)
    }
    func onListSelect(event:ListEvent){
        Swift.print("CommitsView.onListSelect()")
        Sounds.play?.play()
        Navigation.setView(String(CommitDetailView))
        //RepoView.selectedListItemIndex = list!.selectedIndex
        Swift.print("event.index: " + "\(event.index)")
        let commitData:Dictionary<String,String> = list!.dataProvider.getItemAt(event.index)!
        (Navigation.currentView as! CommitDetailView).setCommitData(commitData)//updates the UI elements with the selected commit item
    }
    override func onEvent(event:Event) {
        if(event.type == ListEvent.select){onListSelect(event as! ListEvent)}
        //else {super.onEvent(event)}//forward other events
    }
}
private class Utils{
    /**
     * Populates a DataProvider instance with data derived from commits in a repository
     */
    static func dataProvider()->DataProvider{
        var commitItems:[Dictionary<String, String>] = []
        
        let repoXML = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)//~/Desktop/repo2.xml
        let repoList = XMLParser.toArray(repoXML)//or use dataProvider
        //Swift.print("repoList.count: " + "\(repoList.count)")
        
        let localPath = repoList[1]["local-path"]
        //Swift.print("localPath: " + "\(localPath)")
        let repoTitle = repoList[1]["title"]!
        
        let commitCount:String = GitParser.commitCount(localPath!)/*Get the commitCount of this repo*/
        Swift.print("commitCount: " + "\(commitCount)")
        
        let length:Int = commitCount.int > 20 ? 20 : commitCount.int//20 = maxCount
        let logCMD:String = " --pretty=format:Hash:%h%nAuthor:%an%nDate:%ci%nSubject:%s%nBody:%b"//"-3 --oneline"//
        for i in 0..<length{
            //replace 31 with i bellow:
            let cmd:String = "head~" + i.string + logCMD + " --no-patch"//--no-patch suppresses the diff output of git show
            //convert the logItem to Tupple
            let result:String = GitParser.show(localPath!, cmd)
            //Swift.print("result.count: " + "\(result.count)")
            let commitData = GitLogParser.commitData(result)
            //dpItem["repo-name"]!, dpItem["contributor"]!,dpItem["title"]!,dpItem["description"]!,dpItem["date"]!
            let date:NSDate = GitLogParser.date(commitData.date)
            //Swift.print("date.shortDate: " + "\(date.shortDate)")
            let relativeTime = DateParser.relativeTime(NSDate(),date)[0]
            let relativeDate:String = relativeTime.value.string + relativeTime.type/*create date like 3s,4m,5h,6w,2y*/
            //Swift.print("relativeDate: " + "\(relativeDate)")
            let descendingDate:String = DateParser.descendingDate(date)
            let compactBody:String = GitLogParser.compactBody(commitData.body)/*compact the commit msg body*/
            //Swift.print("compactBody: " + "\(compactBody)")
            let subject:String = StringParser.trim(commitData.subject, "'", "'")
            commitItems.append(["repo-name":repoTitle,"contributor":commitData.author,"title":subject,"description":compactBody,"date":relativeDate,"sortableDate":descendingDate,"hash":commitData.hash])////we store the full hash in the CommitData and in the dp item, so that when you click on an item you can generate all commit details in the CommitDetailView
        }
        let dp = DataProvider(commitItems)
        dp.sort("sortableDate")/*sorts the list in ascending order*/
        //Swift.print("dp.count: " + "\(dp.count)")
        return dp
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
        //lets try and parse the last 20 items from every repo and combine them in a dataprovider (done)
            //store in a array-dictionary and create the dp after you have sorted the the arr-dict (done)
                //then try to populate the GUI (done)
                    //remember to store the relative date and compacted body. You should not do any data processing when you display in the GUI (done)
                        //You can always get the full body from the hash when going to CommentDetailView


//TODO: Use RegExp to convert the commit data item to an Triplet item in an array (done)
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