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
class TimeDP:DataProvider{
    var yearRange:Range<Int>
    init(_ yearRange:Range<Int>) {
        self.yearRange = yearRange
    }
}
class DayDP:TimeDP{
    static var numOfDaysInYear:Int = 365
    override var count:Int {return yearRange.numOfIndecies * DayDP.numOfDaysInYear}/*numOfDaysInYearRange*/
    override var items:[[String:String]] {get{fatalError("Not available")}set{_ = newValue}}
    override func item(_ at:Int) -> [String:String]? {
        if(at >= count){return nil}//out of bound return nil
        let date = DayDP.day(at,yearRange)
        let shortDayName:String = date.shortDayName//short day for date
        return ["title":shortDayName]//return dict with this
    }
    /**
     * Returns a Date from given dayOffsetIdx on yearRange (what is date 1200 days from year 2011 for instance)
     */
    static func day(_ dayIdx:Int, _ yearRange:Range<Int>)->Date{
        let startDate:Date = DateParser.createDate(yearRange.start,0,0,0,0,0)!//find start date
        let dateAt:Date = startDate.offsetByDays(dayIdx)//n days from startDate => date
        return dateAt
    }
    /**
     * Returns month offset idx
     */
    static func month(_ dayIdx:Int, _ yearRange:Range<Int>) -> Int{
        let from:Date = DateParser.createDate(yearRange.start)!
        let until:Date = from.offsetByDays(dayIdx)
        let numOfMonthsFromUntil:Int = from.numOfMonths(until)
        return numOfMonthsFromUntil
    }
}
class MonthDP:TimeDP{
    static var numOfMonthsInYear:Int = 12
    override var count:Int {return yearRange.numOfIndecies * MonthDP.numOfMonthsInYear}/*numOfDaysInYearRange*/
    override func item(_ at:Int) -> [String:String]? {
        if(at >= count){return nil}//out of bound return nil
        let dateAt:Date = MonthDP.month(at,yearRange)
        let shortMonthName:String = dateAt.shortMonthName//short month name for date
        return ["title":shortMonthName]//return dict with this
    }
    static func month(_ monthOffset:Int, _ yearRange:Range<Int>)->Date{
        let startDate:Date = DateParser.createDate(yearRange.start,0,0,0,0,0)!//find start date
        let dateAt:Date = startDate.offsetByMonths(monthOffset)//n months from startDate => date
        return dateAt
    }
    /**
     * Returns an offset in days from yearRange.start until monthIdx
     */
    static func firstDayInMonth(_ monthOffset:Int, _ yearRange:Range<Int>)->Int{
        //which year are we in?
        let yearIdx:Int = floor((monthOffset / MonthDP.numOfMonthsInYear).cgFloat).int
        //which month are we in?
        let from:Date = DateParser.createDate(yearRange.start)!
        let monthInYear:Int = ((monthOffset.cgFloat %% MonthDP.numOfMonthsInYear.cgFloat) + 1.0).int /*between 1 and 12*/
        let year:Int = yearRange.start + yearIdx
        let until:Date = DateParser.createDate(year,monthInYear/*,  1*/)!//first month and first day
        //num of days since yearRange.start until date
        let numOfDaysInRange:Int = from.numOfDays(until)
        return numOfDaysInRange
    }
    /**
     * Return year offset idx
     */
    static func year(_ monthOffset:Int,_ yearRange:Range<Int>) -> Int{
        let from:Date = DateParser.createDate(yearRange.start)!
        let until:Date = from.offsetByMonths(monthOffset)
        let numOfYearsFromUntil:Int = from.numOfYears(until)
        return numOfYearsFromUntil
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
