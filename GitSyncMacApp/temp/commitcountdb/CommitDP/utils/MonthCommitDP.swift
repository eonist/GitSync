import Foundation
@testable import Utils

class MonthCommitDP:CommitCountDP{//month
    lazy var minYear:Int = min.string.subStr(0, min.string.count - 2).int//201602 -> 2016
    lazy var minMonth:Int = {
        //        Swift.print("min.string: " + "\(min.string)")
        let str:String = min.string.subString(min.string.count - 2, min.string.count)
        let int:Int = str.int
        return int
    }()
    lazy var maxYear:Int = max.string.subStr(0, max.string.count - 2).int
    lazy var maxMonth:Int = {
        //        Swift.print("max.string: " + "\(max.string)")
        let str:String = max.string.subString(max.string.count - 2, max.string.count)
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
        let year:Int = yearAndMonth.year
        let monthStr:String = StringParser.pad(value: yearAndMonth.month, padCount: 2, padStr: "0")
        let key:Int = (year.string + monthStr).int
        //        Swift.print("key: " + "\(key)")
        return commitCount[key]
    }
}
