import Foundation
@testable import Utils

/**
 * This extends DataProvider because we need to send events etc, also List uses DataProvider
 * TODO: ⚠️️ Upgrade to DP2 in the future
 */
class GraphZDP:DataProvider{
    var vCount:Int {return graph.vCount }
    var timeType:TimeType {return graph.curTimeType}
    var commitCountDB:CommitCountDB {return graph.db}
    
    
    var _dp:CommitCountDPKind?
    var dp:CommitCountDPKind {//generates the correct DP type for the TimeType
//        Swift.print("dp _dp:\(_dp) timeType: \(timeType)")
        if _dp == nil {
            _dp = Utils.commitCountDP(timeType: self.timeType,commitCountDB: self.commitCountDB)
            return _dp!
        }
        else if _dp is DayCommitDP && timeType == .day {return _dp!}
        else if _dp is MonthCommitDP && timeType == .month{return _dp!}
        else if _dp is YearCommitDP && timeType == .year{return _dp!}
        else{
            _dp = Utils.commitCountDP(timeType: self.timeType,commitCountDB: self.commitCountDB)
            return _dp!
        }
    }
    
    var graph:GraphZ
    init(graph:GraphZ){
        //timeType:self.curTimeType, commitCountDB:db, vCount:self.vCount
        self.graph = graph
    }
    /**
     * aka numOfTimeTypeUnitesBetween min and max date
     */
    override var count: Int {
//        Swift.print("dp.count: " + "\(dp.count)")
        let c:Int = dp.count.clip(vCount/*-1*/, dp.count)/*Tot count of all items in dp*///we clip it to avoid visual bugs. -1 strangly enough works.
        return c /*dp.count*/
    }
    override func item(_ at: Int) -> [String : String]? {
        let item:(commitCount:Int?,ymd:YMD) = dp.item(at: at)
        let val:String = {
            guard let date:Date = item.ymd.date else{ fatalError("unable to create date")}
            if timeType == .day {
                return date.shortDayName
            }else if timeType == .month{
                return date.shortMonthName
            }else {
                return item.ymd.year.string
            }
        }()
//        Swift.print("item(at:\(at) val: " + "\(val)")
        return ["title":val]
    }
    func item(at:Int) -> Int?{
        return dp.item(at: at)
    }
}
extension GraphZDP{
    class Utils{
        /**
         * Returns YEAR,MONTH,DAY DataProvider based on PARAM: timeType
         */
        static func commitCountDP(timeType:TimeType,  commitCountDB:CommitCountDB) -> CommitCountDPKind{
            Swift.print("create new dp timeType: \(timeType) ")
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
                let yearCommitCountDP = YearCommitDP(commitCount:yearCounts)
                return yearCommitCountDP
            }
        }
    }
}
