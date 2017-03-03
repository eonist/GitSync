import Foundation
@testable import Utils
/*Storage tuple for the GitSyncAPp*/
typealias RepoItem = (localPath:String,interval:Int,branch:String,keyChainItemName:String,broadcast:Bool,title:String,subscribe:Bool,autoSync:Bool,remotePath:String,autoSyncInterval:String,message:Bool,fileChange:Bool,pullToRequest:Bool)
typealias FreshnessItem = (repo:RepoItem,freshness:CGFloat)
/**
 * Freshness level of every repo is calculated
 */
class Freshness { 
    var onFreshnessSortComplete:(_ sortableRepoList:[FreshnessItem])->Void = {_ in print("⚠️️⚠️️⚠️️ Freshness.onFreshnessSortComplete completed but no onComplete is currently attached")}
    /**
     * Sort the repoList so that the freshest repos are parsed first (optimization)
     * PARAM: repoFilePath: the the repo file contains info about each repo to sort.
     */
    func initFreshnessSort(){
        Swift.print("💜 Freshness.freshnessSort()")
        var sortableRepoList:[FreshnessItem] = []//we may need more precision than CGFloat, consider using Double or better
        let repos = RepoUtils.repoList
        var idx:Int = 0//reset this value onComplete if you plan to reuse the freshness instance
        func onComplete(){
            idx += 1
            if(idx == repos.count){
                /*all freshness calls completed at this point*/
                sortableRepoList.sort(by: {$0.freshness > $1.freshness})/*sorts repos according to freshness, the freshest first the least fresh at the botom*/
                self.onFreshnessSortComplete(sortableRepoList)
            }
        }
        for i in repos.indices{/*sort the repoList based on freshness*/
            let repo = repos[i]
            bgQueue.async{//run the task on a background thread
                let freshness:CGFloat = Utils.freshness(repo.localPath)/*Calls git 2 times*/
                sortableRepoList.append((repo,freshness))
                mainQueue.async{/*Jump back on the main thread*/
                    onComplete()
                }
            }
        }
    }
}
private class Utils{
    /**
     * Returns freshness level of a repo (Basically the rate of commits per second the last 100 commits)
     * NOTE: If you made 50 commits the last 100 seconds that would be a rate at 0.5 commits per second
     * NOTE: It works by finding the date of the commit 100 commits ago from the latest commit, then dividing the timelaps since that date by 100
     * Fresheness = (commits per second for the last 100 commits)
     */
    static func freshness(_ localPath:String)->CGFloat{
        //Swift.print("freshness() localPath: " + "\(localPath)")
        let totCommitCount:Int = GitUtils.commitCount(localPath).int-3//👈Git call/*Returns total commit count for a repo*///TODO: you may need to build a more robust commitCount method, it may be that there is a newLine etc
        //Swift.print("totCommitCount: " + "\(totCommitCount)")
        let index:Int = totCommitCount < 100 ? totCommitCount : 100
        var date:Date = Date()//now
        if(index > 0){//if the repo has commits
            let cmd:String = "head~"+index.string+" " + "--pretty=format:%ci".encode()! + " --no-patch"//cmd that returns "2015-12-03 16:59:09 +0100"
            //Swift.print("cmd: " + "\(cmd)")
            let commitDate:String = GitParser.show(localPath, cmd)//👈Git call
            //Swift.print("commitDate: " + "\(commitDate)")
            date = GitDateUtils.date(commitDate)
        }
        let descendingDate:Int = DateParser.descendingDate(date).int
        let now:Int = DateParser.descendingDate(date).int//Chrono time
        let timeAgo:Int = now - descendingDate//now - 2min ago = 120...etc
        let ratio:CGFloat = index.cgFloat / timeAgo.cgFloat// -> commits per second (we use seconds as timeunit to get more presicion)
        return ratio
    }
}
