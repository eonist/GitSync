import Foundation
@testable import Utils

class CommitCountDPUtils{
    /**
     * Y
     */
    static func describeYear(commitDb:CommitCountDB){
        let yearCounts:[Int:Int] = commitDb.yearCounts
        let commitCountDP = CommitCountDP(commitCount:yearCounts)
        Utils.describeYear(commitCountDP:commitCountDP)
    }
    /**
     * M
     */
    static func describeMonth(commitDb:CommitCountDB){
        let monthCounts:[Int:Int] = commitDb.monthCounts
//        Swift.print("monthCounts: " + "\(monthCounts)")
        let commitCountDP = MonthCommitDP(commitCount:monthCounts)
        Utils.describeYear(commitCountDP: commitCountDP)
    }
    /**
     * D
     */
    static func describeDay(commitDb:CommitCountDB){
        let dayCounts:[Int:Int] = commitDb.dayCounts
//        Swift.print("dayCounts: " + "\(dayCounts)")
        let commitCountDP = DayCommitDP.init(commitCount:dayCounts)
//        Swift.print("commitCountDP.count: " + "\(commitCountDP.count)")
        Utils.describeDay(commitCountDP: commitCountDP)
    }
}
private class Utils{
    /**
     * Y
     */
    static func describeMonth(commitCountDP:MonthCommitDP){
        Swift.print("commitCountDP.count: " + "\(commitCountDP.count)")
        //            let result = commitCountDP.item(at:0)
        //            Swift.print("result: " + "\(result)")
        for i in 0..<commitCountDP.count{
            let commitCount:Int = commitCountDP.item(at: i) ?? 0
            let yearAndMonth = TimeParser.offset(year: commitCountDP.minYear, month: commitCountDP.minMonth, offset: i)
            Swift.print("Year:\(yearAndMonth.year) Month:\(yearAndMonth.month) commitCount: \(commitCount)")
        }
    }
    /**
     * M
     */
    static func describeYear(commitCountDP:CommitCountDP){
        Swift.print("commitCountDP.count: " + "\(commitCountDP.count)")
        for i in 0..<commitCountDP.count{
            let yearCount:Int = commitCountDP.item(at: i) ?? 0
            let year:Int = commitCountDP.min + i
            Swift.print("year:\(year) yearCount: \(yearCount)")
        }
    }
    /**
     * D
     */
    static func describeDay(commitCountDP:DayCommitDP){
        Swift.print("commitCountDP.count: " + "\(commitCountDP.count) aka numOfDaysBetween min and max date")
        for i in 0...commitCountDP.count{
            let commitCount:Int = commitCountDP.item(at: i) ?? 0
            let dbDate = commitCountDP.ymd(at: i)
            Swift.print("Year: \(dbDate.year) Month: \(dbDate.month) Day: \(dbDate.day) commitCount: \(commitCount)")
        }
    }
}
