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
    }
}
extension Graph9{
    override func scrollWheel(with event: NSEvent) {
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
        let range = timeBar!.currentVisibleItemRange
        let firstItem = timeBar!.dp.item(range.start)!
        let lastItem = timeBar!.dp.item(range.end)!
        let firstTitle = firstItem["title"]
        let lastTitle = lastItem["title"]
        
        //continue here:
            //you also have to use the progress to find date info. Use the offset methods you wrote yesterday
        
        var dateStr:String = ""
        switch curTimeType{
            case .year:
                dateStr = "2011 - 2017"
            case .month:
                dateStr = "2011.Feb - 2011.Sep"
            case .day:
                let startMonthIdx:Int = DayDP.month(range.start,range)
                dateStr = "2011.Feb.20 - 2011.Sep.27"
        }
        dateText!.setTextValue(dateStr)
    }
}
