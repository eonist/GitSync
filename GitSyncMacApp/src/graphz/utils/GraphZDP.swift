import Foundation
@testable import Utils
@testable import GitSyncMac

/**
 * This extends DataProvider because we need to send events etc, also List uses DataProvider
 * TODO: ⚠️️ Upgrade to DP2 in the future
 */
class GraphZDP:DataProvider{
    var timeType:TimeType
    var commitCountDB:CommitCountDB
    lazy var dp:CommitCountDPKind = Utils.commitCountDP(timeType: self.timeType,commitCountDB: self.commitCountDB)
    init(timeType:TimeType,commitCountDB:CommitCountDB){
        self.timeType = timeType
        self.commitCountDB = commitCountDB
    }
    override var count: Int {
//        Swift.print("dp.count: " + "\(dp.count)")
        return dp.count
    }
    override func item(_ at: Int) -> [String : String]? {
        let item:(commitCount:Int?,ymd:YMD) = dp.item(at: at)
        let val:Int = {
            if timeType == .day {return item.ymd.day }
            else if timeType == .month{return item.ymd.month}
            else {return item.ymd.year}
        }()
//        Swift.print("item(at:\(at) val: " + "\(val)")
        return ["title":val.string]
    }
    func item(at:Int) -> Int?{
        return dp.item(at: at)
    }
}
extension GraphZDP{
    class Utils{
        static func commitCountDP(timeType:TimeType,  commitCountDB:CommitCountDB) -> CommitCountDPKind{
            switch timeType{
            case .day:
                let dayCounts:[Int:Int] = commitCountDB.dayCounts
                let dayCommitCountDP = DayCommitDP(commitCount:dayCounts)
                return dayCommitCountDP
            case .month:
                let monthCounts:[Int:Int] = commitCountDB.monthCounts
//                Swift.print("monthCounts: " + "\(monthCounts)")
                let monthCommitCountDP = MonthCommitDP(commitCount:monthCounts)
//                Swift.print("monthCommitCountDP.count: " + "\(monthCommitCountDP.count)")
                return monthCommitCountDP
            case .year:
                let yearCounts:[Int:Int] = commitCountDB.yearCounts
                let yearCommitCountDP = CommitCountDP(commitCount:yearCounts)
                return yearCommitCountDP
            }
        }
    }
}
