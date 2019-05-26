import Foundation
@testable import Utils

typealias CommitDPRefresher = Refresh//temp
/**
 * Basically creates/updates a list of the latest commits
 */
class Refresh{
    var dp:CommitDP//TODO: ⚠️️ make this lazy
    lazy var performanceTimer:Date = Date()/*Debugging*/
    /**
     * Adds commits to CommitDB
     * PARAM: onAllRefreshComplete: When all repos has refreshed this method signature is called (aka The final complete call)
     * NOTE: This method is called after AutoSync has completed
     */
    init(dp commitDP:CommitDP, repoList:[RepoItem], onComplete onReposRefreshComplete:@escaping RefreshReposComplete){
        self.dp = commitDP
        Swift.print("🔄🔄🔄 Refresh.initRefresh() ")
        _ = performanceTimer/*Measure the time of the refresh*/
        //let repos:[RepoItem] = RepoUtils.repoListFlattenedOverridden/*creates array from xml or cache*/
        let group = DispatchGroup()
        repoList.forEach { repo in
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
