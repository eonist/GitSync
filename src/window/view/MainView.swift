import Foundation

class MainView:TitleView{
    static let w:CGFloat = 540
    static let h:CGFloat = 350
    var title:String/*the title must be set after the init of the Window instance*/
    var menuView:MenuView?
    var currentView:Element?
    var conflictDialogWin:ConflictDialogWin?
    
    init(_ width:CGFloat, _ height:CGFloat,_ title:String = "", _ parent:IElement? = nil, _ id:String? = "") {
        self.title = title
        super.init(width, height, parent, "")
    }
    override func resolveSkin() {
        Swift.print("MainView.resolveSkin()")
        super.resolveSkin()
        super.textArea!.setTextValue(title)
        Sounds.startup?.play()
        MainWin.mainView = self
        
        menuView = addSubView(MenuView(frame.width,48,self))
        
        //Navigation.setView(MenuView.commits)/*adds the correct view to MainView*/
        //menuView!.selectGroup!.selectedAt(0)/*Selects the correct menu icon*/
    
        
        //commitLog()
        commitShow()
        
        
        
    }
    func commitShow(){
        var commitItems:[Dictionary<String, String>] = []
        
        let repoXML = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)//~/Desktop/repo2.xml
        let repoList = XMLParser.toArray(repoXML)//or use dataProvider
        Swift.print("repoList.count: " + "\(repoList.count)")
        
        let localPath = repoList[1]["local-path"]
        Swift.print("localPath: " + "\(localPath)")
        let repoTitle = repoList[1]["title"]!
        /*
        let cmd:String = "head~1 --pretty=oneline --no-patch"
        Swift.print("cmd: " + "\(cmd)")
        let result:String = GitParser.show(localPath!, cmd)
        Swift.print("result: " + "\(result)")
        */
        
        let commitCount:String = GitParser.commitCount(localPath!)
        Swift.print("commitCount: " + "\(commitCount)")
        
        let length:Int = 3//commitCount > 20 ? 20 : commitCount//20 = maxCount
        let logCMD:String = " --pretty=format:\"Hash:%h%nAuthor:%an%nDate:%ci%nSubject:%s%nBody:%b\""//"-3 --oneline"//
        for i in 0..<length{
            //replace 31 with i bellow:
            let cmd:String = "head~" + i.string + logCMD + " --no-patch"//--no-patch suppresses the diff output of git show
            //convert the logItem to Tupple
            let result:String = GitParser.show(localPath!, cmd)
            Swift.print("result.count: " + "\(result.count)")
            let commitData = GitLogParser.commitData(result)
            //dpItem["repo-name"]!, dpItem["contributor"]!,dpItem["title"]!,dpItem["description"]!,dpItem["date"]!
            
            //Continue here:
                //You need to compact the commit msg body
            
        
            
            let date:NSDate = GitLogParser.date(commitData.date)
            //Swift.print("date.shortDate: " + "\(date.shortDate)")
            let relativeTime = DateParser.relativeTime(NSDate(),date)[0]
            let relativeDate:String = relativeTime.value.string + relativeTime.type
            Swift.print("relativeDate: " + "\(relativeDate)")
            
            let compactBody:String = GitLogParser.compactBody(commitData.body)
            Swift.print("compactBody: " + "\(compactBody)")
            commitItems.append(["repo-name":repoTitle,"contributor":commitData.author,"title":commitData.subject,"description":compactBody,"date":relativeDate,"hash":commitData.hash])////we store the full hash in the CommitData and in the dp item, so that when you click on an item you can generate all commit details in the CommitDetailView
        }
        
        
        let dp = DataProvider(commitItems)
        
        
        Swift.print("dp.count: " + "\(dp.count)")

        
        //Continue here: 
            //parsing log now works.
                //lets try and parse the last 20 items from every repo and combine them in a dataprovider
                    //store in a array-dictionary and create the dp after you have sorted the the arr-dict
                        //then try to populate the GUI
                            //remember to store the relative date and compacted body. You should not do any data processing when you display in the GUI
                                //You can always get the full body from the hash when going to CommentDetailView
        
        
        //TODO: Use RegExp to convert the commit data item to an Triplet item in an array
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
                //so that we dont have to reload every log item for every refresh
                //also store these DataProvider items when the app closes
                    //Then re-use them on App start
        
            //When a refresh occurs
                //only grab the log items that are newer than the newst logItem in the dataProvider
                //then prepend these to the dataProvider
    }
    func commitLog(){
        let repoXML = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)//~/Desktop/repo2.xml
        let repoList = XMLParser.toArray(repoXML)//or use dataProvider
        Swift.print("repoList.count: " + "\(repoList.count)")
        
        let localPath = repoList[1]["local-path"]
        Swift.print("localPath: " + "\(localPath)")
        
        let cmd:String = "-3 --pretty=format:\"Author:%an%nDate:%ci%nSubject:%s%nBody:%b\""//"-3 --oneline"//
        //%ci -> 2015-12-03 16:59:09 +0100 ->is the best date format to convert to a Data instance. Relative time from git is strange. 26 hours ago should be 1 day ago etc, but is'nt
        
        Swift.print("cmd: " + "\(cmd)")
        
        let logResult:String = GitParser.log(localPath!, cmd)
        Swift.print("logResult: ")
        Swift.print("\(logResult)")
        
    }
    /**
     *
     */
    func testGit(){
        let repoXML = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)//~/Desktop/repo2.xml
        let repoList = XMLParser.toArray(repoXML)//or use dataProvider
        Swift.print("repoList.count: " + "\(repoList.count)")
        
        let localPath = repoList[1]["local-path"]
        Swift.print("localPath: " + "\(localPath)")
        
        let remotePath = repoList[1]["remote-path"]
        Swift.print("remotePath: " + "\(remotePath)")
        
        let theKeychainItemName = repoList[1]["keychain-item-name"]!
        Swift.print("theKeychainItemName: " + "\(theKeychainItemName)")
        let keychainPassword = KeyChainParser.password(theKeychainItemName)
        Swift.print("keychainPassword: " + "\(keychainPassword)")
        let remoteAccountName = theKeychainItemName
        Swift.print("remoteAccountName: " + "\(remoteAccountName)")
        
        GitSync.initCommit(repoList[1], "master")
        GitSync.initPush(repoList[1], "master")
        
    }
    required init?(coder:NSCoder) {fatalError("init(coder:) has not been implemented")}
}