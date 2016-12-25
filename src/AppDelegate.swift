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
    var timer:Timer?
    var tickerDate:NSDate?
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        
        Swift.print("GitSync - Simple git automation for macOS")
        
        
        //Continue here:
            //runing NSTask on a background thread is now working, its a bit of a hassle to setup ✅
                //try to clean the setup process🏀
                //try retriving the commits from repo on a background thread🏀
                //try to make the speedy commit count method (combines rev-list and show->error etc)
            //try to speed test the retrival of commits from repo
                //first with the freshness algo set manualy
                //then do a speed test where the repo list is not optimally sorted
        
        //_ = Test()
        
        //initApp()
        
        
        
        //refreshCommitDBTest()
        tickerDate = NSDate()//measure the time of the refresh
        timer = Timer(0.05,true,self,"update")
        /*timer!.start()
        timer!.timer!.fire()*/
        asyncTest()
        
        
        //reflectionDictTest()
        //ioTest()
        //dataBaseTest()
        //chronologicalTime2GitTimeTest()
        //commitDateRangeCountTest()
    }
    func update() {
        Swift.print("tick" + "\(abs(tickerDate!.timeIntervalSinceNow))")
        //timer!.timer!.fireDate
    }
    //var pipes:[NSPipe] = []
    //var pipe:NSPipe!
    //var tasks:[NSTask] = []
    //var task:NSTask!
    var startTime:NSDate?
    dynamic var isRunning = false
    var repoList:[[String:String]] = []
    var index:Int = 0
    var taskTerminatedCount:Int = 0
    var notificationCount:Int = 0
    var outputCount:Int = 0
    /**
     * Testing running an NSTask on a background thread
     */
    func asyncTest(){
        Swift.print("asyncTest")
        self.startTime = NSDate()//measure the time of the refresh
        Swift.print("run.before")
        let repoXML = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)//~/Desktop/repo2.xml
        repoList = XMLParser.toArray(repoXML)//or use dataProvider
        Swift.print("repoList.count: " + "\(repoList.count)")
        repoList.forEach{
            let task = NSTask()
            let pipe = NSPipe()
            let localPath:String = $0["local-path"]!
            let title:String = $0["title"]!
            run(localPath,title,task,pipe)
        }
        Swift.print("run.after")
    }
    /**
     *
     */
    func run(localPath:String,_ title:String,_ task:NSTask, _ pipe:NSPipe){
        //1. Sets isRunning to true. this enables you to stop the process
        isRunning = true
        let taskQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)//swift 3-> let taskQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
        dispatch_async(taskQueue, { () -> Void in
            //2. Creates a new Process object and assigns it to the TasksViewController‘s buildTask property. The launchPath property is the path to the executable you want to run. Assigns the BuildScript.command‘s path to the Process‘s launchPath, then assigns the arguments that were passed to runScript:to Process‘s arguments property. Process will pass the arguments to the executable, as though you had typed them into terminal.
            //self.tasks.append(NSTask())
            //Swift.print(title + " launched")
            //let localPath = "~/_projects/_code/_active/swift/GitSyncOSX"
            task.currentDirectoryPath = localPath
            task.launchPath = "/bin/sh"
            let cmd:String = "git rev-list HEAD --count"
            task.arguments = ["-c",cmd]//["echo", "hello world","  echo","again","&& echo again","\n echo again"]//["ls"]//"-c", "/usr/bin/killall Dock",
            
            //3.Process has a terminationHandler property that contains a block which is executed when the task is finished. This updates the UI to reflect that finished status as you did before.
            /*self.tasks[index].terminationHandler = {
                task in
                dispatch_sync(dispatch_get_main_queue()) {
                    self.taskTerminatedCount++
                    Swift.print("task terminated, main-thread: \(self.taskTerminatedCount)")
                    self.isRunning = false
                }
            }*/
            self.captureStandardOutput(task, pipe,title)
            
            //4.In order to run the task and execute the script, calls launch on the Process object. There are also methods to terminate, interrupt, suspend or resume an Process.
            task.launch()
            
            //5.Calls waitUntilExit, which tells the Process object to block any further activity on the current thread until the task is complete. Remember, this code is running on a background thread. Your UI, which is running on the main thread, will still respond to user input.
            task.waitUntilExit()
        })
    }
    /**
     *
     */
    func captureStandardOutput(task:NSTask, _ pipe:NSPipe,_ title:String) {
        //Swift.print("captureStandardOutput: \(title)")
        //1.//Creates an Pipe and attaches it to buildTask‘s standard output. Pipe is a class representing the same kind of pipe that you created in Terminal. Anything that is written to buildTask‘s stdout will be provided to this Pipe object.
        //self.pipes.append(NSPipe())//we create a new pipe for each task
        task.standardOutput = pipe
        
        //2.the fileHandleForReading is used to read the data in the pipe, You call waitForDataInBackgroundAndNotify on it to use a separate background thread to check for available data.
        pipe.fileHandleForReading.waitForDataInBackgroundAndNotify()//
        
        //3.Whenever data is available, waitForDataInBackgroundAndNotify notifies you by calling the block of code you register with NSNotificationCenter to handle NSFileHandleDataAvailableNotification.
        NSNotificationCenter.defaultCenter().addObserverForName(NSFileHandleDataAvailableNotification, object: pipe.fileHandleForReading, queue: nil){  notification -> Void in
            //4. Inside your notification handler, gets the data as an NSData object and converts it to a string.
            let output = pipe.fileHandleForReading.availableData
            let outputString:String = NSString(data:output, encoding:NSUTF8StringEncoding) as? String ?? ""/*decode the date to a string*/
            self.notificationCount++
            //Swift.print("notify: \(title) resutl:\(outputString.trim("\n")) count: \(self.notificationCount)")
            
            dispatch_async(dispatch_get_main_queue()){
                self.outputCount++
                Swift.print("\(title) main-thread: result \(outputString.trim("\n")) Time-async:  \(abs(self.startTime!.timeIntervalSinceNow)) count: \(self.outputCount)")
            }
           /**/
        }
        //6.Finally, repeats the call to wait for data in the background. This creates a loop that will continually wait for available data, process that data, wait for available data, and so on.
        pipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
    }
    /**
     *
     */
    func stopTask(){
        if isRunning {
            //task.terminate()
        }
    }
    /**
     * NOTE: Even though the NSTask isn't explicitly run on a background thread, it seems to be anyway, as it blocks other background threads added later, actually while doing a Repeating time intervall test, it blocked the timer. So its probably not runnign on a background thread after all
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
        
    }
    /**
     *
     */
    func dataBaseTest(){
    
        
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