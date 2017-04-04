import Foundation
@testable import Utils
@testable import Element

typealias CommitCountWork = (localPath:String,since:String,until:String,commitCount:Int)

class CommitCountWorkUtils {
    /**
     * Returns 7 CommitCountWork instances for every repo in PARAM: repoList
     */
    static func commitCountWork(_ repoList:[RepoItem],_ from:Date, _ until:Date,_ timeType:TimeType)->[[CommitCountWork]]{
        var repoCommits:[[CommitCountWork]] = []
        repoList.forEach{ repoItem in
            let commits:[CommitCountWork] = CommitCountWorkUtils.commitCountWork(repoItem, from, until, timeType)
            _ = repoCommits += commits
        }
        return repoCommits
    }
    /**
     * Returns CommitCountWork instance array for a time range
     */
    static func commitCountWork(_ repoItem:RepoItem,_ from:Date, _ until:Date, _ timeType:TimeType)->[CommitCountWork]{
        let commitCountWorks = Utils.commitCountWork(repoItem,from,until,timeType)
        return commitCountWorks
    }
}
private class Utils{
    typealias OffsetDateMethod = (_ date:Date,_ offset:Int)->Date/*Method signature*/
    /**
     * Returns CommitCountWork instantce array from a date , timeUnit, numOfTimeUnits
     */
    static func commitCountWork(_ repoItem:RepoItem, _ from:Date, _ until:Date, _ timeType:TimeType)->[CommitCountWork]{
        var commitCountWorks:[CommitCountWork] = []
        let numOfTimeUnits:Int = timeType.numOfTimeUnits(from, until)
        Swift.print("⏳⏳⏳ numOfTimeUnits: " + "\(numOfTimeUnits) ⏳⏳⏳")
        for i in (0..<numOfTimeUnits){
            let sinceDate:Date = timeType.offsetBy(from,i)
            let sinceGitDate:String = GitDateUtils.gitTime(sinceDate)
            let untilDate:Date = timeType.offsetBy(from,i+1)
            let untilGitDate:String = GitDateUtils.gitTime(untilDate)
            let comitCountWork:CommitCountWork = (repoItem.localPath,sinceGitDate,untilGitDate,0)
            commitCountWorks.append(comitCountWork)
        }
        return commitCountWorks
    }
}
private extension TimeType{
    func offsetBy(_ date:Date,_ offset:Int)->Date {
        switch self {
            case .year:
                return DateModifier.offsetByYears(date,offset)
            case .month:
                return DateModifier.offsetByMonths(date,offset)
            case .day:
                return DateModifier.offsetByDays(date,offset)
        }
    }
    func numOfTimeUnits(_ from:Date,_ until:Date)->Int {
        switch self {
            case .year:
                return from.numOfYears(until)
            case .month:
                return from.numOfMonths(until)
            case .day:
                return from.numOfDays(until)
        }
    }
}
