import Foundation

class PopulateCommitDB {
    var commitDB = CommitDB()
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
        //copy over the iterate code✅
            //use generic git methods instead of the custom NSNotification code✅
            //on a bg-thread -> for loop each task then -> jump on the mainThread when complete -> update UI ✅
            //print how many commits are retrived for each repo✅
            //bring the caching of CommitDB into the workflow
        
        //Swift.print("repoList.count: " + "\(repoList.count)")
        
        //sort repos by freshness: (makes the process of populating CommitsDB much faster) ✅
        //we run the sorting algo on a bg thread as serial work (one by one) and then notifying mainThread on allComplete ✅
        
        
        //get the 100 last commits from every repo: ✅
            //we populate the CommitsDB on a bg thread as serial work (one by one) and then notifying mainThread on allComplete
            //for each repo in sortedRepos (aka sorted by freshness)
                //get commit count
                //retrive only commits that are newer than the most distante time in the CommitsDB 
        
        //add new commits to CommitDB with a binarySearch ✅
        
    }
    /**
     * Sort the repoList so that the freshest repos are parsed first (optimization)
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
     * Adds commits to CommitDB
     */
    func refreshRepos(){
        async(bgQueue, { () -> Void in/*run the task on a background thread*/
            self.sortableRepoList.forEach{
                self.refreshRepo($0.repo)
            }
            async(mainQueue){/*jump back on the main thread*/
                self.onRefreshReposComplete()
            }
        })
    }
    /**
     * Adds commit items to CommitDB if they are newer than the oldest commit in CommitDB
     */
    func refreshRepo(repo:[String:String]){
        let localPath:String = repo["local-path"]!//local-path to repo
        let repoTitle = repo["title"]!//name of repo
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
        //Swift.print("\(repoTitle): rangeCount: " + "\(commitCount)")
        //3. Retrieve the commit log items for this repo with the range specified
        //Swift.print("max: " + "\(commitCount)")
        let results:[String] = Utils.commitItems(localPath, commitCount)/*creates an array commit item logs, from repo*/
        if(results.count > 0){
            results.forEach{
                if($0.count > 0){
                    //Swift.print("output: " + ">\(output)<")
                    let commitData:CommitData = GitLogParser.commitData($0)/*Compartmentalizes the result into a Tuple*/
                    let commit:Commit = CommitViewUtils.processCommitData(repoTitle,commitData,0)/*Format the data*/
                    //Swift.print("repo: \(element.repoTitle) hash: \(commit.hash) date: \(Utils.gitTime(commit.sortableDate.string))")
                    commitDB.add(commit)/*add the commit log items to the CommitDB*/
                }else{
                    Swift.print("-----ERROR: repo: \(repoTitle) at index: \(index) didnt work")
                }
            }
        }else{
            //no commitItems to append (because they where to old or non existed)
        }
    }
    /**
     *
     */
    func onFreshnessSortComplete(){
        Swift.print("onFreshnessSortComplete")
        sortableRepoList.forEach{Swift.print($0.repo["title"]!)}
        Swift.print("onFreshnessSortComplete() Time:-> " + "\(abs(startTime.timeIntervalSinceNow))")/*How long it took*/
        refreshRepos()
    }
    /**
     *
     */
    func onRefreshReposComplete(){
        Swift.print("commitDB.sortedArr.count: " + "\(commitDB.sortedArr.count)")
        Swift.print("Printing sortedArr after refresh: ")
        commitDB.sortedArr.forEach{
            Swift.print("hash: \($0.hash) date: \(GitDateUtils.gitTime($0.sortableDate.string)) repo: \($0.repoName) ")
        }
        Swift.print("onRefreshReposComplete() Time: " + "\(abs(startTime.timeIntervalSinceNow))")/*How long did the gathering of git commit logs take?*/
        CommitDBCache.write(commitDB)//write data to disk, we could also do this on app exit
    }
    
}


private class Utils{
    /**
     * PARAM: max = max Items Allowed per repo
     */
    static func commitItems(localPath:String,_ max:Int)->[String]{
        let commitCount:Int = GitUtils.commitCount(localPath).int - 1/*Get the commitCount of this repo*/
        //Swift.print("commitCount: " + ">\(commitCount)<")
        let length:Int = commitCount > max ? max : commitCount//20 = maxCount
        //Swift.print("length: \(length) max: \(max)")
        var results:[String] = []
        let formating:String = " --pretty=format:Hash:%h%nAuthor:%an%nDate:%ci%nSubject:%s%nBody:%b"//"-3 --oneline"//
        for i in 0..<length{
            let cmd:String = "head~" + "\(i)" + formating + " --no-patch"
            let result:String = GitParser.show(localPath, cmd)//--no-patch suppresses the diff output of git show
            results.append(result)
        }
        return results
    }
}