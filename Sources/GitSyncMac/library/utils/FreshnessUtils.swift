import Foundation
@testable import Utils

class FreshnessUtils{
    static var sortableRepoList:[(repo:RepoItem,freshness:CGFloat)] = []//we may need more precision than CGFloat, consider using Double or better
    /**
     * Sort the repoList so that the freshest repos are parsed first (optimization)
     */
    static func freshnessSort(){
        Swift.print("💜 freshnessSort()")
        sortableRepoList = []//reset the array
        async(bgQueue, { () -> Void in//run the task on a background thread
            let repoXML = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)//~/Desktop/repo2.xml
            let repoList = XMLParser.toArray(repoXML)//or use dataProvider
            
            repoList.forEach{/*sort the repoList based on freshness*/
                let repoItem:RepoItem = (localPath:$0["local-path"]!,interval:$0["interval"]!.int,branch:$0["branch"]!,keyChainItemName:$0["keychain-item-name"]!,broadcast:$0["broadcast"]!.bool,title:$0["title"]!,subscribe:$0["subscribe"]!.bool,autoSync:$0["auto-sync"]!.bool,remotePath:$0["remote-path"]!)
                
                let freshness:CGFloat = FreshnessUtils.freshness(repoItem.localPath)
                self.sortableRepoList.append((repoItem,freshness))
            }
            self.sortableRepoList.sort(by: {$0.freshness > $1.freshness})/*sorts repos according to freshness, the freshest first the least fresh at the botom*/
            async(mainQueue){/*Jump back on the main thread*/
                self.onFreshnessSortComplete()
            }
        })
    }
    /**
     * Freshness level of every repo is calculated
     */
    static func onFreshnessSortComplete(){
        //sortableRepoList.forEach{Swift.print($0.repo["title"]!)}
        Swift.print("💛 onFreshnessSortComplete() Time:-> " + "\(abs(CommitDPRefresher.startTime!.timeIntervalSinceNow))")/*How long it took*/
        CommitDPRefresher.refreshRepos()
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
        let totCommitCount:Int = GitUtils.commitCount(localPath).int-3//you may need to build a more robust commitCount method, it may be that there is a newLine etc
        //Swift.print("totCommitCount: " + "\(totCommitCount)")
        let index:Int = totCommitCount < 100 ? totCommitCount : 100
        var date:Date = Date()
        let now:Int = DateParser.descendingDate(date).int
        if(index > 0){//if the repo has commits
            let cmd:String = "head~"+index.string+" --pretty=format:%ci --no-patch"
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
