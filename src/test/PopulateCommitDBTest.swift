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
    func onFreshnessSortComplete(){
        Swift.print("onFreshnessSortComplete")
        sortableRepoList.forEach{Swift.print($0.repo["title"])}
        Swift.print("Time:-> " + "\(abs(startTime.timeIntervalSinceNow))")/*How long it took*/
    }
}
