import Foundation
@testable import Utils

class RateOfCommits{
    typealias CommitCountWork = (localPath:String,since:String,until:String,commitCount:Int)
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
        var repoList:[RepoItem] = RepoUtils.repoList//.filter{$0.title == "GitSync"}//👈 filter enables you to test one item at the time
        Swift.print("repoList.count: " + "\(repoList.count)")
        repoList = repoList.removeDups({$0.remotePath == $1.remotePath && $0.branch == $1.branch})/*remove dups that have the same remote and branch. */
        Swift.print("After removal of dupes - repoList: " + "\(repoList.count)")
        repoCommits = rateOfCommits(repoList,dayOffset)
        totCount = repoCommits!.flatMap{$0}.count
        /*Loop 3d-structure*/
        for i in repoCommits!.indices{
            for e in repoCommits![i].indices{
                bgQueue.async {
                    let work:CommitCountWork = self.repoCommits![i][e]
                    //Swift.print("launched a work item: " + "\(work.localPath)")
                    let commitCount:String = GitUtils.commitCount(work.localPath, since:work.since , until:work.until)//👈👈👈 do some work
                    mainQueue.async {
                        self.repoCommits![i][e].commitCount = commitCount.int
                        self.onRateOfCommitComplete()
                    }
                }
            }
        }
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
            for i in repoCommits!.indices{
                for e in repoCommits![i].indices{
                    result[e] = result[e] + repoCommits![i][e].commitCount//👈👈👈 place count in array
                }
            }
            Swift.print("result: " + "\(result)")
            Swift.print("Time: " + "\(abs(startTime!.timeIntervalSinceNow))")
            onComplete(result)
        }
    }
}
extension RateOfCommits{
    /**
     * Returns an array with with week summaries of commit counts from PARAM: repoList
     */
    func rateOfCommits(_ repoList:[RepoItem],_ dayOffset:Int)->[[CommitCountWork]]{
        var repoCommits:[[CommitCountWork]] = []
        repoList.forEach{
            let commits:[CommitCountWork] = rateOfCommits($0,dayOffset)
            _ = repoCommits += commits
        }
        return repoCommits
    }
    /**
     * Returns an commitCount for 7 days in an Array of 7 Int from PARAM: repoItem
     */
    
    func rateOfCommits(_ repoItem:RepoItem, _ dayOffset:Int) -> [CommitCountWork]{
        //Swift.print("repoItem.title: \(repoItem.title) localPath: \(repoItem.localPath)")
        //var commits:[Int] = []
        var commitCountWorks:[CommitCountWork] = []
        for i in (1...7).reversed(){//7 days
            let dayOffset:Int = dayOffset-i
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



