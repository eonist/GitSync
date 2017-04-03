import Foundation
@testable import Utils

//use TimePeriod instead of dayOffset
//design a sudo parser in playground that supports month,year,day
class RateOfCommits{
    var repoCommits:[[CommitCountWork]]?
    var result:[Int] = Array(repeating: 0, count: 7)/*prepop result arr*/
    var startTime:Date? = nil/*Performace tests the commitCount task*/
    var onComplete:(_ result:[Int])->Void = {_ in print("⚠️️⚠️️⚠️️ no onComplete is currently attached")}
    /**
     * Initiates the process
     */
    func initRateOfCommitsProcess(_ dayOffset:Int){
    }
    func initCommitCountProcess(_ from:Date, _ unitil:Date){
        //Swift.print("🍐 initRateOfCommitsProcess")
        startTime = Date()
        var repoList:[RepoItem] = RepoUtils.repoListFlattened//.filter{$0.title == "GitSync"}//👈 filter enables you to test one item at the time
        //Swift.print("repoList.count: " + "\(repoList.count)")
        //the dupe free code bellow should/could be moved to RepoUtils
        repoList = repoList.removeDups({$0.remotePath == $1.remotePath && $0.branch == $1.branch})/*remove dups that have the same remote and branch. */
        //Swift.print("After removal of dupes - repoList: " + "\(repoList.count)")
        repoCommits = CommitCountWorkUtils.commitCountWork(repoList,from,until,.day)/*populate a 3d array with items*/
        /*Loop 3d-structure*/
        let group = DispatchGroup()
        for i in repoCommits!.indices{//⚠️️ TODO: flatMap this and use Modern means of grouping Tasks (maybe not, as you want 7 items to be returned not 7*repos.count)
            for e in repoCommits![i].indices{
                bgQueue.async {
                    group.enter()
                    let work:CommitCountWork = self.repoCommits![i][e]
                    //Swift.print("launched a work item: " + "\(work.localPath)")
                    let commitCount:String = GitUtils.commitCount(work.localPath, since:work.since , until:work.until)//👈👈👈 do some work
                    mainQueue.async {/*Jump back on main thread, because the onComplete resides there*/
                        self.repoCommits![i][e].commitCount = commitCount.int
                    }
                    group.leave()
                }
            }
        }
        group.notify(queue: main, execute: {
            self.onRateOfCommitComplete()
        })

    }
    /**
     * Everytime a work task completes
     */
    func onRateOfCommitComplete(){
        /*At this point all tasks hvae complted*/
        //Swift.print("all concurrent tasks completed: totCount \(totCount)")
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
