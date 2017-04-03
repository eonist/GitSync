import Foundation
@testable import Utils
@testable import Element

typealias CommitCountWork = (localPath:String,since:String,until:String,commitCount:Int)
class CommitCountWorkUtils {
    /**
     *
     */
    static func commitCountWork(_ repoItem:RepoItem,_ from:Date, _ until:Date, _ timeType:TimeType)->CommitCountWork{
        var commitCountWorks:[CommitCountWork] = []
        switch timeType{
            case .year:
                let numOfYears = from.numOfYears(until)
            case .month:
                print("range from 3 to 8")
                let numOfMonths = from.numOfMonths(until)
            case .day:
                let numOfDays = from.numOfDays(until)
                for i in (0...numOfDays){//7 days
                    let sinceDate:Date = from.offsetByDays(i)
                    let sinceGitDate:String = GitDateUtils.gitTime(sinceDate)
                    let untilDate:Date = from.offsetByDays(i+1)
                    let untilGitDate:String = GitDateUtils.gitTime(untilDate)
                    let comitCountWork:CommitCountWork = (repoItem.localPath,sinceGitDate,untilGitDate,0)
                    commitCountWorks.append(comitCountWork)
                }
        }
        return ("","","",0)
    }
}
