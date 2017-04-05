import Foundation
@testable import Utils
@testable import Element

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
        let startDate:Date = Date.createDate(yearRange.start)!//find start date
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
