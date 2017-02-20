import Foundation
@testable import Utils

//try to make this class as static as possible

class PopulateCommitDB {
    //var commitDB:CommitDB/* = CommitDB()*/
    static var commitDP:CommitDP?
    static var startTime:NSDate?
    static var sortableRepoList:[(repo:[String:String],freshness:CGFloat)] = []//we may need more precision than CGFloat, consider using Double or better
    static var isRefreshing:Bool = false/*avoids refreshing when the refresh has already started*/
    static func refresh(){
        isRefreshing = true
        commitDP = CommitDPCache.read()
        startTime = NSDate()//measure the time of the refresh
        sortableRepoList = []
        PopulateCommitDB.freshnessSort()
    }
    /**
     * Sort the repoList so that the freshest repos are parsed first (optimization)
     */
    static func freshnessSort(){
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
    static func refreshRepos(){
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
    static func refreshRepo(_ repo:[String:String]){
        let localPath:String = repo["local-path"]!//local-path to repo
        let repoTitle = repo["title"]!//name of repo
        //2. Find the range of commits to add to CommitDB for this repo
        var commitCount:Int
        //Swift.print("commitDB.sortedArr.count: " + "\(commitDB.sortedArr.count)")
        if(commitDP!.items.count > 0){
            let firstDate:Int = commitDP!.items.first!["sortableDate"]!.int/*the first date is always the furthest distant date 19:00,19:15,19:59 etc*/
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
                //let commit:Commit = CommitViewUtils.processCommitData(repoTitle,commitData,0)/*Format the data*/
                let commitDict:[String:String] = CommitViewUtils.processCommitData(repoTitle, commitData, 0)
                //Swift.print("repo: \(element.repoTitle) hash: \(commit.hash) date: \(Utils.gitTime(commit.sortableDate.string))")
                commitDP!.add(commitDict)/*add the commit log items to the CommitDB*/
            }else{
                Swift.print("-----ERROR: repo: \(repoTitle) at index: \(index) didnt work")
            }
        }//if results.count == 0 then -> no commitItems to append (because they where to old or non existed)
    }
    /**
     * Freshness level of every repo is calculated
     */
    static func onFreshnessSortComplete(){
        //sortableRepoList.forEach{Swift.print($0.repo["title"]!)}
        Swift.print("💛 onFreshnessSortComplete() Time:-> " + "\(abs(startTime!.timeIntervalSinceNow))")/*How long it took*/
        refreshRepos()
    }
    /**
     * The final complete call
     */
    static func onRefreshReposComplete(){
        Swift.print("commitDB.sortedArr.count: " + "\(commitDP!.items.count)")
        Swift.print("Printing sortedArr after refresh: ")
        commitDP!.items.forEach{
            Swift.print("hash: \($0["hash"]!) date: \(GitDateUtils.gitTime($0["sortableDate"]!)) repo: \($0["repo-name"]!) ")
        }
        Swift.print("💚 onRefreshReposComplete() Time: " + "\(abs(startTime!.timeIntervalSinceNow))")/*How long did the gathering of git commit logs take?*/
        CommitDPCache.write(commitDP!)//write data to disk, we could also do this on app exit
        isRefreshing = false
        Swift.print("Written to disk")
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

