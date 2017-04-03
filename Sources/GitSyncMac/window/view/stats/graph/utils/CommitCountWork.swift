import Foundation
@testable import Utils
@testable import Element

typealias CommitCountWork = (localPath:String,since:String,until:String,commitCount:Int)

class CommitCountWorkUtils {
    /**
     * Returns 7 CommitCountWork instances for every repo in PARAM: repoList
     */
    static func commitCountWork(_ repoList:[RepoItem],_ dayOffset:Int)->[[CommitCountWork]]{
        let from:Date = Date().offsetByDays(dayOffset-7)
        let until:Date = Date().offsetByDays(dayOffset)
        return commitCountWork(repoList,from,until,.day)
    }
    /**
     *
     */
    static func commitCountWork(_ repoList:[RepoItem],_ from:Date, _ until:Date,_ timeType:TimeType)->[[CommitCountWork]]{
        var repoCommits:[[CommitCountWork]] = []
        repoList.forEach{ repoItem in
            let commits:[CommitCountWork] = CommitCountWorkUtils.commitCountWork(repoItem, from, until, .day)//rateOfCommits($0,dayOffset)
            //Swift.print("commits.count: " + "\(commits.count)")
            _ = repoCommits += commits
        }
        return repoCommits
    }
    /**
     * Returns CommitCountWork instantce array for a time range
     */
    static func commitCountWork(_ repoItem:RepoItem,_ from:Date, _ until:Date, _ timeType:TimeType)->[CommitCountWork]{
        var numOfTimeUnits:Int
        var offsetDateMethod:Utils.OffsetDateMethod
        switch timeType{
            case .year:
                numOfTimeUnits = from.numOfYears(until)
                offsetDateMethod = DateModifier.offsetByYears
            case .month:
                numOfTimeUnits = from.numOfMonths(until)
                offsetDateMethod = DateModifier.offsetByMonths
            case .day:
                numOfTimeUnits = from.numOfDays(until)
                offsetDateMethod = DateModifier.offsetByDays
        }
        let commitCountWorks = Utils.commitCountWork(repoItem, from, numOfTimeUnits, offsetDateMethod)
        return commitCountWorks
        
    }
}
private class Utils{
    typealias OffsetDateMethod = (_ date:Date,_ offset:Int)->Date/*Method signature*/
    /**
     * Returns CommitCountWork instantce array from a date , timeUnit, numOfTimeUnits
     */
    static func commitCountWork(_ repoItem:RepoItem, _ from:Date, _ numOfTimeUnits:Int, _ offsetBy:OffsetDateMethod)->[CommitCountWork]{
        var commitCountWorks:[CommitCountWork] = []
        for i in (0..<numOfTimeUnits){//7 days
            let sinceDate:Date = from.offsetByDays(i)
            let sinceGitDate:String = GitDateUtils.gitTime(sinceDate)
            let untilDate:Date = from.offsetByDays(i+1)
            let untilGitDate:String = GitDateUtils.gitTime(untilDate)
            let comitCountWork:CommitCountWork = (repoItem.localPath,sinceGitDate,untilGitDate,0)
            commitCountWorks.append(comitCountWork)
        }
        return commitCountWorks
    }
}
