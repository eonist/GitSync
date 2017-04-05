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
        /*
        var commitCounter:CommitCounter = CommitCounter()
        func onComplete(_ results:[Int]){
            Swift.print("Graph9 commitCounter onComplete()")
            Swift.print("results.count: " + "\(results.count)")
            Swift.print("results: " + "\(results)")
            let maxValue:CGFloat = results.max()!.cgFloat//Finds the largest number in among vValues
            updateValueBar(maxValue)
        }
        commitCounter.onComplete = onComplete
 
        let dateRange:DateRange = GraphUpdateUtils.dateRange(curRange,range,curTimeType)
        
        Swift.print("dateRange.start: " + "\(dateRange.start.shortDate)")
        Swift.print("dateRange.end: " + "\(dateRange.end.shortDate)")
         /**/
        let numOfTimeUnits:Int = curTimeType.numOfTimeUnits(dateRange.start, dateRange.end)
        Swift.print("numOfTimeUnits: " + "\(numOfTimeUnits)")
        */
        //commitCounter.countCommits(dateRange.start,dateRange.end,curTimeType)
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
        Swift.print("🍌 Graph9.updateDateText()")
        let dateRange:DateRange = GraphUpdateUtils.dateRange(curRange,range,curTimeType)
        Swift.print("dateRange.start.shortDate: " + "\(dateRange.start.shortDate)")
        Swift.print("dateRange.end.shortDate: " + "\(dateRange.end.shortDate)")
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
                startStr = "\(dateRange.start.year.string).\(dateRange.start.shortMonthName).\(dateRange.start.day.string)"
                endStr =  "\(dateRange.end.year.string).\(dateRange.end.shortMonthName).\(dateRange.end.day.string)"
        }
        let dateStr:String = startStr + " - " + endStr
        dateText!.setTextValue(dateStr)
    }
}
