import Foundation
@testable import Utils
@testable import Element
/*Update*/
extension GraphZ{
    /**
     * Updates components in the Graph
     * NOTE: Gets it's call from the tick method in graphArea on every 100px threshold
     */
    func update(maxValue:Int) {
        //        Swift.print("GraphZ.update: maxValue:\(maxValue)")
        valueBar.update(maxValue: maxValue)
        updateDateIndicator()
    }
    /**
     * Updates the DateText UI Element
     */
    func updateDateIndicator(){
        let startIdx:Int = graphArea.scrollView.index
        let endIdx:Int = startIdx + vCount - 1
        let timeType:TimeType = self.curTimeType
        let start:YMD = dp.dp.item(at: startIdx).ymd
        let end:YMD = dp.dp.item(at: endIdx).ymd
        let dateRange:(start:Date,end:Date) = (start:start.date!,end:end.date!)
        //
        var startStr:String = ""
        var endStr:String = ""
        switch timeType{
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
        dateIndicator.dateText?.setTextValue(dateStr)
    }
}
private extension String{//private so that it only works in this class
    /**
     * TODO: ⚠️️ Add this to StringExtension as a more reusable method
     */
    var pad:String{//Converts: "6" -> "06"
        return self.count < 2 ? "0" + self : self
    }
}
