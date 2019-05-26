import Foundation
@testable import Utils
/**
 * TODO: ⚠️️ move min and max year into its own class?
 */
class MonthCommitDP:CommitCountDP{//month
    lazy var minYear:Int = YM.year(ym: min)//201602 -> 2016
    lazy var maxYear:Int = YM.year(ym: max)//this is actually wrong, but wont be a problem until year 10000
    lazy var minMonth:Int = YM.month(ym:min)
    lazy var maxMonth:Int = YM.month(ym:max)
    override var count:Int {
        return TimeParser.numOfMonths(from: YM(year:minYear,month:minMonth), to: YM(year:maxYear,month:maxMonth))
    }
    /**
     * Returns graph value for month offset
     */
    override func item(at: Int) -> Int? {
//        Swift.print("at: " + "\(at)")
        let yearAndMonth:YM = TimeParser.offset(year: minYear, month: minMonth, offset: at)
//        Swift.print("yearAndMonth: " + "\(yearAndMonth)")
////        let year:Int =
//        let monthStr:String = StringParser.pad(value: yearAndMonth.month, padCount: 2, padStr: "0")
        let key:Int = YM.yearMonthKey(year:yearAndMonth.year, month:yearAndMonth.month)
        //Swift.print("key: " + "\(key)")
        return commitCount[key]
    }
    override func item(at:Int)->(commitCount:Int?,ymd:YMD){
        let yearAndMonth = TimeParser.offset(year: minYear, month: minMonth, offset: at)
        let key:Int = YM.yearMonthKey(year:yearAndMonth.year,month:yearAndMonth.month)
        let commitCount:Int? = self.commitCount[key]
        let ymd:YMD = YMD.init(year: yearAndMonth.year, month: yearAndMonth.month, day: 1)
        return (commitCount:commitCount,ymd:ymd)
    }
}

