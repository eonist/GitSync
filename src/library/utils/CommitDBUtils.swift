import Foundation
//1. you create many Operations that store Task and Pipe
//2. you then fire them of at once and listen to the last operation to complete
//3. when the last operation completes you loop thorugh the operations to retrive the data


//Continue here: 
    //CommitListRefresh algo ✅
    //Clean up the code, make comments, rename methods etc, maybe make a singleton? 🏀
    //then do storing and unwrapping of commitDB combined with the refresh algo (only a few additions should be added on each refresh, and refresh time will be fast)
    //then try adding and updating the CommitViewList with some dummy data before you hock up the refresh algo
    //then hook up the refresh algo to the animation
    //Research background thread for NSTask
    //Arrange the repos to make the algo faster
        //ask each repo for what date is attached to commit nr 100  (we try to calc how fresh a repo is) (the freshest repo goes on top)
            //if the repo doesnt have a commit nr  100, then use the farthest commit and get the date. so if it has 10 updates per day we we stipulate how many updates would have been made at this rate if it had 100 commits
            //if a repo doesnt have commits at all, the rate is 0
        //100 commits over 5 days -> 20 commits per day -> commits per day is the number you sort the array with!?!?!?!?


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
        //1. You loop the repos
        let repoXML = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)//~/Desktop/repo2.xml
        repoList = XMLParser.toArray(repoXML)//or use dataProvider
        var sortableRepoList:[(repo:[String:String],freshness:CGFloat)] = []//we may need more precision than CGFloat, consider using Double or better
        repoList.forEach{/*sort the repoList based on freshness*/
            let localPath:String = $0["local-path"]!
            //let freshness:CGFloat = Utils.freshness(localPath)
            //sortableRepoList.append(($0,freshness))
            let totCommitCount:Int = GitUtils.commitCount(localPath).int-2//you may need to build a more robust commitCount method, it may be that there is a newLine etc
            Swift.print("totCommitCount: " + "\(totCommitCount)")
        }
        sortableRepoList.sortInPlace({$0.freshness > $1.freshness})
        sortableRepoList.forEach{Swift.print($0.freshness)}
        Swift.print("Time: " + "\(abs(startTime!.timeIntervalSinceNow))")/*How long did the gathering of git commit logs take?*/
        //Swift.print("repoList.count: " + "\(repoList.count)")
        //for (index,element) in repoList.enumerate(){/*Loops through repos*/
        //}
        //repoList = [repoList[1]]//test with one repo the element ios repo
        //iterate()
    }
    
    //Do a speed test: 🏀
        //query for commitCount for all repos and time it
        //query for dates at index 30 for all repos and time it
            //we may need to pipe the commitCount into the date query, to make things speedy
    
    //to be really speedy you probably need to launch all requests at once and then wait for everything to complete
        //you organize the results in the order they were launched and then start the sorting process 
        //see if you can't get this working on a background thread, or it will freeze your gui
    
    /**
     *
     */
    static func iterate(){
        //Swift.print("iterate: " + "\(repoIndex)")
        if(repoIndex < repoList.count){/*iterate*/
            refreshRepo(repoIndex,repoList[repoIndex])
        }else{/*loop complete*/
            Swift.print("Time: " + "\(abs(startTime!.timeIntervalSinceNow))")/*How long did the gathering of git commit logs take?*/
            Swift.print("commitDB.sortedArr.count: " + "\(commitDB.sortedArr.count)")
            Swift.print("Printing sortedArr after refresh: ")
            /*commitDB.sortedArr.forEach{
                Swift.print("hash: \($0.hash) date: \(Utils.gitTime($0.sortableDate.string)) repo: \($0.repoName) ")
            }*/
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
        //Swift.print("commitDB.sortedArr.count: " + "\(commitDB.sortedArr.count)")
        if(commitDB.sortedArr.count >= 100){
            let firstDate = commitDB.sortedArr.first!.sortableDate
            //Swift.print("firstDate: " + "\(firstDate)")
            let gitTime = GitDateUtils.gitTime(firstDate.string)
            let rangeCount:Int = GitUtils.commitCount(localPath, after: gitTime).int//now..lastDate
            commitCount = rangeCount > 100 ? 100 : rangeCount//force the value to be no more than max allowed
        }else {//< 100
            commitCount = 100 - commitDB.sortedArr.count
        }
        Swift.print("\(repoTitle): rangeCount: " + "\(commitCount)")
        //3. Retrieve the commit log items for this repo with the range specified
        //Swift.print("max: " + "\(commitCount)")
        let args:[String] = CommitViewUtils.commitItems(localPath,commitCount)/*creates an array of arguments that will return commit item logs*/
        if(args.count > 0){
            operations = []//reset the operations array
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
        //Swift.print("the last task completed")
        for (index,element) in operations.enumerate(){
            let data:NSData = element.pipe.fileHandleForReading.readDataToEndOfFile()/*retrive the date from the nstask output*/
            let output:String = NSString(data:data, encoding:NSUTF8StringEncoding) as! String/*decode the date to a string*/
            if(output.count > 0){
                //Swift.print("output: " + ">\(output)<")
                let commitData:CommitData = GitLogParser.commitData(output)/*Compartmentalizes the result into a Tuple*/
                let commit:Commit = CommitViewUtils.processCommitData(element.repoTitle,commitData,element.repoIndex)/*Format the data*/
                //Swift.print("repo: \(element.repoTitle) hash: \(commit.hash) date: \(Utils.gitTime(commit.sortableDate.string))")
                commitDB.add(commit)/*add the commit log items to the CommitDB*/
            }else{
                Swift.print("-----ERROR: repo: \(element.repoTitle) at index: \(index) didnt work")
            }
        }
        NSNotificationCenter.defaultCenter().removeObserver(notification.object!)
        iterate()
    }
}
private class Utils{
    /**
     * Returns freshness of a repo (Basically the rate of commits per second the last 100 commits)
     * NOTE: If you made 50 commits the last 100 seconds that would be a rate at 0.5 commits per second
     * Fresheness = (commits per second for the last 100 commits)
     */
    static func freshness(localPath:String)->CGFloat{
        let totCommitCount:Int = GitUtils.commitCount(localPath).int-2//you may need to build a more robust commitCount method, it may be that there is a newLine etc
        Swift.print("totCommitCount: " + "\(totCommitCount)")
        let index:Int = totCommitCount < 100 ? totCommitCount : 100
        var date:NSDate = NSDate()
        let now:Int = DateParser.descendingDate(date).int
        if(index > 0){//if the repo has commits
            let cmd:String = "head~"+index.string+" --pretty=format:%ci --no-patch"
            let commitDate:String = GitParser.show(localPath, cmd)
            Swift.print("commitDate: " + "\(commitDate)")
            date = GitDateUtils.date(commitDate)
        }
        let descendingDate:Int = DateParser.descendingDate(date).int
        let timeAgo:Int = now - descendingDate//now - 2min ago = 120...etc
        let ratio:CGFloat = index.cgFloat / timeAgo.cgFloat// -> commits per second (we use seconds as timeunit to get more presicion)
        return ratio
    }
}