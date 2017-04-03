import Foundation

typealias CommitCountWork = (localPath:String,since:String,until:String,commitCount:Int)
class CommitCountWorkUtils {
    /**
     *
     */
    static func commitCountWork(_ from:Date, _ until:Date, _ timeType:TimeType)->CommitCountWork{
        switch timeType{
        case .year:
            print("one")
        case .month:
            print("range from 3 to 8")
        case .month:
            print("range from 3 to 8")
        default:
            break;
        }
        return ("","","",0)
    }

}
