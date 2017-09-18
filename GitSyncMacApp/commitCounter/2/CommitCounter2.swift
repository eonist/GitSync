import Foundation
@testable import Utils
@testable import GitSyncMac
/**
 * CommitCounter2 - just simple 1 dimensioinal loop inside dispatchGroup
 */
class CommitCounter2 {
    
    /**
     * populates CommitDB with all the latest commits
     */
    func update(commitDB:CommitCountDB,repoList:[RepoItem],onComplete:@escaping ()->Void){//
        //dispatchGroup here
       let group = DispatchGroup()
        group.enter()
        repoList.forEach { repo in
            bg.async {
                self.update(commitDB:commitDB,repo:repo)
                group.leave()
            }
        }
        group.notify(queue: main, execute: {/*you have to jump back on main thread to call things on main thread as this scope is still on bg thread*/
            Swift.print("🏁 group completed: 🏁")//make a method on mainThread and call that instead.
            onComplete()
        })
    }
    /**
     * populates CommitDB with the latest commits from a speccific repo
     * TODO: ⚠️️ Using title is not wise, use permaId. implement that later
     */
    private func update(commitDB:CommitCountDB,repo:RepoItem){//⚠️️ commitDB may need to be inout
        let range:(from:YMD,to:YMD) = {
            //
            let firstCommitInRepo:YMD = GitDateParser.firstCommitDate(localRepoPath: repo.localPath.tildePath)//⚠️️ might need to tilde expand
            Swift.print("firstCommitInRepo: " + "\(firstCommitInRepo)")
            let lastCommitInRepo:YMD = GitDateParser.lastCommitDate(localRepoPath: repo.localPath)
            Swift.print("lastCommitInRepo: " + "\(lastCommitInRepo)")
            //
            if let repoDict = commitDB.repos[repo.title], repoDict.keys.isEmpty {
                return (from:firstCommitInRepo,to:lastCommitInRepo)
            }
            let from:YMD = {
                guard let lastCommitStoredInDB:YMD = commitDB.lastCommitDate(repoId:repo.title) /*repo exists and has items*/ else { return firstCommitInRepo}
                return lastCommitStoredInDB
            }()
            let to:YMD = lastCommitInRepo
            return (from,to)
//            let fromInt:Int = YMD.yearMonthDayKey(year: from.year, month: from.month, day: from.day)
//            let toInt:Int = YMD.yearMonthDayKey(year: to.year, month: to.month, day: to.day)
//            
        }()
        guard let from:Date = DateParser.createDate(range.from.year, range.from.month, range.from.day) else {fatalError("err")}
        Swift.print("from: " + "\(from)")
        guard let to:Date = DateParser.createDate(range.to.year, range.to.month, range.to.day) else {fatalError("err")}
        Swift.print("to: " + "\(to)")
        let commitDates:[YMD] = GitDateParser.commitDates(localRepoPath: repo.localPath.tildePath, since: from, until: to)
        Swift.print("commitDates.count: " + "\(commitDates.count)")
        //
        let commitCounts:[(date:YMD,commitCount:Int)] = Utils.groupEquals(commitDates: commitDates)//dates and their day count
        Swift.print("commitCounts.count: " + "\(commitCounts.count)")
        commitDB.addRepo(repoId: repo.title, commitCounts:commitCounts)//👈 then do this one with resulting arr
    }
}

private class Utils{
    /**
     * TODO: ⚠️️ This method can be made more efficient since the array is sorted you can do a while loop over it testing if next is similar etc. Maybe even use NSSet etc.
     */
    static func groupEquals(commitDates:[YMD]) -> [(date:YMD,commitCount:Int)]{//you need to group similar days
        var dict:[Int:Int] = [:]
        commitDates.forEach{
            let key:Int = $0.int
            if let value =  dict[key] {
                dict[key] = value + 1
            }else {
                dict[key] = 1
            }
        }
        //sort the dict
        let sortedDict:[(Int, Int)] = DictionaryParser.sortByKey(dict)
        //convert the key to YMD again
        let arr:[(YMD,Int)] = sortedDict.map{return (YMD.ymd(ymd:$0.0),$0.1)}
        return arr
    }
}
