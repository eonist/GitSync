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
            
            
        }
        
        
        
        
        return ("","","",0)
    }
}
