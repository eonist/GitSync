import Foundation
@testable import Utils

typealias CommitDPRefresher = Refresh//temp
/**
 * Basically creates/updates a list of the latest commits
 */
class Refresh{
    var dp:CommitDP
    lazy var performanceTimer:Date = Date()/*Debugging*/
    /**
     * Adds commits to CommitDB
     * PARAM: onAllRefreshComplete: When all repos has refreshed this method signature is called (aka The final complete call)
     * NOTE: This method is called after AutoSync has completed
     */
    init(_ commitDP:CommitDP,_ onReposRefreshComplete:@escaping RefreshReposComplete){
        self.dp = commitDP
        Swift.print("🔄🔄🔄 Refresh.initRefresh() ")
        _ = performanceTimer/*Measure the time of the refresh*/
        let repos:[RepoItem] = RepoUtils.repoListFlattenedOverridden/*creates array from xml or cache*/
        let group = DispatchGroup()
        repos.forEach { repo in
            group.enter()
            refreshRepo(repo,{group.leave()})/*Bulk refresh*/
        }
        group.notify(queue: main, execute: {/*All repo items are now refreshed, the entire refresh process is finished*/
            CommitDPCache.write(self.dp)/*write data to disk, we could also do this on app exit*/
            Swift.print("🔄 Refresh.allRefreshesCompleted() ⏰ Time: " + "\(self.performanceTimer.secsSinceStart)")/*How long did the gathering of git commit logs take?*/
            onReposRefreshComplete()
        })
    }
}
extension Refresh{
    typealias RefreshReposComplete = ()->Void
    typealias RefreshRepoComplete = ()->Void
    typealias CommitItemsComplete = (_ results:[String])->Void
    typealias CommitCountComplete = (_ commitCount:Int)->Void
    /**
     * Adds commit items to CommitDB if they are newer than the oldest commit in CommitDB
     * Retrieve the commit log items for this repo with the range specified
     */
    fileprivate func refreshRepo(_ repo:RepoItem,_ onRefreshRepoComplete:@escaping RefreshRepoComplete){
        Refresh.commitCount(dp,repo){ commitCount in/*once these completes then do result, you do not want to wait until calling refreshRepo*/
            Refresh.commitItems(repo.local, commitCount) { results in //🚧0~100 Git calls/*creates an array raw commit item logs, from repo*/
                results.forEach { result in
                    if !result.isEmpty {/*resulting string must have characters*/
                        self.dp.add(rawCommitData: result, repo.title)/* 🏁 add the commit log items to the CommitDB*/
                    }
                }
                onRefreshRepoComplete()
            }
        }
    }
    /**
     * Find the range of commits to add to CommitDB for this repo
     */
    static private func commitCount(_ dp:CommitDP,_ repo:RepoItem, _ onComplete:@escaping CommitCountComplete) {
        var commitCount:Int = 0
        var totCommitCount:Int = 0
        let group = DispatchGroup()
        group.enter()
        bg.async {
            totCommitCount = GitUtils.commitCount(repo.local)
            group.leave()
        }
        group.enter()
        bg.async {
            if !dp.items.isEmpty {
                let lastDate:Int = dp.items.last!["sortableDate"]!.int/*the last date is always the furthest distant date 19:59,19:15,19:00 etc*/
                let gitTime:String = GitDateUtils.gitTime(lastDate.string)/*converts descending date to git time*/
                let rangeCount:Int = GitUtils.commitCount(repo.local, after: gitTime).int//🚧1 Git call /*Finds the num of commits from now until */
                commitCount = min(rangeCount,100)/*force the value to be no more than max allowed*/
            }else {//< 100
                commitCount = 100//You need to top up dp with 100 if dp.count = 0, ⚠️️ this works because later this value is cliped to max of repo.commits.count
            }
            group.leave()
        }
        group.notify(queue: main){
            let clippedCommitCount = Swift.min(totCommitCount,commitCount)
            onComplete(clippedCommitCount)/*🚪➡️️*/
        }
    }
    /**
     * Basically creates an array of commit data from the latest commit until limit (limit:3 returns the 3 last commits)
     * Returns an array of commitItems at PARAM: localPath and limited with PARAM: max
     * PARAM: limit = max Items Allowed per repo
     */
    static private func commitItems(_ localPath:String,_ limit:Int, _ onComplete:@escaping CommitItemsComplete) {
        var results:[String] = Array(repeating: "", count:limit)//basically creates an array with many empty strings
        let group = DispatchGroup()
        let formating:String = "--pretty=format:Hash:%h%nAuthor:%an%nDate:%ci%nSubject:%s%nBody:%b".encode()!//"-3 --oneline"//
//        totalCommitCount += limit
        for i in 0..<limit{
//            commitCount += 1
            group.enter()
            bg.async{/*inner*/
                let cmd:String = "head~" + "\(i) " + formating + " --no-patch"
                let result:String = GitParser.show(localPath, cmd)/*🌵*/
                main.async {
                    results[i] = result
                    group.leave()
                }
            }
        }
        group.notify(queue: main){
            //Swift.print("🏁 Utils.commitItems() all results completed results.count: \(results.count)")
            onComplete(results.reversed()) //reversed is a temp fix/*Jump back on the main thread bc: onComplete resides there*/
        }
    }
}
