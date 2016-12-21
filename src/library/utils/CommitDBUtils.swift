import Foundation
//1. you create many Operations that store Task and Pipe
//2. you then fire them of at once and listen to the last operation to complete
//3. when the last operation completes you loop thorugh the operations to retrive the data

class CommitDBUtils {
    static var commitDB = CommitDB()
    static var operations:[CommitLogOperation] = []
    static var startTime:NSDate?
    static var repoIndex:Int = 0
    static var repoList:[[String:String]] = []
    /**
     * TODO: time test
     */
    static func refresh(){//init refresh
        startTime = NSDate()//measure the time of the refresh
        repoIndex = 0//reset
        
        //Continue here:
            //Something is wrong with commit range: print the lastDate and see if you can figure it out 🏀
                //make the max items shorter to debug easier. and make the var static
                    //the problem is that commitDB doesnt have any commits until observer completes
                        //to solve this you need to iterate on complete
        
        
        //1. You loop the repos
        let repoXML = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)//~/Desktop/repo2.xml
        repoList = XMLParser.toArray(repoXML)//or use dataProvider
        Swift.print("repoList.count: " + "\(repoList.count)")
        
        //for (index,element) in repoList.enumerate(){/*Loops through repos*/
        //}
        
        //repoList = [repoList[1]]//test with one repo the element ios repo
        
        iterate()
    }
    /**
     *
     */
    static func iterate(){
        Swift.print("iterate: " + "\(repoIndex)")
        if(repoIndex < repoList.count){
            refreshRepo(repoIndex,repoList[repoIndex])
            
        }else{
            Swift.print("Time: " + "\(abs(startTime!.timeIntervalSinceNow))")/*How long did the gathering of git commit logs take?*/
            Swift.print("commitDB.sortedArr.count: " + "\(commitDB.sortedArr.count)")
        }
    }
    /**
     *
     */
    static func refreshRepo(index:Int,_ element:[String:String]){
        repoIndex += 1//increment the repoIndex
        let localPath:String = element["local-path"]!//local-path to repo
        let repoTitle = element["title"]!//name of repo
        //2. Find the range of commits to add to CommitDB for this repo
        var commitCount:Int
        Swift.print("commitDB.sortedArr.count: " + "\(commitDB.sortedArr.count)")
        if(commitDB.sortedArr.count >= 100){
            let lastDate = commitDB.sortedArr.last!.sortableDate
            Swift.print("lastDate: " + "\(lastDate)")
            let gitTime = Utils.gitTime(lastDate.string)
            let rangeCount:Int = GitParser.commitCount(localPath, after: gitTime).int//now..lastDate
            commitCount = rangeCount > 100 ? 100 : rangeCount//force the value to be no more than max allowed
        }else {//< 100
            commitCount = 100 - commitDB.sortedArr.count
            
            //commitCount = commitCount > repoCommitCount ? repoCommitCount : commitCount/* so that we don't query for commit items that doesnt exist */
        }
        //3. Retrieve the commit log items for this repo with the range specified
        //Swift.print("max: " + "\(commitCount)")
        let args:[String] = CommitViewUtils.commitItems(localPath,commitCount)/*creates an array of arguments that will return commit item logs*/
        if(args.count > 0){
            for (_,element) in args.enumerate(){
                let operation = CommitViewUtils.configOperation([element],localPath,repoTitle,index)/*setup the NSTask correctly*/
                operations.append(operation)
            }
            
            let finalTask = operations[operations.count-1].task/*We listen to the last task for completion*/
            NSNotificationCenter.defaultCenter().addObserverForName(NSTaskDidTerminateNotification, object: finalTask, queue: nil, usingBlock:observer)/*{ notification in})*/
            
            operations.forEach{/*launch all tasks*/
                $0.task.launch()
            }
        }else{//no operations to launch and observe
            iterate()//but we still need to iterate
        }
    }
    /**
     * The handler for the NSTasks
     */
    static func observer(notification:NSNotification) {
        Swift.print("the last task completed")
        
        operations.forEach{
            let data:NSData = $0.pipe.fileHandleForReading.readDataToEndOfFile()/*retrive the date from the nstask output*/
            let output:String = NSString(data:data, encoding:NSUTF8StringEncoding) as! String/*decode the date to a string*/
            if(output.count == 0){Swift.print("output: " + ">\(output)<")}
            let commitData = GitLogParser.commitData(output)/*Compartmentalizes the result into a Tuple*/
            let commit:Commit = CommitViewUtils.processCommitData($0.repoTitle,commitData,$0.repoIndex)/*Format the data*/
            commitDB.add(commit)/*add the commit log items to the CommitDB*/
        }
        
        //Swift.print("Printing sortedArr after refresh: ")
        //commitDB.sortedArr.forEach{Swift.print($0.sortableDate)}
        iterate()
    }
}

private class Utils{
    /**
     * Formats chronological date to git time-> "2016-11-12 00:00:00"
     * NOTE: YYYYMMDDHHmmss -> YYYY-MM-DD HH:mm:ss
     * Alt name: chronologicalTime2GitTime
     * EXAMPLE: gitTime("20161111205959")//Output2016-11-11 20:59:59
     */
    static func gitTime(chronoTime:String)->String{
        let gitTime = chronoTime.insertCharsAt([("-",4),("-",6),(" ",8),(":",10),(":",12)])
        return gitTime
    }
}