import Foundation
@testable import Utils
/**
 * NOTE: Format: [[2016'02'14:5]]
 * NOTE: with day you need to use the date class to offset min and max
 */
class DayCommitDP:MonthCommitDP{
    //
    //see old class for this
    
    lazy var minDay:Int = {
        //Swift.print("min.string: " + "\(min.string)")
        let str:String = min.string.subString(min.string.count - 2, min.string.count)
        let int:Int = str.int
        return int
    }()
    lazy var maxDay:Int = {
        //Swift.print("max.string: " + "\(max.string)")
        let str:String = max.string.subString(max.string.count - 2, max.string.count)
        let int:Int = str.int
        return int
    }()
    override var count:Int {
        //min max
        let from:CommitCountDB.DBDate = .init(year:minYear,month:minMonth,day:minDay)
        let to:CommitCountDB.DBDate = .init(year:maxYear,month:maxMonth,day:maxDay)
        guard let fromDate:Date = from.date else {fatalError("err")}
        guard let toDate:Date = to.date else {fatalError("err")}
        let numOfDaysBetween:Int = DateParser.numOfDays(fromDate, toDate)
        return numOfDaysBetween//num of days from to
    }
    /**
     * Returns graph value for day offset
     */
    override func item(at:Int) -> Int? {
        let dbDateAt = dbDate(at: at)
        let key:Int = CommitCountDB.yearMonthDayKey(date: dbDateAt)
        return commitCount[key]
    }
}

extension DayCommitDP {
    /**
     * Returns dbDate for day offset
     */
    func dbDate(at:Int) -> CommitCountDB.DBDate {
        let min:CommitCountDB.DBDate = .init(year:minYear,month:minMonth,day:minDay)
        guard let minDate:Date = min.date else {fatalError("err")}//find start date
        let dateAt:Date = minDate.offsetByDays(at)//n days from startDate => date
        let dbDateAt:CommitCountDB.DBDate = .init(year: dateAt.year, month: dateAt.month, day: dateAt.day)
        return dbDateAt
    }
}
