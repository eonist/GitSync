import Foundation
@testable import Element
@testable import Utils
import GitSyncMac

class StatUtils{
    /**
     * Returns an index that can be used when toggeling time levels
     */
    static func mouseLocIdx(_ mouseX:CGFloat, _ totalWidth:CGFloat, _ itemWidth:CGFloat) -> Int{
        let rndTo:CGFloat = mouseX.roundTo(itemWidth)
        Swift.print("rndTo: " + "\(rndTo)")
        let idx:Int = (rndTo/itemWidth).int
        return idx
    }
    /**
     * Returns a progress value that can be used to stay in the same time period when toggeling between time-levels
     */
    static func progress(_ timeBar:FastList, _ time:(prevTimeType:TimeType,curTimeType:TimeType), _ mouseLocIdx:Int)->CGFloat{/*0-1*/
        let dp:TimeDP = timeBar.dataProvider as! TimeDP
        let visibleRange:Range<Int> = timeBar.visibleItemRange
        let startIdx:Int = visibleRange.start
        let idx:Int = startIdx + mouseLocIdx
        Swift.print("offset idx: \(idx)")
        //how do you set, just convert idx to progress
        var dpProgress:CGFloat
        switch time{
            case (.year,.month):/*from year to month*/
                Swift.print("⏳ from year to month")
                let monthIdx:Int = YearDP.firstMonthInYear(idx)
                Swift.print("monthIdx: " + "\(monthIdx)")
                dpProgress = monthIdx.cgFloat/dp.count.cgFloat
                Swift.print("dpProgress: " + "\(dpProgress)")
            case (.month,.day):/*from month to day*/
                Swift.print("⏳ from month to day")
                Swift.print("Month offset idx: \(idx)")
                Swift.print("timeBar.currentVisibleItemRange.start: " + "\(timeBar.currentVisibleItemRange.start)")
                
                //Continue here:
                    //you need to find month offset and for that you need the old timeBar, maybe you need the new tiebar when you move up?
                
                let dayIdx:Int = MonthDP.firstDayInMonth(idx,dp.yearRange)
                dpProgress = dayIdx.cgFloat/dp.count.cgFloat
            case (.month,.year):/*from month to year*/
                Swift.print("⏳ from month to year")
                let startYearIdx:Int = MonthDP.year(visibleRange.start, dp.yearRange)//sort of the offset
                dpProgress = startYearIdx.cgFloat / dp.count.cgFloat
            case (.day,.month):/*from day to month*/
                Swift.print("⏳ from day to month")
                let startMontIdx = DayDP.month(visibleRange.start, dp.yearRange)
                dpProgress = startMontIdx.cgFloat / dp.count.cgFloat
            default:
                fatalError("This can't happen: \(time)" )
        }
        return dpProgress
    }
}
