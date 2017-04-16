import Foundation
@testable import Utils
@testable import Element

class YearDP:TimeDP{
    override var count:Int {return yearRange.numOfIndecies}
    override func item(_ at:Int) -> [String:String]? {
        let year:Int = YearDP.year(at,yearRange)
        let shortName:String = year.string.subString(2, 4)
        //Swift.print("shortName: " + "\(shortName)")
        return ["title":shortName]
    }
    /**
     * Returns year for offset idx
     */
    static func year(_ yearOffset:Int, _ yearRange:Range<Int>) -> Int{
        return (yearRange.start + yearOffset)
    }
    static func year(_ yearOffset:Int, _ yearRange:Range<Int>) -> Date{/*Convenience*/
        let yearInt:Int = YearDP.year(yearOffset, yearRange)
        let year:Date = Date.createDate(yearInt)!
        return year
    }
    /**
     * Returns an offset in months from yearRange.start until yearIdx
     */
    static func firstMonthInYear(_ yearOffset:Int) -> Int{
        return yearOffset * MonthDP.numOfMonthsInYear
    }
}
