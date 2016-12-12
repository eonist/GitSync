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
    
        
        commitLog()
        
        
    }
    /**
     *
     */
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
        
        //TODO: Use RegExp to convert the commit data item to an Triplet item in an array
            //or find the first two linebreaks and split at these integers, then you will have 3 seperate string parts <---easier
        
        
        //Figure out how to seperate each commit item. With a special char combo that indicates start and end?
            //20 last commits
            //get commit count: (git rev-list HEAD --count) - 1
            //let length:Int = commitCount > 20 ? 20 : commitCount//20 = maxCount
            //for _ in 0..<length{
                //replace 31 with i bellow:
                //let logItem:String = git show head~31  --pretty=oneline --no-patch
                //convert the logItem to Tupple
        
            //}
            //return array of Tupples
        
        
        //on refresh
            //load all commit log items into one dataprovider
                //remember to attach repo name
                
        
        //Actually do optimization later:
            //Store each Tupple array in its own dataProvider item
                //so that we dont have to reload every log item for every refresh
                //also store these DataProvider items when the app closes
                    //Then re-use them on App start
        
            //When a refresh occurs
                //only grab the log items that are newer than the newst logItem in the dataProvider
                //then prepend these to the dataProvider
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