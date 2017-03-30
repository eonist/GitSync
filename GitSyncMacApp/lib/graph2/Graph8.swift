import Foundation
@testable import Element
@testable import Utils

//test snappy friction ✅
//test zoom to time-levels ✅
//test fastList with dates ✅
//Test animate graphPoint ✅

//between zoom levels you just do random graph
    //make some randomVals 👈
//you derive the time range based on the first and last visible items in fastList
//you make a rand value list for each time zone on app init which is consistent across time level zooming

//hock up the timeRangeDescTextComponent

//after all these works, you then figure out how to jump in and out of time levels at the point you are at.
//create padding for values tht dont exist, you need to show 7 time points but may have only commits in 1 year for instance
//try to add valuebar
//try to add the git stuff and your done


class Graph8 {
    //Build the modell first rather than add it later?
    
    //year 2010 - 2017 -> create rand values
    //month (Gen from year range) -> create rand values
    //day (gen from year range) -> create rand values
        //you actually generate these on the fly. 
            //instead of pulling items from an array you pull from a method that calculates via progress and Date()
                //this is cool! you do this for month and year to, takes care of padding time values as well.
                    //try some tests around this concept first
                    //look at the FastList and see if it can support it! 👀 ✅
                        //All you need todo is SubClass DP and make it adhere to a dateRange of 7 years. or longer if the commit hist is longer, but 7 years for now
                        //you can even have 3 dp's that you switch between zoom levels 👈
    let fromYear:Int = 2010
    let toYear:Int = 2017
    var range:Range<Int> {return fromYear..<toYear}
    init(){
        //testDayDp()
        //testMonthDp()
        //testYearDp()
        
        //try to go in and out of time levels, via at 🤔
        
        //mouse hovers above 2015
            //you zoom in
                //find first month in 2015
                    //find progress to set to MonthDP
                        //numOfMonths(from:date,to:date)
                        //numOfDays(from:date,to:date)
        
                        //set TimeBar dp to MonthDP
                        //set timeBar to progress
        
        //when you zoom out you ask:
            //when in DayLevel
                //what month is first date in curVisibleRange
                    //monthOffset = numOfMonths(from,to)
                        //set TimeBar.dp monthDP(monthOffset)
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
    func month(_ dayIdx:Int){
        let from:Date = DateParser.createDate(yearRange.start)!
        let monthInYear:Int = ((monthIdx.cgFloat %% MonthDP.numOfMonthsInYear.cgFloat) + 1.0).int /*between 1 and 12*/
        let until:Date = DateParser.createDate(year,monthInYear/*,  1*/)!//first month and first day
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
        let year:Int = yearRange.start + yearIdx
        //which month are we in?
        let from:Date = DateParser.createDate(year)!
        let monthInYear:Int = ((monthIdx.cgFloat %% MonthDP.numOfMonthsInYear.cgFloat) + 1.0).int /*between 1 and 12*/
        let until:Date = DateParser.createDate(year,monthInYear/*,  1*/)!//first month and first day
        //num of days since yearRange.start until date
        let numOfDaysInRange:Int = from.numOfDays(until)
        return numOfDaysInRange
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
