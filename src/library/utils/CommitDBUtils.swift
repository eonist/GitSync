import Foundation
//1. you create many Operations that store Task and Pipe
//2. you then fire them of at once and listen to the last operation to complete
//3. when the last operation completes you loop thorugh the operations to retrive the data

class CommitDBUtils {
    static var commitDB = CommitDB()
    static var operations:[CommitLogOperation] = []
    /**
     * TODO: time test
     */
    static func refresh(){
        //1. You loop the repos
        let repoXML = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)//~/Desktop/repo2.xml
        let repoList = XMLParser.toArray(repoXML)//or use dataProvider
        Swift.print("repoList.count: " + "\(repoList.count)")
        //repoList = [repoList[1]]//test with one repo the element ios repo
        for (index,element) in repoList.enumerate(){/*Loops through repos*/
            let localPath:String = element["local-path"]!//local-path to repo
            let repoTitle = element["title"]!//name of repo
            //2. Find the range of commits to add to CommitDB for this repo
            var commitCount:Int
            if(commitDB.sortedArr.count >= 100){
                let lastDate = commitDB.sortedArr[99].sortableDate
                let gitTime = Utils.gitTime(lastDate.string)
                commitCount = GitParser.commitCount(localPath, after: gitTime).int//now..lastDate
            }else {//< 100
                commitCount = 100 - commitDB.sortedArr.count
                
                //commitCount = commitCount > repoCommitCount ? repoCommitCount : commitCount/* so that we don't query for commit items that doesnt exist */
            }
            //3. Retrieve the commit log items for this repo with the range specified
            //Swift.print("max: " + "\(commitCount)")
            let args:[String] = CommitViewUtils.commitItems(localPath,commitCount)/*creates an array of arguments that will return commit item logs*/
            for (_,element) in args.enumerate(){
                let operation = CommitViewUtils.configOperation([element],localPath,repoTitle,index)/*setup the NSTask correctly*/
                operations.append(operation)
            }
        }
        let finalTask = operations[operations.count-1].task/*We listen to the last task for completion*/
        NSNotificationCenter.defaultCenter().addObserverForName(NSTaskDidTerminateNotification, object: finalTask, queue: nil, usingBlock:observer)/*{ notification in})*/
        
        operations.forEach{/*launch all tasks*/
            $0.task.launch()
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
  
        Swift.print("commitDB.sortedArr.count: " + "\(commitDB.sortedArr.count)")
        //Swift.print("Printing sortedArr after refresh: ")
        //commitDB.sortedArr.forEach{Swift.print($0.sortableDate)}
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