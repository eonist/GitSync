import Foundation
@testable import Utils
@testable import Element

extension Graph9{
    /**
     * Updates DateText and GraphLine
     */
    func update(){
        var commitCounter:CommitCounter = CommitCounter()
        func onComplete(_ results:[Int]){
            Swift.print("🏁 Graph9 commitCounter onComplete()")
            Swift.print("results: " + "\(results)")
            let vValues:[CGFloat] = results.map{$0.cgFloat}
            let maxValue:CGFloat = vValues.max()!//Finds the largest number in among vValues
            updateDateText()
            updateValueBar(maxValue)
            //graphComponent!.updateGraph(vValues)
        }
        commitCounter.onComplete = onComplete
        let dateRange:DateRange = GraphUpdateUtils.dateRange(curRange,range,curTimeType)
        
        //Swift.print("dateRange.start: " + "\(dateRange.start.shortDate)")
        //Swift.print("dateRange.end: " + "\(dateRange.end.shortDate)")
         /**/
        let numOfTimeUnits:Int = curTimeType.numOfTimeUnits(dateRange.start, dateRange.end)
        Swift.print("numOfTimeUnits: " + "\(numOfTimeUnits)")
        
        if(numOfTimeUnits == tCount){//⚠️️ quick fix
            commitCounter.countCommits(dateRange.start,dateRange.end,curTimeType)
        }
    }
    /**
     * VerticalBar (y-axis tags)
     */
    func updateValueBar(_ maxValue:CGFloat){
        var strings:[String] = GraphUtils.verticalIndicators(vCount, maxValue)
        strings = strings.map{ $0.cgFloat > 1000 ? ($0.cgFloat/1000).toFixed(1).string + "K" : $0}//1500 -> 1.5K etc
        for i in 0..<strings.count{
            valueBar!.items[i].setTextValue(strings[i])
        }
    }
    /**
     * Updates the DateText UI Element
     */
    func updateDateText(){
        //Swift.print("🍌 Graph9.updateDateText() \(curRange)" )
        let dateRange:DateRange = GraphUpdateUtils.dateRange(curRange,range,curTimeType)
        //Swift.print("dateRange.start.simpleDate: " + "\(dateRange.start.simpleDate)")
        //Swift.print("dateRange.end.simpleDate: " + "\(dateRange.end.simpleDate)")
        var startStr:String = ""
        var endStr:String = ""
        switch curTimeType{
            case .year:
                startStr = "\(dateRange.start.year.string)"
                endStr =  "\((dateRange.end.year-1).string)"//-1 is a quick fix
            case .month:
                startStr = "\(dateRange.start.year.string).\(dateRange.start.shortMonthName)"
                endStr =  "\(dateRange.end.year.string).\(dateRange.end.shortMonthName)"
            case .day:
                startStr = "\(dateRange.start.year.string).\(dateRange.start.shortMonthName).\(dateRange.start.day.string.pad)"
                endStr =  "\(dateRange.end.year.string).\(dateRange.end.shortMonthName).\(dateRange.end.day.string.pad)"
        }
        let dateStr:String = startStr + " - " + endStr
        dateIndicator!.dateText!.setTextValue(dateStr)
    }
}
private extension String{//private so that it only works in this class
    var pad:String{//Converts: "6" -> "06"
        return self.count < 2 ? "0" + self : self
    }
}
