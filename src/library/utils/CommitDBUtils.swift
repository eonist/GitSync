import Foundation
//1. you create many Operations that store Task and Pipe
//2. you then fire them of at once and listen to the last operation to complete
//3. when the last operation completes you loop thorugh the operations to retrive the data

class CommitDBUtils {
    static var operations:[(task:NSTask,pipe:NSPipe,repoTitle:String)] = []
    /**
     *
     */
    static func refresh(commitDB:CommitDB){
        //1. You loop the repos
        let repoXML = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)//~/Desktop/repo2.xml
        let repoList = XMLParser.toArray(repoXML)//or use dataProvider
        //repoList = [repoList[1]]
        Swift.print("repoList.count: " + "\(repoList.count)")
        repoList.forEach{/*Loops through repos*/
            let localPath:String = $0["local-path"]!//local-path to repo
            let repoTitle = $0["title"]!//name of repo
            //2. find the range of commits to add to CommitDB for this repo
            if(commitDB.sortedArr.count >= 100){
                let lastDate = commitDB.sortedArr.last!.sortableDate
                let gitTime = Utils.gitTime(lastDate.string)
                let commitCount = GitParser.commitCount(localPath, after: gitTime).int//now..lastDate
                let args:[String] = CommitViewUtils.commitItems(localPath,commitCount)/*creates an array of arguments that will return commit item logs*/
                args.forEach{
                    let operation = CommitViewUtils.configOperation([$0],localPath,repoTitle)/*setup the NSTask correctly*/
                    operations.append(operation)
                }
            }else {//< 100
                
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
            //Swift.print(output)
            let commitData = GitLogParser.commitData(output)/*Compartmentalizes the result into a Tuple*/
            let processedCommitData = CommitViewUtils.processCommitData($0.repoTitle,commitData)/*Format the data*/
            commitItems.append(processedCommitData)/*We store the full hash in the CommitData and in the dp item, so that when you click on an item you can generate all commit details in the CommitDetailView*/
            //Do something here🏀
            
        }
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