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
        binarySearchTest()
        
        
        //test it out with many cases
        //then test it with dictonary
        //then move on to sort other tasks
        
        //multiTaskTest()
        //multiCMDTest()
        //shellTesting()
        //moreShellTesting()
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
    func databaseTest(){
        //store index of item in repo-id coulmn     in     (date column)
        //date column stores items in a chronologically descending order
            //new items are first appended to the correct repo-id
            //then insert a tuple with (repo-id:Int,hash:String,date:Int) at an index you find with binarySearch
        //to retrive the last 100 items: db.sortedByDate.slice(0,100)
        //to retrive the last 100 from a speccific repo. Use git 
        
        //on refresh you should only insert commits that are new. So you need to keep track of which commits are new for each repo
    }
    func binarySearchTest(){
        var sortedArr:[Int] = [1,4,6,7,8,9,12,15,22,22,22,26,33,122,455]
        Swift.print("sortedArr.count: " + "\(sortedArr.count)")
        
        let item:Int = 454
        let closestIdx:Int = closestIndex(sortedArr, item, 0, sortedArr.count-1)
        Swift.print("closestIndex: " + "\(closestIdx)")
        Swift.print("the value that currently occupies this index: " + "\(sortedArr[closestIdx])")
        
        
        let insertAt:Int = item > sortedArr.last ? closestIdx + 1 : closestIdx  //this line enables you to insert the new item correctly in the sorted array
        Swift.print("insertAt: " + "\(insertAt)")
        sortedArr.insertAt(item, insertAt)
        Swift.print("sortedArr: " + "\(sortedArr)")
    }
    /**
     * This binarySearch finds a suitable index to insert an item in a sorted list (a regular binarySearch would return nil if no match is found, this implmentation returns the closestIndex)
     * NOTE: Binary search, also known as half-interval search or logarithmic search, is a search algorithm that finds the position of a target value within a sorted array.
     * NOTE: Binary search compares the target value to the middle element of the array; if they are unequal, the half in which the target cannot lie is eliminated and the search continues on the remaining half until it is successful.
     * NOTE: Binary search runs in at worst logarithmic time, making O(log n) comparisons, where n is the number of elements in the array and log is the logarithm. Binary search takes only constant (O(1)) space, meaning that the space taken by the algorithm is the same for any number of elements in the array.[5] Although specialized data structures designed for fast searching—such as hash tables—can be searched more efficiently, binary search applies to a wider range of search problems.
     * NOTE: This implementation of binary search is recursive (it calls it self) (Binary search is recursive in nature because you apply the same logic over and over again to smaller and smaller subarrays.)
     * IMPORTANT: Although the idea is simple, implementing binary search correctly requires attention to some subtleties about its exit conditions and midpoint calculation.
     * IMPORTANT: Note that the numbers array is sorted. The binary search algorithm does not work otherwise!
     * DISCUSSION: Is it a problem that the array must be sorted first? It depends. Keep in mind that sorting takes time -- the combination of binary search plus sorting may be slower than doing a simple linear search. Binary search shines in situations where you sort just once and then do many searches.
     * TRIVIA:  YOu can also implement binary serach as iterative implementation by using a while loop
     * TODO: use range instead of start and end int?!?
     */
    func closestIndex<T:Comparable>(arr:[T],_ i:T,_ start:Int,_ end:Int) -> Int{//arr[Stridable] or something indexable
        Swift.print("start: " + "\(start)")
        Swift.print("end: " + "\(end)")
        if(start == end){
            Swift.print("i doesn't exist, this is the closest: \(arr[start]) at: \(start) ")
            return start
        }
        let mid:Int = start + ((end - start) / 2)/*start + middle of the distance between start and end*/
        Swift.print("mid: " + "\(mid)")
        //Swift.print("arr[mid]: " + "\(arr[mid])")
        if(i < arr[mid]){/*index is in part1*/
            Swift.print("a")
            return closestIndex(arr,i,start,mid)
        }else if(i > arr[mid]){/*index is in part2*/
            Swift.print("b")
            return closestIndex(arr,i,mid+1,end)
        }else{/*index is at middleIndex*/
            Swift.print("at middle: \(mid)")
            return mid
        }
    }
    //this part isn't needed, the else part takes care of it
    /*
    if(end-start == 1){/*the range is narrowed down to 2 indecies: at start and at end*/
    Swift.print("narrowed down between: start: \(start) end: \(end)" )
    if (idx == arr[start]) {/*idx is at start*/
    return start
    }else if (idx >= arr[end-1]) {/*more or equal to end*/
    return end-1
    }else {
    return start/*between start and end*/
    }
    }
    */
    /**
     *
     */
    func moreShellTesting(){
        func executeCommand(command: String, args: [String]) -> NSString {
            let task = NSTask()
            task.launchPath = command
            task.arguments = args
            let pipe = NSPipe()
            task.standardOutput = pipe
            task.launch()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            let output = NSString(data: data, encoding: NSUTF8StringEncoding)
            return output!
            
        }
        
        let commandOutput = executeCommand("/bin/sh", args: ["-c","echo Hello, I am here!"])
        print("Command output: \(commandOutput)")
        

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
        task.launchPath = "~/Desktop/my_script.sh"//"/bin/sh"//"/usr/bin/env"//"/bin/bash"//
        let logCMD:String = " --pretty=format:Hash:%h%nAuthor:%an%nDate:%ci%nSubject:%s%nBody:%b"//"-3 --oneline"//
        let cmd:String = "head~" + "0" + logCMD + " --no-patch"//--no-patch suppresses the diff output of git show
        //convert the logItem to Tupple
        let argument:String = "git show " + cmd
        
        task.arguments = [argument]//["echo", "hello world","  echo","again","&& echo again","\n echo again"]//["ls"]//"-c", "/usr/bin/killall Dock",
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
