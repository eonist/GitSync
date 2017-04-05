import Foundation
@testable import Utils

//use TimePeriod instead of dayOffset
//design a sudo parser in playground that supports month,year,day
class CommitCounter{
    var repoCommits:[[CommitCountWork]]?
    var result:[Int] = Array(repeating: 0, count: 7)/*prepop result arr*/
    var startTime:Date? = nil/*Performace tests the commitCount task*/
    var onComplete:(_ result:[Int])->Void = {_ in print("⚠️️⚠️️⚠️️ no onComplete is currently attached")}
    /**
     * Initiates the process
     */
    /*func countCommits(_ dayOffset:Int){//temp, remove shortly
     let from:Date = Date().offsetByDays(dayOffset-7)
     let until:Date = Date().offsetByDays(dayOffset)
     countCommits(from,until,.day)
     }*/
    func countCommits(_ from:Date, _ until:Date,_ timeType:TimeType){
        startTime = Date()/*debugging*/
        let repoList:[RepoItem] = RepoUtils.repoListFlattenedDupeFree
        repoCommits = CommitCountWorkUtils.commitCountWork(repoList,from,until,timeType)/*populate a 3d array with items*/
        let group = DispatchGroup()
        for i in repoCommits!.indices{/*Loop 3d-structure*/
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
    func onRateOfCommitComplete(){/*At this point all tasks have complted*/
        //Swift.print("all concurrent tasks completed: totCount \(totCount)")
        for i in repoCommits!.indices{/*loop 3d-structure*/
            for e in repoCommits![i].indices{
                result[e] = result[e] + repoCommits![i][e].commitCount//👈👈👈 place count in array
            }
        }
        Swift.print("result: " + "\(result)")
        Swift.print("Time: " + "\(abs(startTime!.timeIntervalSinceNow))")
        onComplete(result)//🚪➡️️
    }
}
