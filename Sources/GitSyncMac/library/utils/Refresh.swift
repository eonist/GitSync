import Foundation
@testable import Utils

typealias CommitDPRefresher = Refresh//temp
/**
 * Basically creates/updates a list of the latest commits
 */
class Refresh{//TODO:rename to refresh
    var commitDP:CommitDP?
    var startTime:NSDate?/*Debugging*/
    //var isRefreshing:Bool = false/*avoids refreshing when the refresh has already started*/
    var onComplete:()->Void = {print("⚠️️⚠️️⚠️️ Refresh.onComplete() completed but no onComplete is currently attached")}
    init(_ commitDP:CommitDP){
        self.commitDP = commitDP
    }
    /**
     * Inits the refresh process
     */
    func initRefresh(){
        Swift.print("🔄 Refresh.initRefresh() ")
        //isRefreshing = true/*avoid calling refresh when this is true, it is set to false on completion*/
        startTime = NSDate()/*Measure the time of the refresh*/
        refreshRepos()//🚪⬅️️Enter refresh process here
    }
    /**
     * Adds commits to CommitDB
     * NOTE: This method is called from the freshness onComplete
     */
    func refreshRepos(/*_ sortableRepoList:[FreshnessItem]*/){
        let repos = RepoUtils.repoListFlattened/*creates array from xml or cache*/
        var idx:Int = 0
        func onComplete(){/*you can probably use DispatchGroup here aswell. but in the spirit of moving on*/
            idx += 1
            //Swift.print("refreshRepo.onComplete() i: \(idx)")
            if(idx == repos.count){
                onRefreshReposComplete()
            }
        }
        repos.forEach { repo in
            RefreshUtils.refreshRepo(self.commitDP!,repo,onComplete)//🚪⬅️️ 🚧 0~1000's of a-sync 💼->🐚->🌵 calls
        }
    }
    /**
     * The final complete call
     */
    func onRefreshReposComplete(){/*All repo items are now refreshed, the entire refresh process is finished*/
        //Swift.print("onRefreshReposComplete()")
        //Swift.print("commitDB.sortedArr.count: " + "\(commitDP!.items.count)")
        //Swift.print("Printing sortedArr after refresh: ")
        //commitDP!.items.forEach{
            //Swift.print("hash: \($0["hash"]!) date: \(GitDateUtils.gitTime($0["sortableDate"]!)) repo: \($0["repo-name"]!) ")
        //}
        //
        CommitDPCache.write(commitDP!)//write data to disk, we could also do this on app exit
        //Swift.print("💾 Refresh.onRefreshReposComplete() Written to disk")
        //isRefreshing = false
        Swift.print("⏰ Refresh.onRefreshReposComplete() Time: " + "\(abs(startTime!.timeIntervalSinceNow))")/*How long did the gathering of git commit logs take?*/
        onComplete()/*🚪➡️️  calls a dynamic onComplete method, other classes can override this variable to get callback*/
    }
}
class RefreshUtils{
    /**
     * Adds commit items to CommitDB if they are newer than the oldest commit in CommitDB
     * Retrieve the commit log items for this repo with the range specified
     */
    static func refreshRepo(_ dp:CommitDP,_ repo:RepoItem,_ onComplete:@escaping ()->Void){
        func onCommitItemsCompleted(_ results:[String]){
            Swift.print("🍌🍌🍌 RefreshUtils.onCommitItemsCompleted(): results.count: \(results.count)" )
            results.forEach { result in
                if(result.count > 0){/*resulting string must have characters*/
                    let commitData:CommitData = GitLogParser.commitData(result)/*Compartmentalizes the result into a Tuple*/
                    //let commit:Commit = CommitViewUtils.processCommitData(repoTitle,commitData,0)/*Format the data*/
                    let commitDict:[String:String] = CommitViewUtils.processCommitData(repo.title, commitData, 0)//<---TODO:add repo idx here
                    dp.addCommitItem(commitDict)/* 🏁 add the commit log items to the CommitDB*/
                }else{
                    //Swift.print("RefreshUtils.refreshRepo() ERROR: repo: \(repo.title) at result index: \(i) didn't have any characters")
                }
            }//if results.count == 0 then -> no commitItems to append (because they where to old or non existed)
            onComplete()/*🚪➡️️*/
        }
        //once these completes then do result, you do not want to wait until calling refreshRepo
        func onCommitCountComplete(_ commitCount:Int){
            //Swift.print("💙 RefreshUtils.refreshRepo() \(repo.title): commitCount: " + "\(commitCount)")
            RefreshUtils.commitItems(repo.localPath, commitCount, onCommitItemsCompleted)//🚧0~100 Git calls/*creates an array raw commit item logs, from repo*/
        }
        commitCount(dp,repo,onCommitCountComplete)//🚪⬅️️
    }
    /**
     * Find the range of commits to add to CommitDB for this repo
     */
    private static func commitCount(_ dp:CommitDP,_ repo:RepoItem, _ onComplete:@escaping (_ commitCount:Int)->Void) {
        var commitCount:Int = 0
        var totCommitCount:Int = 0
        let group = DispatchGroup()
        bg.async {//do some work
            group.enter()
            totCommitCount = GitUtils.commitCount(repo.localPath).int - 1//🚧1 Git call/*Get the total commitCount of this repo*/
            group.leave()
        }
        if(dp.items.count > 0){
            let lastDate:Int = dp.items.last!["sortableDate"]!.int/*the last date is always the furthest distant date 19:59,19:15,19:00 etc*/
            let gitTime = GitDateUtils.gitTime(lastDate.string)/*converts descending date to git time*/
            bg.async {/*maybe do some work*/
                group.enter()
                let rangeCount:Int = GitUtils.commitCount(repo.localPath, after: gitTime).int//🚧1 Git call /*Finds the num of commits from now until */
                commitCount = min(rangeCount,100)/*force the value to be no more than max allowed*/
                group.leave()
            }
        }else {//< 100
             commitCount  = (100)//You need to top up dp with 100 if dp.count = 0, ⚠️️ this works because later this value is cliped to max of repo.commits.count
        }
        group.notify(queue: main, execute: {/*⚠️️ Notice how the queue is set to main, this enables updating the ui while items are added rather than all in one go*/
            let clippedCommitCount = Swift.min(totCommitCount,commitCount)
            onComplete(clippedCommitCount)/*🚪➡️️*/
        })
    }
    /**
     * Basically creates an array of commit data from the latest commit until limit (limit:3 returns the 3 last commits)
     * Returns an array of commitItems at PARAM: localPath and limited with PARAM: max
     * PARAM: limit = max Items Allowed per repo
     */
    static func commitItems(_ localPath:String,_ limit:Int, _ onComplete:@escaping (_ results:[String])->Void) {
        let group = DispatchGroup()
        var results:[String] = Array(repeating: "", count: limit)
        let formating:String = "--pretty=format:Hash:%h%nAuthor:%an%nDate:%ci%nSubject:%s%nBody:%b".encode()!//"-3 --oneline"//
        for i in 0..<limit{
            let cmd:String = "head~" + "\(i) " + formating + " --no-patch"
            bg.async{/*inner*/
                group.enter()
                let result:String = GitParser.show(localPath, cmd)//🚧 git call//--no-patch suppresses the diff output of git show
                main.async {
                    results[i] = result//results.append(result)
                }
                group.leave()
            }
        }
        //group.wait()
        group.notify(queue: bg, execute: {//TODO: reaplce bg with main, then remove main.async. just call onComplete?
            main.async {/*Jump back on the main thread bc: onComplete resides there*/
                //Swift.print("🏁 Utils.commitItems() all results completed results.count: \(results.count)")
                onComplete(results.reversed()) //reversed is a temp fix
            }
        })
    }
}
