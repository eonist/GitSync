import Cocoa
/**
 * This is the main class for the application
 * TODO: An idea is to hide parts of the interface when the mouse is not over the app (anim in and out) (maybe)
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
        asyncTest()
        //Continue here: it worked but test this with multiple items🏀
            //Add explination to the steps form the tutorial to make sense of things
        
        //refreshCommitDBTest()
        //reflectionDictTest()
        //ioTest()
        //dataBaseTest()
        //chronologicalTime2GitTimeTest()
        //commitDateRangeCountTest()
    }
    var pipe:NSPipe!
    var task:NSTask!
    dynamic var isRunning = false
    /**
     * Testing running an NSTask on a background thread
     */
    func asyncTest(){
        isRunning = true
        let taskQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)//swift 3-> let taskQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
        dispatch_async(taskQueue, { () -> Void in
            self.task = NSTask()
            let localPath = "~/_projects/_code/_active/swift/GitSyncOSX"
            self.task.currentDirectoryPath = localPath
            self.task.launchPath = "/bin/sh"//"/usr/bin/env"//"/bin/bash"//"~/Desktop/my_script.sh"//
            let cmd:String = "git rev-list HEAD --count"
            self.task.arguments = ["-c",cmd]//["echo", "hello world","  echo","again","&& echo again","\n echo again"]//["ls"]//"-c", "/usr/bin/killall Dock",
            self.pipe = NSPipe()
            self.task.standardOutput = self.pipe
            //3.
            self.task.terminationHandler = {
                task in
                dispatch_async(dispatch_get_main_queue()) {
                    Swift.print("it worked, back on main thread")
                    self.isRunning = false
                }
            }
            self.captureStandardOutputAndRouteToTextView(self.task)
            
            //4.
            self.task.launch()
            
            //5.
            self.task.waitUntilExit()
        })
    }
    /**
     *
     */
    func captureStandardOutputAndRouteToTextView(task:NSTask) {
        //1.
        pipe = NSPipe()//we create a new pipe for each task
        task.standardOutput = pipe
        
        //2.
        pipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
        
        //3.
        NSNotificationCenter.defaultCenter().addObserverForName(NSFileHandleDataAvailableNotification, object: pipe.fileHandleForReading, queue: nil){  notification -> Void in
            let output = self.pipe.fileHandleForReading.availableData
            let outputString:String = NSString(data:output, encoding:NSUTF8StringEncoding) as? String ?? ""/*decode the date to a string*/
            
            dispatch_async(dispatch_get_main_queue()) {//was->DispatchQueue.main.async(execute: {
                Swift.print("on the main thread again: result" + "\(outputString)")
                /*
                let previousOutput = self.outputText.string ?? ""
                let nextOutput = previousOutput + "\n" + outputString
                self.outputText.string = nextOutput
                let range = NSRange(location:nextOutput.characters.count,length:0)
                self.outputText.scrollRangeToVisible(range)
                */
            }
        }
        
        //6.
        self.pipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
        
        
    }
    /**
     *
     */
    func stopTask(){
        if isRunning {
            task.terminate()
        }
    }
    /**
     *
     */
    func refreshCommitDBTest(){
        CommitDBUtils.refresh()
    }
    /**
     * Finds commit count from a date until now
     */
    func commitDateRangeCountTest(){
        let chronoTime = "20161111205959"
        let gitTime = chronoTime.insertCharsAt([("-",4),("-",6),(" ",8),(":",10),(":",12)])//2016-11-11 20:59:59
        Swift.print("gitTime: " + "\(gitTime)")
        //gitTime = gitTime.encode()!
        Swift.print("gitTime: " + "\(gitTime)")
        
        let repoXML = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)//~/Desktop/repo2.xml
        let repoList = XMLParser.toArray(repoXML)//or use dataProvider
        Swift.print("repoList.count: " + "\(repoList.count)")
        
        let localPath:String = repoList[1]["local-path"]!
        Swift.print("localPath: " + "\(localPath)")
        
        let commitCount = GitUtils.commitCount(localPath, after: gitTime)
        Swift.print("commitCount: " + "\(commitCount)")
    }
    /**
     * //YYYYMMDDhhmmss -> YYYY-MM-DD hh:mm:ss
     */
    func chronologicalTime2GitTimeTest(){//format chronological date to git time-> "2016-11-12 00:00:00"
        let githubTime = "20161111205959".insertCharsAt([("-",4),("-",6),(" ",8),(":",10),(":",12)])//2016-11-11 20:59:59
        Swift.print(githubTime)

    }
    /**
     *
     */
    func reflectionDictTest(){
        
        let temp:Temp = Temp([0:"test",3:"testing",5:"more testing"])//create a dict
        let xml:XML = Reflection.toXML(temp) //reflect the dict to xml
        Swift.print(xml.XMLString)//print the xml
        
        let newInstance:Temp = Temp.unWrap(xml)!//unwrap the xml to dict
        newInstance.someDict.forEach{
            Swift.print("key: \($0.0) value: \($0.1)")
        }
        //Swift.print("xml.XMLString: " + "\(xml.XMLString)")
    }
    /**
     *
     */
    func ioTest(){
        let commitDB = CommitDBCache.read()
        
        Swift.print("Printing sortedArr after unwrap: ")
        commitDB.sortedArr.forEach{Swift.print($0.sortableDate)}
        Swift.print("Printing prevCommits after unwrap: ")
        //commitDB.prevCommits.forEach{Swift.print("key: \($0.0) value: \($0.1)")}
        /*
        commitDB.add(Commit("","","","","",201609,"f2o33f",3))
        CommitDBCache.write(commitDB)
        */
        
        //Continue here: reading and writing works...next task!
    }
    /**
     *
     */
    func dataBaseTest(){
        
        //Continue here:🏀
            //so the problem is that you are creating an ascending array, when you need to make it descending
                //aka higher Integer -> lower index
        
        let commitDB = CommitDB()
        commitDB.add(Commit("","","","","",201602,"fak42a",0))
        commitDB.add(Commit("","","","","",201608,"2fae23",0))
        commitDB.add(Commit("","","","","",201601,"gr24g2",5))
        commitDB.add(Commit("","","","","",201611,"24ggq2",2))
        commitDB.add(Commit("","","","","",201606,"esvrg3",1))
        commitDB.add(Commit("","","","","",201606,"esvrg3",1))
        commitDB.add(Commit("","","","","",201506,"g46j45",6))
        commitDB.sortedArr.forEach{Swift.print($0.sortableDate)}
        
        /*
        let xml = Reflection.toXML(commitDB)/*Reflection*/
        Swift.print(xml.XMLString)
        let newInstance:CommitDB = CommitDB.unWrap(xml)!/*UnWrapping*/
        Swift.print("Printing sortedArr after unwrap: ")
        newInstance.sortedArr.forEach{Swift.print($0.sortableDate)}
        */
        //Swift.print("Printing prevCommits after unwrap: ")
        //newInstance.prevCommits.forEach{Swift.print("key: \($0.0) value: \($0.1)")}
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
private class Temp{
    var someDict:[Int:String]
    init(_ someDict:[Int:String]){
        self.someDict = someDict
    }
}
extension Temp:UnWrappable{
    static func unWrap<T>(xml:XML) -> T? {
        let someDict:[Int:String] = unWrap(xml,"someDict")
        return Temp(someDict) as? T
    }
}