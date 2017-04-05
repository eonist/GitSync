import Foundation
@testable import Utils
@testable import Element

class MonthDP:TimeDP{
    static var numOfMonthsInYear:Int = 12
    override var count:Int {return yearRange.numOfIndecies * MonthDP.numOfMonthsInYear}/*numOfDaysInYearRange*/
    override func item(_ at:Int) -> [String:String]? {
        if(at >= count){return nil}//out of bound return nil
        let dateAt:Date = MonthDP.month(at,yearRange)
        let shortMonthName:String = dateAt.shortMonthName//short month name for date
        return ["title":shortMonthName]//return dict with this
    }
}
extension MonthDP{
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
        Swift.print("yearIdx: " + "\(yearIdx)")
        //which month are we in?
        let from:Date = DateParser.createDate(yearRange.start)!
        Swift.print("from.year: " + "\(from.year)")
        let monthInYear:Int = ((monthOffset.cgFloat %% MonthDP.numOfMonthsInYear.cgFloat) + 1.0).int /*between 1 and 12*/
        Swift.print("monthInYear: " + "\(monthInYear)")
        let year:Int = yearRange.start + yearIdx
        Swift.print("year: " + "\(year)")
        let until:Date = DateParser.createDate(year,monthInYear/*,  1*/)!//first month and first day
        Swift.print("until.year: " + "\(until.year)" + "month: " + "\(until.month)")
        //num of days since yearRange.start until date
        let dayOffset:Int = from.numOfDays(until)
        Swift.print("dayOffset: " + "\(dayOffset)")
        return dayOffset
    }
    /**
     * Return year offset idx
     */
    static func year(_ monthOffset:Int,_ yearRange:Range<Int>) -> Int{
        let from:Date = DateParser.createDate(yearRange.start)!
        Swift.print("from.simpleDate: " + "\(from.simpleDate)")
        let until:Date = from.offsetByMonths(monthOffset)
        Swift.print("until.simpleDate: " + "\(until.simpleDate)")
        let numOfMonths = from.numOfMonths(until)
        Swift.print("numOfMonths: " + "\(numOfMonths)")
        let numOfYearsFromUntil:Int = from.numOfYears(until)
        Swift.print("numOfYearsFromUntil: " + "\(numOfYearsFromUntil)")
        return numOfYearsFromUntil
    }
}
