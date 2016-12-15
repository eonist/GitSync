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
        //multiCMDTest()
        shellTesting()
        //trimTest()
        //commitLog()
        //commitShow()
        //dateTest()
        //compactBody()
        //sortTest()
        //commitDataTest()
        //relativeTimeTest()
    }
    /**
     *
     */
    func multiTaskTest(){
        //try this answer: http://stackoverflow.com/questions/9400287/how-to-run-nstask-with-multiple-commands?rq=1
            //try a simple case and then the git commands 20 and then 200 etc. use the timer to calc the time it takes
    }
    /**
     *
     */
    func shellTesting(){
        //let result:String = ShellUtils.run("ls","~/_projects/_code/_active/swift/Element-iOS")
        //Swift.print("result: " + "\(result)")
        let cd = "~/_projects/_code/_active/swift/Element-iOS"
        let task = NSTask()
        task.currentDirectoryPath = cd
        task.launchPath = "/bin/sh"//"/usr/bin/env"//"/bin/bash"//
        task.arguments = ["-c","ps", "-clx", "|", "grep 'Finder'", "|", "awk '{print $2}'"]//["echo", "hello world","  echo","again","&& echo again","\n echo again"]//["ls"]//"-c", "/usr/bin/killall Dock",
        task.environment = ["LC_ALL" : "en_US.UTF-8","HOME" : NSHomeDirectory()]
        let pipe = NSPipe()
        task.standardOutput = pipe
        task.launch()
        task.waitUntilExit()
        let data:NSData = pipe.fileHandleForReading.readDataToEndOfFile()
        let output:String = NSString(data:data, encoding:NSUTF8StringEncoding) as! String
        Swift.print("output: " + "\(output)")
        Swift.print("task.terminationStatus: " + "\(task.terminationStatus)")
    }
    /**
     *
     */
    func multiCMDTest(){
        let repoXML = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)//~/Desktop/repo2.xml
        let repoList = XMLParser.toArray(repoXML)//or use dataProvider
        Swift.print("repoList.count: " + "\(repoList.count)")
        
        let localPath:String = repoList[1]["local-path"]!
        Swift.print("localPath: " + "\(localPath)")
        
        let cmd:String = "head~0 --pretty=format:%h --no-patch"
        let cmd2:String = "head~0 --pretty=format:%h --no-patch"
        
        
        
        var shellScript:String = Git.path + "git show " + cmd + " && " + Git.path + "git show " + cmd2
        Swift.print("shellScript: " + "\(shellScript)")
        
        shellScript = "git show head~0 --pretty=format:%h --no-patch &&  git show head~1 --pretty=format:%h --no-patch"
        let result:String = ShellUtils.run(shellScript,localPath)
        Swift.print("result: " + "\(result)")
        
        //Continue here:
            //do research into multi command calls to NSTask 
                //you could try something simpler than git to get things going
        
        //Continue here: Test if you can call many git calls in one NSTask
            //By using && you can combine git calls, but will the result be an array or a string?
                //Check the speed of such a call
                //if it is a string then you need to setup a regexp.matches that the splits each commit item appart.
                //optionally we could get away with iterating over repos over time, we only show so many items anyway
            //Do single show commands for instance
    }
    /**
     * Trimming test when compacting filtering the commit body
     */
    func trimTest(){
        let test = "'\n\nabc\n'"
        let test2 = "'\nabc\n'"
        let test3 = "abc"
        let test4 = "''"
        let test5 = "'\n'abc'\n'"//we only want to remove the edge ' chars
        let test6 = "'\nabc\n123\n'"
        
        /**
         *
         */
        func trim(str:String){
            let pattern = "^(?:'?\n*)(.*?)(?:\n*'?)$"//"(?:^'?\n*)(.*?)(?:(\n+?'?$)|('$)|$)"
            let options:NSRegularExpressionOptions = [.CaseInsensitive, .DotMatchesLineSeparators]
            str.matches(pattern,options).forEach{//its not pretty but it works
                if($0.numberOfRanges > 1){
                    let body = $0.value(str, 1)/*capturing group 1*/

                    Swift.print(">"+body+"<")

                }
            }
        }
        
        /**/trim(test)
        trim(test2)
        trim(test3)
        trim(test4)
        trim(test5)
        trim(test6)
        
        //Naive approche could be simpler:
        
        /*if(str.characters.first == "'"){
            Swift.print("first char is '")
        }*/
        
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
