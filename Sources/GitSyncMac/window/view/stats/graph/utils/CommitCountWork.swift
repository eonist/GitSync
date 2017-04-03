import Foundation
@testable import Utils
@testable import Element

typealias CommitCountWork = (localPath:String,since:String,until:String,commitCount:Int)
class CommitCountWorkUtils {
    /**
     *
     */
    static func commitCountWork(_ from:Date, _ until:Date, _ timeType:TimeType)->CommitCountWork{
        switch timeType{
            case .year:
                from.numOfYears(until)
            case .month:
                print("range from 3 to 8")
                from.numOfMonths(until)
            case .day:
                print("range from 3 to 8")
            default:
                break;
        }
        return ("","","",0)
    }
}
