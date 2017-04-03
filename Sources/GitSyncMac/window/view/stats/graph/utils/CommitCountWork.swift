import Foundation
@testable import Utils
@testable import Element

typealias CommitCountWork = (localPath:String,since:String,until:String,commitCount:Int)
class CommitCountWorkUtils {
    /**
     *
     */
    static func commitCountWork(_ from:Date, _ until:Date, _ timeType:TimeType)->CommitCountWork{
        let numOfTimeUnits:Int
        switch timeType{
            case .year:
                numOfUnits = from.numOfYears(until)
            case .month:
                print("range from 3 to 8")
                numOfUnits = from.numOfMonths(until)
            case .day:
                numOfUnits = from.numOfDays(until)
            
        }
        
        var commitCountWorks:[CommitCountWork] = []
        for i in (0...numOfTimeUnits){//7 days
            let dayOffset:Int = dayOffset-i//days ago
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
        
        
        
        let sinceDate:Date = Date().offsetByDays(dayOffset)
        let sinceGitDate:String = GitDateUtils.gitTime(sinceDate)
        let untilDate:Date = Date().offsetByDays(dayOffset+1)
        let untilGitDate:String = GitDateUtils.gitTime(untilDate)
        let comitCountWork:CommitCountWork = (repoItem.localPath,sinceGitDate,untilGitDate,0)
        
        
        return ("","","",0)
    }
}
