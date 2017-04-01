import Foundation
@testable import Element
@testable import Utils

/**
 * This tests The 📦 DataProvider that will work with FastList and dates
 * You can literally fly ✈️ through ⏳ time 👌
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
