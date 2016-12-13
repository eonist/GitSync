import Cocoa
/**
 * This is the main class for the application
 * TODO: An idea is to hide the interface when the mouse is not over the app (anim in and out) (maybe)
 */
@NSApplicationMain
class AppDelegate:NSObject, NSApplicationDelegate {
    weak var window: NSWindow!
    var repoFilePath:String = "~/Desktop/repo.xml"
    var win:NSWindow?/*<--The window must be a class variable, local variables doesn't work*/
    var fileWatcher:FileWatcher?
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        
        Swift.print("GitSync - Simple git automation for macOS")
        
        //initApp()
        
        //Continue here:
            //figure out the body bug
            //change the date field date should be relative and the sortableDate should be something else
        
        //commitLog()
        //commitShow()
        //dateTest()
        //compactBody()
        //sortTest()
        //commitDataTest()
        //relativeTimeTest()
        
        let test = "'\n\nabc\n'"
        let test2 = "'\nabc\n'"
        let test3 = "\""
        
        /**
         *
         */
        func trim(str:String){
           
            
            str.matches("(?:[',\n]{0,3})(.*?)(?:\n)").forEach{
                if($0.numberOfRanges > 1){
                    let body = $0.value(str, 1)/*capturing group 1*/
                    Swift.print(">")
                    Swift.print(body)
                    Swift.print("<")
                }
            }/**/
            
                    /*if(str.characters.first == "'"){
            Swift.print("first char is '")
            }*/
        }
        
        trim(test)
        trim(test2)
        
        //Continue here:
            //support formating the above cases
            //also format the subject by remvoing the wrapping '' chars
        
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
    /**
     *
     */
    func compactBody(){
        var bodyStr:String = ""
        bodyStr += "'\n"
        bodyStr += "\n"
        bodyStr += "Modified 1 file:\n"
        bodyStr += "README.md\n"
        bodyStr += "'"
        
       
        
        
        
        //Swift.print("bodyStr: " + "\(bodyStr)")
        
        let compactBody = GitLogParser.compactBody(bodyStr)
        Swift.print("compactBody-start")
        Swift.print(compactBody)
        Swift.print("compactBody-end")
    }
    func sortTest(){

        
        //Create a CommitData tuple object
        let a:(author:String,date:Int,subject:String,body:String) = (author:"eonist",date:20161203165939,subject:"a",body:"")
        let b:(author:String,date:Int,subject:String,body:String) = (author:"eonist",date:20161205165939,subject:"b",body:"")
        let c:(author:String,date:Int,subject:String,body:String) = (author:"eonist",date:20161201165939,subject:"c",body:"")
        
        //make a few items that you can sort
    
        var customArray = [a,b,c]
        
        customArray.sortInPlace { (element1, element2) -> Bool in
            return element1.date < element2.date
        }
        customArray.forEach{Swift.print($0.subject)}
    }
    /**
     * Parsing commitData
     */
    func commitDataTest(){
        var testString:String = ""
        testString += "Hash:4caecd0ed658b45a14bd327ea2c1a7997c11c399" + "\n"
        testString += "Author:Eonist" + "\n"
        testString += "Date:2015-12-03 16:59:09 +0100" + "\n"
        testString += "Subject:'Files modified: 1'" + "\n"
        testString += "Body:'" + "\n"
        testString += "" + "\n"
        testString += "Modified 1 file:" + "\n"
        testString += "README.md" + "\n"
        testString += "'"
        //Swift.print(testString)
        
        let commitData = GitLogParser.commitData(testString)
        
        let date:NSDate = GitLogParser.date(commitData.date)
        Swift.print("date.shortDate: " + "\(date.shortDate)")
        
        
    }
    /**
     *
     */
    func relativeTimeTest(){
        let today:NSDate = NSDate()
        Swift.print("today.shortDate: " + "\(today.shortDate)")
        
        let threeDaysAgo = today.offsetByDays(-3)
        Swift.print("threeDaysAgo!.shortDate: " + "\(threeDaysAgo.shortDate)")
        
        let relativeTime = DateParser.relativeTime(today,threeDaysAgo)
        Swift.print("relativeTime: " + "\(relativeTime)")
    }
    func initApp(){
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/gitsync.css",true)//<--toggle this bool for live refresh
        
        win = MainWin(MainView.w,MainView.h)
        //win = ConflictDialogWin(380,400)
        //win = CommitDialogWin(400,356)
        
        let url:String = "~/Desktop/ElCapitan/gitsync.css"
        fileWatcher = FileWatcher([url.tildePath])
        fileWatcher!.event = { event in
            //Swift.print(self)
            Swift.print(event.description)
            if(event.fileChange && event.path == url.tildePath) {
                Swift.print("update to the file happened")
                StyleManager.addStylesByURL(url,true)
                let view:NSView = self.win!.contentView!//MainWin.mainView!
                ElementModifier.refreshSkin(view as! IElement)
                ElementModifier.floatChildren(view)
            }
        }
        fileWatcher!.start()
    }
    func applicationWillTerminate(aNotification:NSNotification) {
        //store the app prefs
        if(PrefsView.keychainUserName != nil){//make sure the data has been read and written to first
            let xml:XML = "<prefs></prefs>".xml
            xml.appendChild("<keychainUserName>\(PrefsView.keychainUserName!)</keychainUserName>".xml)
            xml.appendChild("<gitConfigUserName>\(PrefsView.gitConfigUserName!)</gitConfigUserName>".xml)
            xml.appendChild("<gitEmailName>\(PrefsView.gitEmailNameText!)</gitEmailName>".xml)
            xml.appendChild("<uiSounds>\(String(PrefsView.uiSounds!))</uiSounds>".xml)
            FileModifier.write("~/Desktop/gitsyncprefs.xml".tildePath, xml.XMLString)
        }
        //store the repo xml
        if(RepoView.dp != nil){//make sure the data has been read and written to first
            FileModifier.write("~/Desktop/assets/xml/list.xml".tildePath, RepoView.dp!.xml.XMLString)
        }
        print("Good-bye")
    }
}
