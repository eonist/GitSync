import Foundation
@testable import Element
@testable import Utils
@testable import GitSyncMac

typealias DateRange = (start:Date,end:Date)
class GraphUpdateUtils {
    /**
     * 
     */
    static func dateRange(_ curRange:Range<Int>, _ yearRange:Range<Int>, _ curTimeType:TimeType)->DateRange{
        let visibleRange = curRange
        let yearRange = yearRange
        switch curTimeType{
            case .year:
                let startDate:Date = YearDP.year(visibleRange.start,yearRange)
                let endDate:Date = YearDP.year(visibleRange.end - 2,yearRange)
                return (startDate,endDate)
            case .month:
                /*Month*/
                let startMonth:Date = MonthDP.month(visibleRange.start, yearRange)
                Swift.print("startMonth.month: " + "\(startMonth.month)")
                let endMonth:Date = MonthDP.month(visibleRange.end-1, yearRange)
                Swift.print("endMonth.month: " + "\(endMonth.month)")
                /*Year*/
                let startYearIdx:Int = MonthDP.year(visibleRange.start, yearRange)//sort of the offset
                let startYear:Int = YearDP.year(startYearIdx,yearRange)
                Swift.print("startYear: " + "\(startYear)")
                let endYearIdx:Int = MonthDP.year(visibleRange.end-1, yearRange)
                let endYear:Int = YearDP.year(endYearIdx,yearRange)
                Swift.print("endYear: " + "\(endYear)")
                /*Date*/
                let startDate:Date = Date.createDate(startYear, startMonth.month)!
                let endDate:Date = Date.createDate(endYear, endMonth.month)!
                return (startDate,endDate)
            case .day:
                /*day*/
                let startDayDate:Date = DayDP.day(visibleRange.start, yearRange)
                let endDayDate:Date = DayDP.day(visibleRange.end, yearRange)
                /*Month*/
                let startMonthIdx:Int = DayDP.month(visibleRange.start,yearRange)
                Swift.print("startMonthIdx: " + "\(startMonthIdx)")
                let startMonth:Date = MonthDP.month(startMonthIdx, yearRange)
                let endMonthIdx:Int = DayDP.month(visibleRange.end,yearRange)
                Swift.print("endMonthIdx: " + "\(endMonthIdx)")
                let endMonth:Date = MonthDP.month(endMonthIdx, yearRange)
                /*year*/
                let startYearIdx:Int = MonthDP.year(startMonthIdx, yearRange)//sort of the offset
                let startYear:Int = YearDP.year(startYearIdx, yearRange)
                let endYearIdx:Int = MonthDP.year(endMonthIdx, yearRange)
                let endYear:Int = YearDP.year(endYearIdx, yearRange)
                /*Date*/
                let startDate:Date = Date.createDate(startYear, startMonth.month,startDayDate.day)!
                let endDate:Date = Date.createDate(endYear, endMonth.month,endDayDate.day)!
                return (startDate,endDate)
        }
    }
}
