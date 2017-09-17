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
    func update(commitDB:CommitCountDB,repoList:[RepoItem]){//
        //dispatchGroup here
        repoList.forEach{update(commitDB:commitDB,repo:$0)}
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
            
            //continue here: 🏀
                //repo does not exist do what?
            
            let lastCommitStoredInDB:YMD = commitDB.lastCommitDate(repoId:repo.title)!
            let lastCommitStoredInDBInt:Int = YMD.yearMonthDayKey(ymd: lastCommitStoredInDB)
            let lastCommitInRepoInt:Int = YMD.yearMonthDayKey(year: lastCommitInRepo.year, month: lastCommitInRepo.month, day: lastCommitInRepo.day)
            if lastCommitInRepoInt > lastCommitStoredInDBInt {
                let lastCommitStoredInDB:YMD = .init(year:lastCommitStoredInDB.year,month:lastCommitStoredInDB.month,day:lastCommitStoredInDB.day)
                return (from:lastCommitStoredInDB, to:lastCommitInRepo)
            }
            fatalError("err")
        }()
        guard let from:Date = DateParser.createDate(range.from.year, range.from.month, range.from.day) else {fatalError("err")}
        guard let to:Date = DateParser.createDate(range.from.year, range.from.month, range.from.day) else {fatalError("err")}
        let commitDates:[YMD] = GitDateParser.commitDates(localRepoPath: repo.localPath, since: from, until: to)
        //
        let commitCounts:[(date:YMD,commitCount:Int)] = Utils.groupEquals(commitDates: commitDates)
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
