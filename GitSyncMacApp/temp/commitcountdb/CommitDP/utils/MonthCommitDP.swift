import Foundation
@testable import Utils
/**
 * TODO: ⚠️️ move min and max year into its own class?
 */
class MonthCommitDP:CommitCountDP{//month
    lazy var minYear:Int = YMD.year(ymd: min)//201602 -> 2016
    lazy var maxYear:Int = YMD.year(ymd: max)//this is actually wrong, but wont be a problem until year 10000
    lazy var minMonth:Int = YMD.month(ymd:min)
    lazy var maxMonth:Int = YMD.month(ymd:max)
    override var count:Int {
        return TimeParser.numOfMonths(from: .init(year:minYear,month:minMonth), to: .init(year:maxYear,month:maxMonth))
    }
    /**
     * Returns graph value for month offset
     */
    override func item(at: Int) -> Int? {
        let yearAndMonth = TimeParser.offset(year: minYear, month: minMonth, offset: at)
////        let year:Int =
//        let monthStr:String = StringParser.pad(value: yearAndMonth.month, padCount: 2, padStr: "0")
        let key:Int = YM.yearMonthKey(year:yearAndMonth.year,month:yearAndMonth.month)
        //Swift.print("key: " + "\(key)")
        return commitCount[key]
    }
}

