import Foundation
@testable import Utils
@testable import Element

typealias CommitCountWork = (localPath:String,since:String,until:String,commitCount:Int)
class CommitCountWorkUtils {
    /**
     *
     */
    static func commitCountWork(_ repoItem:RepoItem,_ from:Date, _ until:Date, _ timeType:TimeType)->CommitCountWork{
        
        switch timeType{
            case .year:
                let numOfYears = from.numOfYears(until)
            case .month:
                print("range from 3 to 8")
                let numOfMonths = from.numOfMonths(until)
            case .day:
                let numOfDays = from.numOfDays(until)
            
        }
        return ("","","",0)
    }
}
private class Utils{
    typealias OffsetDateMethod = (_ date:Date,_ offset:Int)->Date/*Method signature*/
    static func commitCountWork(_ repoItem:RepoItem, _ from:Date, _ numOfTimeUnits:Int, _ offsetBy:OffsetDateMethod)->[CommitCountWork]{
        var commitCountWorks:[CommitCountWork] = []
        for i in (0...numOfTimeUnits){//7 days
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
