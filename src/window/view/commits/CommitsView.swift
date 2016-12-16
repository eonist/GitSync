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
        loadCommits()
    }
    func createList(){
        //let dp:DataProvider = DataProvider()
        //dp.addItems([["title":"brown"],["title":"pink"],["title":"purple"]])
        //let xml = FileParser.xml("~/Desktop/commits.xml".tildePath)
        
        //Swift.print("dp.count(): " + "\(dp.count)")
        //Swift.print("CommitsView.width: " + "\(width)")
        list = addSubView(CommitsList(CommitsView.w, CommitsView.h, 102, dp, self,"commitsList"))
        ListModifier.selectAt(list!, 1)
    }
    var dp:DataProvider?  //Utils.dataProvider()//DataProvider(xml)
    var startTime:NSDate?
    var operations:[(task:NSTask,pipe:NSPipe,repoTitle:String)] = []
    /**
     * //try this answer: http://stackoverflow.com/questions/9400287/how-to-run-nstask-with-multiple-commands?rq=1
     * //try a simple case and then the git commands 20 and then 200 etc. use the timer to calc the time it takes
     */
    func loadCommits(){
        startTime = NSDate()
        let repoXML = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)//~/Desktop/repo2.xml
        var repoList = XMLParser.toArray(repoXML)//or use dataProvider
        repoList = [repoList[1]]
        Swift.print("repoList.count: " + "\(repoList.count)")
        
        //let maxItems:Int = 100/*the amount of items to retrive*/
        let maxCommitItems:Int = 20//maxItems/repoList.count/*max commit items allowed per repo*/
        Swift.print("repoList.count: " + "\(repoList.count)")
        Swift.print("maxCommitItems: " + "\(maxCommitItems)")
        repoList.forEach{
            let localPath:String = $0["local-path"]!
            let repoTitle = $0["title"]!
            let args:[String] = CommitViewUtils.commitItems(localPath,maxCommitItems)
            args.forEach{
                let operation = CommitViewUtils.configOperation([$0],localPath,repoTitle)
                operations.append(operation)
            }
        }
        
        let finalTask = operations[operations.count-1].task/*we listen to the last task for completion*/
        NSNotificationCenter.defaultCenter().addObserverForName(NSTaskDidTerminateNotification, object: finalTask, queue: nil, usingBlock:observer)/*{ notification in})*/
        
        operations.forEach{/*launch all tasks*/
            $0.task.launch()
        }
    }

    /**
     * The handler for the NSTasks
     */
    func observer(notification:NSNotification) {
        Swift.print("the last task completed")
        var commitItems:[Dictionary<String, String>] = []
        
        operations.forEach{
            let data:NSData = $0.pipe.fileHandleForReading.readDataToEndOfFile()
            let output:String = NSString(data:data, encoding:NSUTF8StringEncoding) as! String
            //Swift.print(output)
            let commitData = GitLogParser.commitData(output)/*Compartmentalizes the result into a Tuple*/
            let processedCommitData = CommitViewUtils.processCommitData($0.repoTitle,commitData)
            commitItems.append(processedCommitData)////we store the full hash in the CommitData and in the dp item, so that when you click on an item you can generate all commit details in the CommitDetailView
        }
        dp = DataProvider(commitItems)
        dp!.sort("sortableDate")/*sorts the list in ascending order*/
        Swift.print("dp.count: " + "\(dp!.count)")
        Swift.print("Time: " + "\(abs(startTime!.timeIntervalSinceNow))")
        createList()/*creates the GUI List*/
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
        //Swift.print("commitCount: " + ">\(commitCount)<")
        let length:Int = commitCount.int > 20 ? 20 : commitCount.int//20 = maxCount
        let logCMD:String = " --pretty=format:Hash:%h%nAuthor:%an%nDate:%ci%nSubject:%s%nBody:%b"//"-3 --oneline"//
        let startTime = NSDate()
        
        for i in 0..<length{
            //replace 31 with i bellow:
            let cmd:String = "head~" + i.string + logCMD + " --no-patch"//--no-patch suppresses the diff output of git show
            //convert the logItem to Tupple
            let result:String = GitParser.show(localPath!, cmd)
            //Swift.print("result.count: " + "\(result.count)")
            let commitData = GitLogParser.commitData(result)/*Compartmentalizes the result into a Tuple*/
            //dpItem["repo-name"]!, dpItem["contributor"]!,dpItem["title"]!,dpItem["description"]!,dpItem["date"]!
            let processedCommitData = CommitViewUtils.processCommitData(repoTitle, commitData)
            commitItems.append(processedCommitData)////we store the full hash in the CommitData and in the dp item, so that when you click on an item you can generate all commit details in the CommitDetailView
        }
        //do some intensive cpu stuff here
        Swift.print("Time: " + "\(abs(startTime.timeIntervalSinceNow))")
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