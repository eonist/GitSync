import Foundation
@testable import Utils
@testable import Element
@testable import GitSyncMac

extension Graph9{
    /**
     * Updates DateText and GraphLine
     */
    func update(){
        updateDateText()
        updateGraph()
        
        var commitCounter:CommitCounter = CommitCounter()
        func onComplete(_ results:[Int]){
            Swift.print("Graph9 commitCounter onComplete()")
            Swift.print("results.count: " + "\(results.count)")
            Swift.print("results: " + "\(results)")
            let maxValue:CGFloat = results.max()!.cgFloat//Finds the largest number in among vValues
            updateValueBar(maxValue)
        }
        commitCounter.onComplete = onComplete
        let dateRange:DateRange = self.dateRange()
        Swift.print("dateRange.start: " + "\(dateRange.start)")
        Swift.print("dateRange.end: " + "\(dateRange.end)")
        //commitCounter.countCommits(dateRange.start,dateRange.end,curTimeType)
        
        //Continue here: 
            //write some date tests
            //maybe try visibleRange.start + 7 for end. instead of end
    }
    /**
     * Re-calc and set the graphPoint positions (for instance if the hValues has changed etc)
     */
    func updateGraph(){
        prevGraphPts = graphPts.map{$0}//grabs the location of where the pts are now
        graphPts = randomGraphPoints
        
        /*GraphPoints*/
        if(animator != nil){animator!.stop()}/*stop any previous running animation*/
        animator = Animator(Animation.sharedInstance,0.5,0,1,interpolateValue,Quad.easeIn)
        animator!.start()
    }
    /**
     * VerticalBar (y-axis tags)
     */
    func updateValueBar(_ maxValue:CGFloat){
        let strings:[String] = GraphUtils.verticalIndicators(6/*vCount*/, maxValue)
        for i in 0..<strings.count{
            valueBar!.items[i].setTextValue(strings[i])
        }
    }
    /**
     * Updates the DateText UI Element
     */
    func updateDateText(){
        /*let visibleRange = curRange
         let yearRange = range//temp solution*/
        let dateRange:DateRange = self.dateRange()
        var startStr:String = ""
        var endStr:String = ""
        switch curTimeType{
            case .year:
                startStr = "\(dateRange.start.year.string)"
                endStr =  "\(dateRange.end.year.string)"
            case .month:
                startStr = "\(dateRange.start.year.string).\(dateRange.start.shortMonthName)"
                endStr =  "\(dateRange.end.year.string).\(dateRange.end.shortMonthName)"
            case .day:
                startStr = "\(dateRange.start.year.string).\(dateRange.start.shortMonthName).\(dateRange.start.shortDayName)"
                endStr =  "\(dateRange.end.year.string).\(dateRange.end.shortMonthName).\(dateRange.end.shortDayName)"
        }
        let dateStr:String = startStr + " - " + endStr
        dateText!.setTextValue(dateStr)
    }
}
extension Graph9{
    typealias DateRange = (start:Date,end:Date)
    /**
     *
     */
    func dateRange()->DateRange{
        let visibleRange = curRange
        let yearRange = range
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
                let startMonth:Date = MonthDP.month(startMonthIdx, yearRange)
                let endMonthIdx:Int = DayDP.month(visibleRange.end,yearRange)
                let endMonth:Date = MonthDP.month(endMonthIdx, yearRange)
                /*year*/
                let startYear:Int = MonthDP.year(startMonthIdx, yearRange)//sort of the offset
                let endYear:Int = MonthDP.year(startMonthIdx, yearRange)
                /*Date*/
                let startDate:Date = Date.createDate(startYear, startMonth.month,startDayDate.day)!
                let endDate:Date = Date.createDate(endYear, endMonth.month,endDayDate.day)!
                return (startDate,endDate)
        }
    }
}
