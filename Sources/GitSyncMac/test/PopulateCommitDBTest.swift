import Foundation
@testable import Utils

class PopulateCommitDB {
    var commitDB:CommitDB/* = CommitDB()*/
    var startTime:NSDate
    var sortableRepoList:[(repo:[String:String],freshness:CGFloat)] = []//we may need more precision than CGFloat, consider using Double or better
    init(){
        commitDB = CommitDBCache.read()
        startTime = NSDate()//measure the time of the refresh
        refresh()
    }
    func refresh(){
        freshnessSort()
    }
    /**
     * Sort the repoList so that the freshest repos are parsed first (optimization)
     */
    func freshnessSort(){
        Swift.print("💜 freshnessSort()")
        async(bgQueue, { () -> Void in//run the task on a background thread
            let repoXML = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)//~/Desktop/repo2.xml
            let repoList = XMLParser.toArray(repoXML)//or use dataProvider
            repoList.forEach{/*sort the repoList based on freshness*/
                let localPath:String = $0["local-path"]!
                let freshness:CGFloat = CommitDBRefreshTest.freshness(localPath)
                self.sortableRepoList.append(($0,freshness))
            }
            self.sortableRepoList.sort(by: {$0.freshness > $1.freshness})/*sorts repos according to freshness, the freshest first the least fresh at the botom*/
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
            self.sortableRepoList.forEach{/*the arr is already sorted from freshest to least fresh*/
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
    func refreshRepo(_ repo:[String:String]){
        let localPath:String = repo["local-path"]!//local-path to repo
        let repoTitle = repo["title"]!//name of repo
        //2. Find the range of commits to add to CommitDB for this repo
        var commitCount:Int
        //Swift.print("commitDB.sortedArr.count: " + "\(commitDB.sortedArr.count)")
        if(commitDB.sortedArr.count > 0){
            let firstDate = commitDB.sortedArr.first!.sortableDate/*the first date is always the furthest distant date 19:00,19:15,19:59 etc*/
            //Swift.print("firstDate: " + "\(firstDate)")
            let gitTime = GitDateUtils.gitTime(firstDate.string)/*converts descending date to git time*/
            let rangeCount:Int = GitUtils.commitCount(localPath, after: gitTime).int/*Finds the num of commits from now until */
            commitCount = min(rangeCount,100)/*force the value to be no more than max allowed*/
        }else {//< 100
            commitCount = 100
        }
        Swift.print("💙\(repoTitle): rangeCount: " + "\(commitCount)")
        //3. Retrieve the commit log items for this repo with the range specified
        //Swift.print("max: " + "\(commitCount)")
        let results:[String] = Utils.commitItems(localPath, commitCount)/*creates an array commit item logs, from repo*/
        results.forEach{
            if($0.count > 0){//resulting string must have characters
                //Swift.print("output: " + ">\(output)<")
                let commitData:CommitData = GitLogParser.commitData($0)/*Compartmentalizes the result into a Tuple*/
                let commit:Commit = CommitViewUtils.processCommitData(repoTitle,commitData,0)/*Format the data*/
                //Swift.print("repo: \(element.repoTitle) hash: \(commit.hash) date: \(Utils.gitTime(commit.sortableDate.string))")
                commitDB.add(commit)/*add the commit log items to the CommitDB*/
            }else{
                Swift.print("-----ERROR: repo: \(repoTitle) at index: \(index) didnt work")
            }
        }//if results.count == 0 then -> no commitItems to append (because they where to old or non existed)
    }
    /**
     * Freshness level of every repo is calculated
     */
    func onFreshnessSortComplete(){
        //sortableRepoList.forEach{Swift.print($0.repo["title"]!)}
        Swift.print("💛 onFreshnessSortComplete() Time:-> " + "\(abs(startTime.timeIntervalSinceNow))")/*How long it took*/
        refreshRepos()
    }
    /**
     * The final complete call
     */
    func onRefreshReposComplete(){
        Swift.print("commitDB.sortedArr.count: " + "\(commitDB.sortedArr.count)")
        Swift.print("Printing sortedArr after refresh: ")
        commitDB.sortedArr.forEach{
            Swift.print("hash: \($0.hash) date: \(GitDateUtils.gitTime($0.sortableDate.string)) repo: \($0.repoName) ")
        }
        Swift.print("💚 onRefreshReposComplete() Time: " + "\(abs(startTime.timeIntervalSinceNow))")/*How long did the gathering of git commit logs take?*/
        CommitDBCache.write(commitDB)//write data to disk, we could also do this on app exit
    }
}


private class Utils{
    /**
     * Returns an array of commitItems at PARAM: localPath and limited with PARAM: max
     * PARAM: limit = max Items Allowed per repo
     */
    static func commitItems(_ localPath:String,_ limit:Int)->[String]{
        let commitCount:Int = GitUtils.commitCount(localPath).int - 1/*Get the total commitCount of this repo*/
        //Swift.print("commitCount: " + ">\(commitCount)<")
        let length:Int = Swift.min(commitCount,limit)
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

//copy over the iterate code✅
    //use generic git methods instead of the custom NSNotification code✅
    //on a bg-thread -> for loop each task then -> jump on the mainThread when complete -> update UI ✅
    //print how many commits are retrived for each repo✅
    //bring the caching of CommitDB into the workflow ✅

//Swift.print("repoList.count: " + "\(repoList.count)")

//sort repos by freshness: (makes the process of populating CommitsDB much faster) ✅
//we run the sorting algo on a bg thread as serial work (one by one) and then notifying mainThread on allComplete ✅


//get the 100 last commits from every repo: ✅
    //we populate the CommitsDB on a bg thread as serial work (one by one) and then notifying mainThread on allComplete
    //for each repo in sortedRepos (aka sorted by freshness)
        //get commit count
        //retrive only commits that are newer than the most distante time in the CommitsDB 

//add new commits to CommitDB with a binarySearch ✅


