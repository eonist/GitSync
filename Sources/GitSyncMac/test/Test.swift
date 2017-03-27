import Foundation
@testable import Utils

class Test {
    init(){
        //binarySearchTest()
        //multiCMDTest()
        //shellTesting()A
        //moreShellTesting()
        //trimTest()
        //commitLog()
        //commitShow()
        //dateTest()
        compactBody()
        //sortTest()
        //commitDataTest()
        //relativeTimeTest()
    }
    func binarySearchTest(){
        var sortedArr:[Int] = []//[1,4,6,7,8,9,12,15,22,22,22,26,33,122,455]
        Swift.print("sortedArr.count: " + "\(sortedArr.count)")
        
        func add(_ item:Int){
            let closestIdx:Int = CommitDB.closestIndex(sortedArr, item, 0, sortedArr.endIndex)
            Swift.print("closestIndex: " + "\(closestIdx)")
            _ = sortedArr.insertAt(item, closestIdx)
        }
        add(1)
        add(6)
        add(4)
        add(0)
        add(7)
        Swift.print("sortedArr: " + "\(sortedArr)")
        
        
        //Swift.print("sortedArr.endIndex: " + "\(sortedArr.endIndex)")
        
        //let insertAt:Int = item > sortedArr.last && sortedArr.count != 0 ? closestIdx  : closestIdx  //this line enables you to insert the new item correctly in the sorted array
        //Swift.print("insertAt: " + "\(insertAt)")
        
        /**/
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
        func executeCommand(_ command: String, args: [String]) -> NSString {
            let task = Process()
            task.launchPath = command
            task.arguments = args
            let pipe = Pipe()
            task.standardOutput = pipe
            task.launch()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            let output = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            return output!
        }
        
        let commandOutput = executeCommand("/bin/sh", args: ["-c","echo Hello, I am here!"])
        print("Command output: \(commandOutput)")
        
        
    }
    var startTime:NSDate?
    /**
     *
     */
    func shellTesting(){
        Swift.print("shellTesting")
        let repoXML = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)//~/Desktop/repo2.xml
        let repoList = XMLParser.toArray(repoXML)//or use dataProvider
        
        
        self.startTime = NSDate()//measure the time of the refresh
        //let result:String = ShellUtils.run("ls","~/_projects/_code/_active/swift/Element-iOS")
        //Swift.print("result: " + "\(result)")
        let cd = "~/_projects/_code/_active/swift/GitSyncOSX".tildePath//"~/_projects/_code/_active/swift/Element-iOS"
        _ = cd
        let task = Process()
        //task.currentDirectoryPath = cd
        task.launchPath = "~/Desktop/my_script.sh"//"/bin/sh"//"/usr/bin/env"//"/bin/bash"//
        //let logCMD:String = " --pretty=format:Hash:%h%nAuthor:%an%nDate:%ci%nSubject:%s%nBody:%b"//"-3 --oneline"//
        //let cmd:String = "head~" + "0" + logCMD + " --no-patch"//--no-patch suppresses the diff output of git show
        
        //convert the logItem to Tupple
        //let argument:String = "git show " + cmd
        var args:[String] = []
        repoList.forEach{
            let localPath:String = $0["local-path"]!.tildePath
            let gitCMD = "git rev-list HEAD --count"
            args += ["cd " + localPath, gitCMD]//["echo", "hello world","  echo","again","&& echo again","\n echo again"]//["ls"]//"-c", "/usr/bin/killall Dock",
        }
        task.arguments = args
        task.environment = ["LC_ALL" : "en_US.UTF-8","HOME" : NSHomeDirectory()]
        let pipe = Pipe()
        task.standardOutput = pipe
        
        //NSNotificationCenter.defaultCenter().addObserverForName(NSTaskDidTerminateNotification, object: task, queue: nil, usingBlock:handler)/*{ notification in})*/
        
        task.launch()
        task.waitUntilExit()
        let data:Data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output:String = NSString(data:data, encoding:String.Encoding.utf8.rawValue) as! String
        Swift.print("output: " + "\(output)")
        Swift.print("task.terminationStatus: " + "\(task.terminationStatus)")
        Swift.print("Time: " + "\(abs(self.startTime!.timeIntervalSinceNow))")
    }
    func handler(notification:Notification) {
        Swift.print("Time: " + "\(abs(startTime!.timeIntervalSinceNow))")/*How long did the gathering of git commit logs take?*/
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
        func trim(_ str:String){
            let pattern = "^(?:'?\n*)(.*?)(?:\n*'?)$"//"(?:^'?\n*)(.*?)(?:(\n+?'?$)|('$)|$)"
            let options:NSRegularExpression.Options = [.caseInsensitive, .dotMatchesLineSeparators]
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
     * Test for commiting and pushing
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
        
        //GitSync.initCommit(repoList[1], "master")
        //GitSync.initPush(repoList[1], "master")
        
    }
    /**
     * Compacts the description of a commit (test)
     */
    func compactBody(){
        var bodyStr:String = ""
        bodyStr += "'"
        bodyStr += "\n"
        bodyStr += "\r"
        bodyStr += "Modified 1 file:\n"
        bodyStr += "README.md\n"
        bodyStr += "'"
        
        Swift.print("bodyStr: " + "\(bodyStr)")
        
        let compactBody = GitLogParser.compactBody(bodyStr)
        Swift.print("---compactBody-start---")
        Swift.print(compactBody)
        Swift.print("---compactBody-end---")
    }
    func sortTest(){

        //Create a CommitData tuple object
        let a:(author:String,date:Int,subject:String,body:String) = (author:"eonist",date:20161203165939,subject:"a",body:"")
        let b:(author:String,date:Int,subject:String,body:String) = (author:"eonist",date:20161205165939,subject:"b",body:"")
        let c:(author:String,date:Int,subject:String,body:String) = (author:"eonist",date:20161201165939,subject:"c",body:"")
        
        //make a few items that you can sort
        
        var customArray = [a,b,c]
        customArray.sort { (element1, element2) -> Bool in
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
        
        let date:Date = GitDateUtils.date(commitData.date)
        Swift.print("date.shortDate: " + "\(date.shortDate)")
    }
    /**
     *
     */
    func relativeTimeTest(){
        let today:Date = Date()
        Swift.print("today.shortDate: " + "\(today.shortDate)")
        
        let threeDaysAgo = today.offsetByDays(-3)
        Swift.print("threeDaysAgo!.shortDate: " + "\(threeDaysAgo.shortDate)")
        
        let relativeTime = DateParser.relativeTime(today,threeDaysAgo)
        Swift.print("relativeTime: " + "\(relativeTime)")
    }
}
