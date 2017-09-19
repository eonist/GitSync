import Foundation
@testable import Utils
/**
 * NOTE: Format: [[2016'02'14:5]]
 * NOTE: with day you need to use the date class to offset min and max
 */
class DayCommitDP:MonthCommitDP{
    lazy var minDay:Int = YMD.day(ymd: min)
    lazy var maxDay:Int = YMD.day(ymd: max)
    override var count:Int {
        //min max
        let from:YMD = .init(year:minYear,month:minMonth,day:minDay)
        let to:YMD = .init(year:maxYear,month:maxMonth,day:maxDay)
        guard let fromDate:Date = from.date else {fatalError("err")}
        guard let toDate:Date = to.date else {fatalError("err")}
        let numOfDaysBetween:Int = DateParser.numOfDays(fromDate, toDate)
        return numOfDaysBetween//num of days from to
    }
    /**
     * Returns graph value for day offset
     */
    override func item(at:Int) -> Int? {
        let ymd = self.ymd(at: at)
        let key:Int = YMD.yearMonthDayKey(ymd: ymd)
        return commitCount[key]
    }
    override func item(at: Int) -> (commitCount:Int?,ymd:YMD){
        let ymd = self.ymd(at: at)
        let key:Int = YMD.yearMonthDayKey(ymd: ymd)
        let commitCount:Int? = self.commitCount[key]
        return (commitCount:commitCount,ymd:ymd)
    }
}

extension DayCommitDP {
    /**
     * Returns dbDate for day offset
     */
    func ymd(at:Int) -> YMD {//TODO: ⚠️️ Rename to
        let min:YMD = .init(year:minYear,month:minMonth,day:minDay)
        guard let minDate:Date = min.date else {fatalError("err")}//find start date
        let dateAt:Date = minDate.offsetByDays(at)//n days from startDate => date
        let ymd:YMD = .init(year: dateAt.year, month: dateAt.month, day: dateAt.day)
        return ymd
    }
}
