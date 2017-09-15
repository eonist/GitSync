import Foundation
@testable import Utils
/**
 * TODO: ⚠️️ move min and max year into its own class?
 */
class MonthCommitDP:CommitCountDP{//month
    lazy var minYear:Int = min.string.subStr(0, min.string.count - 4).int//201602 -> 2016
    lazy var maxYear:Int = max.string.subStr(0, max.string.count - 4).int//this is actually wrong, but wont be a problem until year 10000
    lazy var minMonth:Int = {
        //        Swift.print("min.string: " + "\(min.string)")
        let str:String = min.string.subString(min.string.count - 4, min.string.count-2)
        let int:Int = str.int
        return int
    }()
    lazy var maxMonth:Int = {
        //        Swift.print("max.string: " + "\(max.string)")
        let str:String = max.string.subString(max.string.count - 4, max.string.count-2)
        let int:Int = str.int
        return int
    }()
    override var count:Int {
        return TimeParser.numOfMonths(from: (year:minYear,month:minMonth), to: (year:maxYear,month:maxMonth))
    }
    /**
     * Returns graph value for month offset
     */
    override func item(at: Int) -> Int? {
        let yearAndMonth = TimeParser.offset(year: minYear, month: minMonth, offset: at)
////        let year:Int =
//        let monthStr:String = StringParser.pad(value: yearAndMonth.month, padCount: 2, padStr: "0")
        let key:Int = CommitCountDB.yearMonthKey(year:yearAndMonth.year,month:yearAndMonth.month)
        //Swift.print("key: " + "\(key)")
        return commitCount[key]
    }
}
