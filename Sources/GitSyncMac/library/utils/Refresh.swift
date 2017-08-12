import Foundation
@testable import Utils

typealias CommitDPRefresher = Refresh//temp
/**
 * Basically creates/updates a list of the latest commits
 */
class Refresh{
    var dp:CommitDP
    lazy var performanceTimer:Date = Date()/*Debugging*/
//    var totalCommitCount:Int = 0
//    var commitCount:Int = 0
//    var commitsCompletedCount:Int = 0
    init(_ commitDP:CommitDP){
        self.dp = commitDP
    }
}
extension Refresh{
    typealias RefreshComplete = ()->Void
    typealias CommitItemsComplete = (_ results:[String])->Void
    typealias RefreshRepoComplete = ()->Void
    /**
     * Adds commits to CommitDB
     * PARAM: onAllRefreshComplete: When all repos has refreshed this method signature is called (aka The final complete call)
     * NOTE: This method is called after AutoSync has completed
     */
    func initRefresh(_ onAllRefreshComplete:@escaping RefreshComplete){
        Swift.print("🔄🔄🔄 Refresh.initRefresh() ")
        //        self.onAllRefreshComplete = onAllRefreshComplete
        _ = performanceTimer/*Measure the time of the refresh*/
        //        refreshRepos()//🚪⬅️️Enter refresh process here
        //        Swift.print("Refresh.refreshRepos")
        let repos:[RepoItem] = RepoUtils.repoListFlattenedOverridden/*creates array from xml or cache*/
        //        Swift.print("repos.count: " + "\(repos.count)")
        let group = DispatchGroup()
        
        repos.forEach { repo in
            Swift.print("repo.title: " + "\(repo.title)")
            group.enter()
            refreshRepo(repo,{group.leave()})//🚪⬅️️ 🚧 0~1000's of a-sync 💼->🐚->🌵 calls
        }
        group.notify(queue: main, execute: {/*All repo items are now refreshed, the entire refresh process is finished*/
            //Swift.print("💾 Refresh.onRefreshReposComplete() Written to disk")
            CommitDPCache.write(self.dp)/*write data to disk, we could also do this on app exit*/
            Swift.print("🔄 Refresh.allRefreshesCompleted() ⏰ Time: " + "\(self.performanceTimer.secsSinceStart)")/*How long did the gathering of git commit logs take?*/
            onAllRefreshComplete()/*🚪➡️️  Calls a dynamic onComplete method, other classes can override this variable to get callback*/
        })
    }
    /**
     * Adds commit items to CommitDB if they are newer than the oldest commit in CommitDB
     * Retrieve the commit log items for this repo with the range specified
     */
    private func refreshRepo(_ repo:RepoItem,_ onComplete:@escaping RefreshRepoComplete){
        Swift.print("RefreshUtils.refreshRepo \(repo.title) 🔄💾")
        func onCommitItemsCompleted(_ results:[String]){
            //            Swift.print("🍌🍌🍌 Refresh.swift RefreshUtils.getCommitItems competed: \(repo.title) results.count: \(results.count)" )
            results.forEach { result in
                if !result.isEmpty {/*resulting string must have characters*/
                    let commitData:CommitData = CommitDataUtils.convert(raw:result)/*Compartmentalizes the result into a Tuple*/
                    let commitDict:[String:String] = CommitViewUtils.processCommitData(repo.title, commitData)
                    dp.addCommitItem(commitDict)/* 🏁 add the commit log items to the CommitDB*/
                }
            }
            onComplete()/*🚪➡️️*/
        }
        func onCommitCountComplete(_ commitCount:Int){/*once these completes then do result, you do not want to wait until calling refreshRepo*/
            //            Swift.print("💙 RefreshUtils.refreshRepo().onCommitCountComplete \(repo.title): commitCount: " + "\(commitCount)")
            commitItems(repo.local, commitCount, onCommitItemsCompleted)//🚧0~100 Git calls/*creates an array raw commit item logs, from repo*/
        }
        commitCount(dp,repo,onCommitCountComplete)//🚪⬅️️
    }
    /**
     * Find the range of commits to add to CommitDB for this repo
     */
    private func commitCount(_ dp:CommitDP,_ repo:RepoItem, _ onComplete:@escaping (_ commitCount:Int)->Void) {
        var commitCount:Int = 0
        var totCommitCount:Int = 0
        let group = DispatchGroup()
        group.enter()
        bg.async {
            let totCommitCountStr:String = GitUtils.commitCount(repo.local)
            totCommitCount = totCommitCountStr.int//🚧1 Git call/*Get the total commitCount of this repo*/
            if totCommitCount > 0 {totCommitCount = totCommitCount - 1}//why is this?
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
    private func commitItems(_ localPath:String,_ limit:Int, _ onComplete:@escaping CommitItemsComplete) {
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
