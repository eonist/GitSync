import Foundation

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
