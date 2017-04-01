import Cocoa
@testable import Element
@testable import Utils
//Graph9
    //add fastList .hor ✅
    //try it with year,month,day ✅
    //try to add pinch gestures to the fold ✅
    //try to calc the pos of mouse in relation to the timeBar 👈.1
    //try to zoom in and out with correct indecies 👈.2
    //add snapTo animation
    //try generate fake graphdata on snapTo anim stop
    //draw the fake graph data as a graphline with points
    //try to update the valuebar
    //try to update the timeIndicator 
    //add git to the fold

enum TimeType {
    case year,month,day
    static var types:[TimeType] {return [TimeType.day,TimeType.month,TimeType.year]}
}
class Graph9:Element{
    var dateText:TextArea?
    var timeBar:ScrollFastList?
    /*Date vars*/
    let fromYear:Int = 2011
    let toYear:Int = 2017//TODO: swap this out with Date().year
    var range:Range<Int> {return fromYear..<toYear}
    /*Zooming vars*/
    var curZoom:Int = 0
    let maxZoom:Int = 3
    var zoom:CGFloat = 0
    /**/
    var curTimeType:TimeType = .day
    var curRange:Range<Int>?
    override func resolveSkin() {
        StyleManager.addStyle("Graph9{float:left;clear:left;fill:green;fill-alpha:0.0;}")//Needed so that scrollWheel works
        StyleManager.addStylesByURL("~/Desktop/datetext.css")
        super.resolveSkin()
        dateText = addSubView(TextArea(NaN,NaN,"00/00/00 - 00/00/00",self,"date"))/*A TextField that displays the time range of the graph*/
        
        createList()
        alignTimeBar()
    }
}
extension Graph9{
    func createList(){
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/basic/list/vlist.css")//changes the css to align sideways
        StyleManager.addStyle("Graph9 VList{float:none;clear:none;}")
        /**/
        let dp = DayDP(range)//YearDP(range)
        timeBar = addSubView(ScrollFastList(w,24,24,dp,self,nil,.hor,100))
    }
    func alignTimeBar(){
        let objSize = CGSize(w,24)
        Swift.print("objSize: " + "\(objSize)")
        let canvasSize = CGSize(w,h)
        Swift.print("canvasSize: " + "\(canvasSize)")
        let p = Align.alignmentPoint(objSize, canvasSize, Alignment.bottomLeft, Alignment.bottomLeft, CGPoint())
        Swift.print("p: " + "\(p)")
        //align timeBar to bottom with Align
        timeBar!.point = p
    }
}
extension Graph9{
    /**
     * Detects if a zoom gesture has occured +-100 deltaZ
     */
    override func magnify(with event: NSEvent) {
        Swift.print("Graph9.magnify()")
        super.magnify(with: event)
        if(event.phase == .changed){
            zoom += event.deltaZ
        }else if(event.phase == .began){
            zoom = 0//reset
        }else if(event.phase == .ended){
            //Swift.print("zoom: " + "\(zoom)")
            var dir:Int
            if(zoom < -100){
                Swift.print("zoom out")
                dir = 1
            }else if(zoom > 100){
                Swift.print("zoom in")
                dir = -1
            }else{
                Swift.print("no zoom")
                dir = 0
            }
            let newZoom = curZoom + dir
            if(newZoom >= 0 && newZoom < maxZoom){curZoom = newZoom}
            onZoomLevelChange()
            Swift.print("curZoom: " + "\(curZoom)")
        }
        //Swift.print("magnify event: \(event)")
    }
    func onZoomLevelChange() {
        Swift.print("Graph9.onZoomLevelChange()")
        Swift.print("curZoom: " + "\(curZoom)")
        curTimeType = TimeType.types[curZoom]
        Swift.print("curTimeType: " + "\(curTimeType)")
        let dp:DataProvider
        switch curTimeType{
            case .year:
                dp = YearDP(range)
            case .month:
                dp = MonthDP(range)
            case .day:
                dp = DayDP(range)
        }
        ViewModifier.removeAll(timeBar!.lableContainer!)
        timeBar!.pool = []
        timeBar!.inActive = []
        timeBar!.dataProvider = dp
        timeBar!.setProgress(0)
        timeBar!.renderItems(timeBar!.visibleItemRange)
        /**/
        curRange = nil/*rest so we force update dateText*/
        updateDateText()
        //get mouse loc
        //let roundTo(m.x,100) - m.x
        
        //which idx is the mouse closes to, 100px iterations
        
        let rndTo:CGFloat = CGFloat(454).roundTo(100)
        Swift.print("rndTo: " + "\(rndTo)")
        let idx:Int = (rndTo/100).int
        let startIdx:Int = timeBar!.currentVisibleItemRange.start
        let index:Int = startIdx + idx
        //how do you set, just convert idx to progress
        switch curTimeType{
            case .year:
                Swift.print("yr")
                MonthDP.month(<#T##at: Int##Int#>, <#T##yearRange: Range<Int>##Range<Int>#>)
            case .month:
                Swift.print("mnth")
            case .day:
                _ = ()//do nothing
        }
    }
}
extension Graph9{
    override func scrollWheel(with event:NSEvent) {
        Swift.print("Graph9.scrollWheel()")
        super.scrollWheel(with:event)
        updateDateText()
    }
    /**
     * Updates the DateText UI Element
     */
    func updateDateText(){
        
        /*let curDate = self.currentDate.offsetByDays(self.dayOffset)
         Swift.print("curDate.shortDate: " + "\(curDate.shortDate)")
         let lastWeekDate = self.currentDate.offsetByDays(self.dayOffset-7)*/
        
        if(curRange == nil || curRange != timeBar!.currentVisibleItemRange){/*If the range has changed, then update text*/
            curRange = timeBar!.currentVisibleItemRange
            //Swift.print("curRange: " + "\(curRange)")
            
            let yearRange = (timeBar!.dp as! TimeDP).yearRange
            Swift.print("yearRange: " + "\(yearRange)")
            /*let firstIdx = timeBar!.dp.item(range.start)!
             let lastIdx = timeBar!.dp.item(range.end)!
             let firstTitle = firstItem["title"]
             let lastTitle = lastItem["title"]*/
            
            var dateStr:String = ""
            switch curTimeType{
                case .year:
                    /*Year*/
                    let startYearStr:String = YearDP.year(curRange!.start,yearRange).string
                    let endYearStr:String = YearDP.year(curRange!.end,yearRange).string
                    dateStr = "\(startYearStr) - \(endYearStr)"
                case .month:
                    /*Month*/
                    let startMonth:Date = MonthDP.month(curRange!.start, yearRange)
                    let endMonth:Date = MonthDP.month(curRange!.end, yearRange)
                    /*Year*/
                    let startYearIdx:Int = MonthDP.year(curRange!.start, yearRange)//sort of the offset
                    let startYearStr:String = YearDP.year(startYearIdx,yearRange).string
                    let endYearIdx:Int = MonthDP.year(curRange!.end, yearRange)
                    let endYearStr:String = YearDP.year(endYearIdx,yearRange).string
                    dateStr = "\(startYearStr).\(startMonth.shortMonthName) - \(endYearStr).\(endMonth.shortMonthName)"
                case .day:
                    /*day*/
                    let startDayDate:Date = DayDP.day(curRange!.start, yearRange)
                    let startDayDateStr:String = startDayDate.day.string
                    let endDayDate:Date = DayDP.day(curRange!.end, yearRange)
                    let endDayDateStr:String = endDayDate.day.string
                    /*Month*/
                    let startMonthIdx:Int = DayDP.month(curRange!.start,yearRange)
                    let startMonth:Date = MonthDP.month(startMonthIdx, yearRange)
                    let endMonthIdx:Int = DayDP.month(curRange!.end,yearRange)
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
