import Foundation

class PopulateCommitDB {
    var startTime:NSDate
    var sortableRepoList:[(repo:[String:String],freshness:CGFloat)] = []//we may need more precision than CGFloat, consider using Double or better
    init(){
        startTime = NSDate()//measure the time of the refresh
        refresh()
    }
    /**
     *
     */
    func refresh(){
        freshnessSort()
        
        //copy over the iterate code
            //use generic git methods instead of the custom NSNotification code
            //on a bg-thread -> for loop each task then -> jump on the mainThread when complete -> update UI
        
        
        //Swift.print("repoList.count: " + "\(repoList.count)")
        
        //sort repos by freshness: (makes the process of populating CommitsDB much faster)
        //we run the sorting algo on a bg thread as serial work (one by one) and then notifying mainThread on allComplete
        
        
        //get the 100 last commits from every repo:
            //we populate the CommitsDB on a bg thread as serial work (one by one) and then notifying mainThread on allComplete
            //for each repo in sortedRepos (aka sorted by freshness)
                //get commit count
                //retrive only commits that are newer than the most distante time in the CommitsDB 
        
        //add new commits to CommitDB with a binarySearch
        
    }
    /**
     *
     */
    func freshnessSort(){
        async(bgQueue, { () -> Void in//run the task on a background thread
            let repoXML = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)//~/Desktop/repo2.xml
            let repoList = XMLParser.toArray(repoXML)//or use dataProvider
            repoList.forEach{/*sort the repoList based on freshness*/
                let localPath:String = $0["local-path"]!
                let freshness:CGFloat = CommitDBUtils.freshness(localPath)
                self.sortableRepoList.append(($0,freshness))
            }
            self.sortableRepoList.sortInPlace({$0.freshness > $1.freshness})//sort
            async(mainQueue){/*jump back on the main thread*/
                self.onFreshnessSortComplete()
            }
        })
    }
    /**
     *
     */
    func refreshRepo(index:Int,_ element:[String:String]){
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
     *
     */
    func onFreshnessSortComplete(){
        Swift.print("onFreshnessSortComplete")
        sortableRepoList.forEach{Swift.print($0.repo["title"])}
        Swift.print("Time:-> " + "\(abs(startTime.timeIntervalSinceNow))")/*How long it took*/
    }
}
