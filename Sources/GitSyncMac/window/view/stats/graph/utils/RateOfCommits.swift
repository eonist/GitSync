import Foundation
@testable import Utils

//use TaskGroups
//use TimePeriod instead of dayOffset
//design a sudo parser in playground that supports month,year,day
class RateOfCommits{
    
    var repoCommits:[[CommitCountWork]]?
    var totCount:Int?
    var result:[Int] = [0,0,0,0,0,0,0]
    var idx:Int = 0
    var startTime:Date? = nil
    
    var onComplete:(_ result:[Int])->Void = {_ in print("⚠️️⚠️️⚠️️ no onComplete is currently attached")}
    /**
     * Initiates the process
     */
    func initRateOfCommitsProcess(_ dayOffset:Int){
        startTime = Date()
        var repoList:[RepoItem] = RepoUtils.repoListFlattened//.filter{$0.title == "GitSync"}//👈 filter enables you to test one item at the time
        Swift.print("repoList.count: " + "\(repoList.count)")
        //the dupe free code bellow should/could be moved to RepoUtils
        repoList = repoList.removeDups({$0.remotePath == $1.remotePath && $0.branch == $1.branch})/*remove dups that have the same remote and branch. */
        Swift.print("After removal of dupes - repoList: " + "\(repoList.count)")
        repoCommits = CommitCountWorkUtils.commitCountWork(repoList,dayOffset)
        totCount = repoCommits!.flatMap{$0}.count
        /*Loop 3d-structure*/
        //let group = DispatchGroup()
        for i in repoCommits!.indices{//⚠️️ TODO: flatMap this and use Modern means of grouping Tasks (maybe not, as you want 7 items to be returned not 7*repos.count)
            for e in repoCommits![i].indices{
                bgQueue.async {
                    //group.enter()
                    let work:CommitCountWork = self.repoCommits![i][e]
                    //Swift.print("launched a work item: " + "\(work.localPath)")
                    let commitCount:String = GitUtils.commitCount(work.localPath, since:work.since , until:work.until)//👈👈👈 do some work
                    mainQueue.async {/*Jump back on main thread, because the onComplete resides there*/
                        self.repoCommits![i][e].commitCount = commitCount.int
                        self.onRateOfCommitComplete()//⬅️️
                    }
                    //group.leave()
                }
            }
        }
        /*group.notify(queue: main, execute: {//TODO: replace bg with main, then remove main.async. just call onComplete?
         onRateOfCommitComplete()
         })*/
    }
    /**
     * Everytime a work task completes
     */
    func onRateOfCommitComplete(){
        idx += 1
        //Swift.print("onComplete: " + "\(i)")
        if(idx == totCount){
            /*At this point all tasks hvae complted*/
            Swift.print("all concurrent tasks completed: totCount \(totCount)")
            /*loop 3d-structure*/
            for i in repoCommits!.indices{//⚠️️ TODO: use flatMap here to make the 3d array into 2d array,maybe not, as you want 7 items to be returned not 7*repos.count
                for e in repoCommits![i].indices{
                    result[e] = result[e] + repoCommits![i][e].commitCount//👈👈👈 place count in array
                }
            }
            Swift.print("result: " + "\(result)")
            Swift.print("Time: " + "\(abs(startTime!.timeIntervalSinceNow))")
            onComplete(result)//🚪➡️️
        }
    }
}
/*extension RateOfCommits{
    
    /**
     * Returns an array of CommitCountWork instances for 7 days in an Array of 7 Int from PARAM: repoItem
     */
    func rateOfCommits(_ repoItem:RepoItem, _ dayOffset:Int) -> [CommitCountWork]{
        //Swift.print("repoItem.title: \(repoItem.title) localPath: \(repoItem.localPath)")
        //var commits:[Int] = []
        var commitCountWorks:[CommitCountWork] = []
        for i in (1...7).reversed(){//7 days
            let dayOffset:Int = dayOffset-i//days ago
            let sinceDate:Date = Date().offsetByDays(dayOffset)
            let sinceGitDate:String = GitDateUtils.gitTime(sinceDate)
            let untilDate:Date = Date().offsetByDays(dayOffset+1)
            let untilGitDate:String = GitDateUtils.gitTime(untilDate)
            let comitCountWork:CommitCountWork = (repoItem.localPath,sinceGitDate,untilGitDate,0)
            commitCountWorks.append(comitCountWork)
            //let commitCount:String = GitUtils.commitCount(repoItem.localPath, since: , until:)
            //Swift.print("commitCount: " + "\(commitCount)")
            //commits.append(commitCount.int)
        }
        //Swift.print("commits: " + "\(commits)")
        return commitCountWorks
    }
}

*/

