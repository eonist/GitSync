import Foundation
@testable import Utils
@testable import Element
import GitSyncMac

extension Graph9{
    /**
     * Updates DateText and GraphLine
     */
    func update(){
        updateDateText()
        updateGraph()
        
        //Continue here:
            //implement the bellow:
        /*
        let commitCounter:CommitCounter = CommitCounter()
        func onComplete(_ results:[Int]){
            Swift.print("Appdelegate.onComplete()")
            Swift.print("results.count: " + "\(results.count)")
            Swift.print("results: " + "\(results)")
        }
        commitCounter.onComplete = onComplete
        
        commitCounter.countCommits(from,until,.year)
        
        
        let maxValue:CGFloat = NumberParser.max(vValues)//Finds the largest number in among vValues
        updateValueBar(maxValue)
        */
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
        let visibleRange = curRange
        let yearRange = range//temp solution
        //Swift.print("yearRange: " + "\(yearRange)")
        var dateStr:String = ""
        switch curTimeType{
            case .year:
                /*Year*/
                Swift.print("visibleRange: " + "\(visibleRange)")
                let startYearStr:String = YearDP.year(visibleRange.start,yearRange).string
                Swift.print("startYearStr: " + "\(startYearStr)")
                let endYearStr:String = YearDP.year(visibleRange.end - 2,yearRange).string
                Swift.print("endYearStr: " + "\(endYearStr)")
                dateStr = "\(startYearStr) - \(endYearStr)"
            case .month:
                /*Month*/
                let startMonth:Date = MonthDP.month(visibleRange.start, yearRange)
                let endMonth:Date = MonthDP.month(visibleRange.end, yearRange)
                /*Year*/
                let startYearIdx:Int = MonthDP.year(visibleRange.start, yearRange)//sort of the offset
                let startYearStr:String = YearDP.year(startYearIdx,yearRange).string
                let endYearIdx:Int = MonthDP.year(visibleRange.end, yearRange)
                let endYearStr:String = YearDP.year(endYearIdx,yearRange).string
                dateStr = "\(startYearStr).\(startMonth.shortMonthName) - \(endYearStr).\(endMonth.shortMonthName)"
            case .day:
                /*day*/
                let startDayDate:Date = DayDP.day(visibleRange.start, yearRange)
                let startDayDateStr:String = startDayDate.day.string
                let endDayDate:Date = DayDP.day(visibleRange.end, yearRange)
                let endDayDateStr:String = endDayDate.day.string
                /*Month*/
                let startMonthIdx:Int = DayDP.month(visibleRange.start,yearRange)
                let startMonth:Date = MonthDP.month(startMonthIdx, yearRange)
                let endMonthIdx:Int = DayDP.month(visibleRange.end,yearRange)
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

extension Graph9{
    /**
     *
     */
    func dateRange()->(from:Date,until:Date){
        let visibleRange = curRange
        let yearRange = range
        switch curTimeType{
            case .year:
                let startDate:Date = YearDP.year(visibleRange.start,yearRange)
                let endDate:Date = YearDP.year(visibleRange.end - 2,yearRange)
                return (startDate,endDate)
            case .month:
                
                let startMonth:Date = MonthDP.month(visibleRange.start, yearRange)
                let endMonth:Date = MonthDP.month(visibleRange.end, yearRange)
                
                let startYearIdx:Int = MonthDP.year(visibleRange.start, yearRange)//sort of the offset
                let startYear:Date = YearDP.year(startYearIdx,yearRange)
                let endYearIdx:Int = MonthDP.year(visibleRange.end, yearRange)
                let endYear:Date = YearDP.year(endYearIdx,yearRange)
                
                
                return (startMonth,endMonth)
            case .day:
                /*day*/
                let startDayDate:Date = DayDP.day(visibleRange.start, yearRange)
                let endDayDate:Date = DayDP.day(visibleRange.end, yearRange)
                return (startDayDate,endDayDate)
        }
    }
}
