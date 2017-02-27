import Foundation
@testable import Utils
/*Storage tuple for the GitSyncAPp*/
typealias RepoItem = (localPath:String,interval:Int,branch:String,keyChainItemName:String,broadcast:Bool,title:String,subscribe:Bool,autoSync:Bool,remotePath:String)
typealias FreshnessUtils = RefreshUtils//temp
class RefreshUtils{
    
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
        let totCommitCount:Int = GitUtils.commitCount(localPath).int-3//you may need to build a more robust commitCount method, it may be that there is a newLine etc
        //Swift.print("totCommitCount: " + "\(totCommitCount)")
        let index:Int = totCommitCount < 100 ? totCommitCount : 100
        var date:Date = Date()
        let now:Int = DateParser.descendingDate(date).int
        if(index > 0){//if the repo has commits
            let cmd:String = "head~"+index.string+" " + "--pretty=format:%ci".encode()! + " --no-patch"
            //Swift.print("cmd: " + "\(cmd)")
            let commitDate:String = GitParser.show(localPath, cmd)
            //Swift.print("commitDate: " + "\(commitDate)")
            date = GitDateUtils.date(commitDate)
        }
        let descendingDate:Int = DateParser.descendingDate(date).int
        let timeAgo:Int = now - descendingDate//now - 2min ago = 120...etc
        let ratio:CGFloat = index.cgFloat / timeAgo.cgFloat// -> commits per second (we use seconds as timeunit to get more presicion)
        return ratio
    }
}
