import Foundation
@testable import Element
@testable import Utils

/**
 * You can literally fly through time
 */


//Graph9
    //add fastList .hor 👈
    //try it with year,month,day
    //try to add pinch gestures to the fold
    //try to calc the pos of mouse in relation to the timeBar
    //try to zoom in and out with correct indecies
    //try generate fake graphdata on anim stop
    //draw the fake graph data as a graphline with points
    //try to update the valuebar
    //try to update the timeIndicator
    //add git to the fold

class Graph8 {

    let fromYear:Int = 2010
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
    override var count:Int {return yearRange.count * DayDP.numOfDaysInYear}/*numOfDaysInYearRange*/
    override var items:[[String:String]] {get{fatalError("Not available")}set{fatalError("Not available")}}
    override func item(_ at:Int) -> [String:String]? {
        if(at >= count){return nil}//out of bound return nil
        let startDate:Date = DateParser.createDate(yearRange.start,0,0,0,0,0)!//find start date
        let dateAt:Date = startDate.offsetByDays(at)//n days from startDate => date
        let shortDayName:String = dateAt.shortDayName//short day for date
        return ["title":shortDayName]//return dict with this
    }
    /**
     * Returns month offset idx
     */
    func month(_ dayIdx:Int) -> Int{
        let from:Date = DateParser.createDate(yearRange.start)!
        let until:Date = from.offsetByDays(dayIdx)
        let numOfMonthsFromUntil:Int = from.numOfMonths(until)
        return numOfMonthsFromUntil
    }
}
class MonthDP:TimeDP{
    static var numOfMonthsInYear:Int = 12
    override var count:Int {return yearRange.count * MonthDP.numOfMonthsInYear}/*numOfDaysInYearRange*/
    override func item(_ at:Int) -> [String:String]? {
        if(at >= count){return nil}//out of bound return nil
        let startDate:Date = DateParser.createDate(yearRange.start,0,0,0,0,0)!//find start date
        let dateAt:Date = startDate.offsetByMonths(at)//n months from startDate => date
        let shortMonthName:String = dateAt.shortMonthName//short month name for date
        return ["title":shortMonthName]//return dict with this
    }
    /**
     * Returns an offset in days from yearRange.start until monthIdx
     */
    func firstDayInMonth(_ monthIdx:Int)->Int{
        //which year are we in?
        let yearIdx:Int = floor((monthIdx / MonthDP.numOfMonthsInYear).cgFloat).int
        //which month are we in?
        let from:Date = DateParser.createDate(yearRange.start)!
        let monthInYear:Int = ((monthIdx.cgFloat %% MonthDP.numOfMonthsInYear.cgFloat) + 1.0).int /*between 1 and 12*/
        let year:Int = yearRange.start + yearIdx
        let until:Date = DateParser.createDate(year,monthInYear/*,  1*/)!//first month and first day
        //num of days since yearRange.start until date
        let numOfDaysInRange:Int = from.numOfDays(until)
        return numOfDaysInRange
    }
    /**
     * Return year offset idx
     */
    func year(_ monthIdx:Int) -> Int{
        let from:Date = DateParser.createDate(yearRange.start)!
        let until:Date = from.offsetByMonths(monthIdx)
        let numOfYearsFromUntil:Int = from.numOfYears(until)
        return numOfYearsFromUntil
    }
}
class YearDP:TimeDP{
    override var count:Int {return yearRange.count}
    override func item(_ at:Int) -> [String:String]? {
        let year:Int = yearRange.start + at
        return ["title":year.string]
    }
    /**
     * Returns an offset in months from yearRange.start until yearIdx
     */
    func firstMonthInYear(_ yearIdx:Int) -> Int{
        return yearIdx * MonthDP.numOfMonthsInYear
    }
}
