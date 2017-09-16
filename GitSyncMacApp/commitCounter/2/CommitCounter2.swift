import Foundation
@testable import Utils
@testable import GitSyncMac

class CommitCounter2 {
    typealias Time = (year:Int,month:Int,day:Int)
    /**
     *
     */
    func update(commitDB:CommitCountDB){//populates CommitDB with all the latest commits
        //dispatchGroup here
        let repoList:[RepoItem] = RepoUtils.repoListFlattenedOverridden
        repoList.forEach{update(commitDB:commitDB,repo:$0)}
    }
    /**
     * TODO: ⚠️️ Using title is not wise
     */
    private func update(commitDB:CommitCountDB,repo:RepoItem){//populates CommitDB with the latest commits from a speccific repo
        let range:(from:Time,to:Time) = {
            //
            let firstCommitInRepo:Time = GitDateParser.firstCommitDate(localRepoPath: repo.localPath)//⚠️️ might need to tilde expand
            let lastCommitInRepo:Time = GitDateParser.lastCommitDate(localRepoPath: repo.localPath)
            //
            if let repoDict = commitDB.repos[repo.title], repoDict.keys.isEmpty {
                return (from:firstCommitInRepo,to:lastCommitInRepo)
            }
            let lastCommitStoredInDB:CommitCountDB.DBDate = commitDB.lastCommitDate(repoId:repo.title)!
            let lastCommitStoredInDBInt:Int = CommitCountDB.yearMonthDayKey(date: lastCommitStoredInDB)
            let lastCommitInRepoDBDate:CommitCountDB.DBDate = .init(year: lastCommitInRepo.year, month: lastCommitInRepo.month, day: lastCommitInRepo.day)
            let lastCommitInRepoInt:Int = CommitCountDB.yearMonthDayKey(date:lastCommitInRepoDBDate)
            if lastCommitInRepoInt > lastCommitStoredInDBInt {
                let lastCommitStoredInDB:Time = (year:lastCommitStoredInDB.year,month:lastCommitStoredInDB.month,day:lastCommitStoredInDB.day)
                return (from:lastCommitStoredInDB, to:lastCommitInRepo)
            }
            fatalError("err")
        }()
        guard let from:Date = DateParser.createDate(range.from.year, range.from.month, range.from.day) else {fatalError("err")}
        guard let to:Date = DateParser.createDate(range.from.year, range.from.month, range.from.day) else {fatalError("err")}
        let commitDates:[Time] = GitDateParser.commitDates(localRepoPath: repo.localPath, since: from, until: to)
        
        //you need to group similar days 🏀
            //try reduce with this one
            //[date:Time,commitCount:32]
        
//        commitDates.forEach {//👈 then do this one with resulting arr
//            commitDB.addRepo(repoId: repo.title, date: CommitCountDB.DBDate.init(year:$0.year,month:$0.month,day:$0.day), commitCount: 20)
//        }
    }
	 //func update()
    
            //repoList.forEach{updateRepo(repoId:$0)}
        //func updateRepo(repoId:String)
    
}
