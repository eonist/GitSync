import Cocoa
@testable import Element
@testable import Utils


/*Panning controller*/
extension Graph9{
    override func scrollWheel(with event:NSEvent) {
        //Swift.print("Graph9.scrollWheel()")
        super.scrollWheel(with:event)
        updateDateText()
    }
    /**
     * Updates the DateText UI Element
     */
    func updateDateText(){
        Swift.print("🍐🍌🍊 updateDateText")
        if(visibleRange == nil || visibleRange != timeBar!.visibleItemRange){/*If the range has changed, then update text*/
            visibleRange = timeBar!.visibleItemRange
            let yearRange = (timeBar!.dp as! TimeDP).yearRange
            Swift.print("yearRange: " + "\(yearRange)")
            var dateStr:String = ""
            switch curTimeType{
            case .year:
                /*Year*/
                Swift.print("visibleRange!: " + "\(visibleRange!)")
                let startYearStr:String = YearDP.year(visibleRange!.start,yearRange).string
                Swift.print("startYearStr: " + "\(startYearStr)")
                let endYearStr:String = YearDP.year(visibleRange!.end,yearRange).string
                Swift.print("endYearStr: " + "\(endYearStr)")
                dateStr = "\(startYearStr) - \(endYearStr)"
            case .month:
                /*Month*/
                let startMonth:Date = MonthDP.month(visibleRange!.start, yearRange)
                let endMonth:Date = MonthDP.month(visibleRange!.end, yearRange)
                /*Year*/
                let startYearIdx:Int = MonthDP.year(visibleRange!.start, yearRange)//sort of the offset
                let startYearStr:String = YearDP.year(startYearIdx,yearRange).string
                let endYearIdx:Int = MonthDP.year(visibleRange!.end, yearRange)
                let endYearStr:String = YearDP.year(endYearIdx,yearRange).string
                dateStr = "\(startYearStr).\(startMonth.shortMonthName) - \(endYearStr).\(endMonth.shortMonthName)"
            case .day:
                /*day*/
                let startDayDate:Date = DayDP.day(visibleRange!.start, yearRange)
                let startDayDateStr:String = startDayDate.day.string
                let endDayDate:Date = DayDP.day(visibleRange!.end, yearRange)
                let endDayDateStr:String = endDayDate.day.string
                /*Month*/
                let startMonthIdx:Int = DayDP.month(visibleRange!.start,yearRange)
                let startMonth:Date = MonthDP.month(startMonthIdx, yearRange)
                let endMonthIdx:Int = DayDP.month(visibleRange!.end,yearRange)
                let endMonth:Date = MonthDP.month(endMonthIdx, yearRange)
                /*year*/
                let startYearIdx:Int = MonthDP.year(startMonthIdx, yearRange)//sort of the offset
                let startYearStr:String = YearDP.year(startYearIdx,yearRange).string
                let endYearIdx:Int = MonthDP.year(startMonthIdx, yearRange)
                let endYearStr:String = YearDP.year(endYearIdx,yearRange).string
                dateStr = "\(startYearStr).\(startMonth.shortMonthName).\(startDayDateStr) - \(endYearStr).\(endMonth.shortMonthName).\(endDayDateStr)"
            }
            dateText!.setTextValue(dateStr)
        }
    }
}
