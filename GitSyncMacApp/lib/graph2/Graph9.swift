import Cocoa
@testable import Element
@testable import Utils
//Graph9
    //add snapTo animation
    //try generate fake graphdata on snapTo anim stop
    //draw the fake graph data as a graphline with points
    //try to update the valuebar
    //try to update the timeIndicator 
    //add git to the fold
    //make it scalable via setSize

enum TimeType:Int {
    case day = 0,month,year
    static var types:[TimeType] {return [.day,.month,.year]}
}
class Graph9:Element{
    var dateText:TextArea?
    var timeBar:FastList?
    /*Date vars*/
    let fromYear:Int = 2011
    let toYear:Int = 2017//TODO: swap this out with Date().year
    var range:Range<Int> {return fromYear..<toYear}
    /*Zooming vars*/
    var curZoom:Int = TimeType.year.rawValue
    let maxZoom:Int = 3
    var zoom:CGFloat = 0
    /*interim*/
    var curTimeType:TimeType = .year
    var visibleRange:Range<Int>?
    override func resolveSkin() {
        StyleManager.addStyle("Graph9{float:left;clear:left;fill:green;fill-alpha:0.0;}")//Needed so that scrollWheel works
        StyleManager.addStylesByURL("~/Desktop/datetext.css")
        super.resolveSkin()
        dateText = addSubView(TextArea(NaN,NaN,"00/00/00 - 00/00/00",self,"date"))/*A TextField that displays the time range of the graph*/
        
        createList()
        
        updateDateText()
    }
}
extension Graph9{
    func createList(){
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/basic/list/vlist.css")//changes the css to align sideways
        StyleManager.addStyle("Graph9 VList{float:none;clear:none;}")
        /**/
        let dp:TimeDP = TimeDPUtils.timeDP(curTimeType,range)
        timeBar = addSubView(ElasticScrollFastList(w,24,24,dp,self,nil,.hor,100))
        alignTimeBar()
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
        //Swift.print("Graph9.magnify()")
        super.magnify(with: event)
        let prevZoom:Int = curZoom
        if(event.phase == .changed){
            zoom += event.deltaZ
        }else if(event.phase == .began){
            zoom = 0//reset
        }else if(event.phase == .ended){
            var dir:Int
            if(zoom < -100){dir = 1}
            else if(zoom > 100){dir = -1}
            else{dir = 0}
            let newZoom = curZoom + dir
            if(newZoom >= 0 && newZoom < maxZoom){
                curZoom = newZoom
            }
            if(curZoom != prevZoom){
                onZoomLevelChange()//only toggle if zoom is not prevZoom
            }
        }
    }
    func onZoomLevelChange() {
        //Swift.print("Graph9.onZoomLevelChange()")
        let prevTimeType:TimeType = curTimeType
        curTimeType = TimeType.types[curZoom]
        /**/
        timeBar!.removeFromSuperview()
        timeBar = nil
        let dp:TimeDP = TimeDPUtils.timeDP(curTimeType,range)
        timeBar = addSubView(ElasticScrollFastList(w,24,24,dp,self,nil,.hor,100))
        alignTimeBar()
        /*let dp:TimeDP = TimeDPUtils.timeDP(curTimeType,range)
         ViewModifier.removeAll(timeBar!.lableContainer!)
         timeBar!.pool = []
         timeBar!.inActive = []
         timeBar!.dataProvider = dp*/
        Swift.print("🍐 timeBar!.contentSize[timeBar!.dir]: " + "\(timeBar!.contentSize[timeBar!.dir])")
        let mouseLocIdx:Int = StatUtils.mouseLocIdx(mouseX, w, 100)
        Swift.print("mouseLocIdx: " + "\(mouseLocIdx)")
        var progress:CGFloat = StatUtils.progress(timeBar!, (prevTimeType,curTimeType), mouseLocIdx)/*0-1*/
        progress = progress.clip(0, 1)
        Swift.print("progress: " + "\(progress)")
        timeBar!.setProgress(progress)
        //let visRange:Range<Int> = timeBar!.visibleItemRange.start..<(timeBar!.visibleItemRange.end > timeBar!.dp.count ? timeBar!.visibleItemRange.end - 1 : timeBar!.visibleItemRange.end)
        //timeBar!.renderItems(visRange)
        /**/
        visibleRange = nil/*rest so we force update dateText*/
        updateDateText()
    }
}
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
        if(visibleRange == nil || visibleRange != timeBar!.visibleItemRange){/*If the range has changed, then update text*/
            visibleRange = timeBar!.visibleItemRange
            let yearRange = (timeBar!.dp as! TimeDP).yearRange
            Swift.print("yearRange: " + "\(yearRange)")
            var dateStr:String = ""
            switch curTimeType{
                case .year:
                    /*Year*/
                    let startYearStr:String = YearDP.year(visibleRange!.start,yearRange).string
                    let endYearStr:String = YearDP.year(visibleRange!.end,yearRange).string
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
