import Foundation
@testable import Element
@testable import Utils

/**
 * This tests The DataProvider that will work with FastList and dates
 * You can literally fly through time 👌
 */
class Graph8 {

    let fromYear:Int = 2011
    let toYear:Int = 2017
    var range:Range<Int> {return fromYear..<toYear}
    init(){
        //testDayDp()
        //testMonthDp()
        //testYearDp()
    }
    func testDayDp(){
        let dp = DayDP(range)
        Swift.print("dp.count: " + "\(dp.count)")
        let dict = dp.item(400)!
        Swift.print("dict: " + "\(dict)")
    }
    func testMonthDp(){
        let dp = MonthDP(range)
        let dict = dp.item(20)!
        Swift.print("dict: " + "\(dict)")
    }
    func testYearDp(){
        let dp = YearDP(range)
        let dict = dp.item(3)!
        Swift.print("dict: " + "\(dict)")
    }
}


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
    /**
     * Returns an offset in months from yearRange.start until yearIdx
     */
    static func firstMonthInYear(_ yearOffset:Int) -> Int{
        return yearOffset * MonthDP.numOfMonthsInYear
    }
}
