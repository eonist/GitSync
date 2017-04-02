import Cocoa
@testable import Element
@testable import Utils
//Graph9
    //try generate fake graphdata on snapTo anim stop
    //draw the fake graph data as a graphline with points
    //try to update the valuebar
    //add git to the fold (you need to make gitStat parsers for months and years)
    //make it scalable via setSize

class Graph9:Element{
    var dateText:TextArea?
    var timeBar:FastList?
    var valueBar:ValueBar?
    var contentContainer:Element?
    /*Date vars*/
    let fromYear:Int = 2011
    let toYear:Int = 2017//TODO: swap this out with Date().year
    var range:Range<Int> {return fromYear..<toYear}
    /*Zooming vars*/
    var curZoom:Int = TimeType.year.rawValue
    let maxZoom:Int = 3
    var zoom:CGFloat = 0
    /*Interim*/
    var curTimeType:TimeType = .year
    var visibleRange:Range<Int>?
    override func resolveSkin() {
        StyleManager.addStyle("Graph9{float:left;clear:left;fill:green;fill-alpha:0.0;}")//Needed so that scrollWheel works
        StyleManager.addStylesByURL("~/Desktop/datetext.css")
        super.resolveSkin()
        dateText = addSubView(TextArea(NaN,NaN,"00/00/00 - 00/00/00",self,"date"))/*A TextField that displays the time range of the graph*/
        /**/
        contentContainer = addSubView(Container(width,height,self,"content"))
        
        createList()
        updateDateText()
        addGraphLine()
        createValueBar()
    }
    

    override func onEvent(_ event:Event) {
        if(event === (AnimEvent.stopped, (timeBar! as! TimeBar3).mover!)){
            Swift.print("Graph9.timeBar stopped")
        }
        super.onEvent(event)
    }
}
/*CreateContent*/
extension Graph9{
    func createList(){
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/basic/list/vlist.css")//changes the css to align sideways
        StyleManager.addStyle("Graph9 VList{float:none;clear:none;}")
        /**/
        let dp:TimeDP = TimeDPUtils.timeDP(curTimeType,range)
        timeBar = addSubView(TimeBar3(w,24,24,dp,self,nil,.hor,100))
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
    func addGraphLine(){
        //
        var css:String = "GraphLine{"
        css +=    "float:none;"
        css +=    "clear:none;"
        css +=    "line:#2AA3EF;"
        css +=    "line-alpha:1;"
        css +=    "line-thickness:0.5px;"
        css += "}"
        StyleManager.addStyle(css)
        typealias P = CGPoint
        
        //let points:[P] = [P(0,0),P(50,300),P(100,50),P(150,350),P(200,250),P()]
        
        var points:[P] = []
        for i in 0..<7{
            let x:CGFloat = 100*i
            let y:CGFloat = (0..<(height.int-32)).random.cgFloat
            let p = P(x,y)
            points.append(p)
        }
        
        let path:IPath = PolyLineGraphicUtils.path(points)
        let graphLine = contentContainer!.addSubView(GraphLine(width,height,path))
        _ = graphLine
    }
    /**
     * Creates the ValueBar
     */
    func createValueBar(){
        valueBar = addSubView(ValueBar(32,height-32,self))
        let objSize = CGSize(32,valueBar!.h)
        Swift.print("objSize: " + "\(objSize)")
        let canvasSize = CGSize(w,h)
        Swift.print("canvasSize: " + "\(canvasSize)")
        let p = Align.alignmentPoint(objSize, canvasSize, Alignment.topLeft, Alignment.topLeft, CGPoint())
        Swift.print("p: " + "\(p)")
        //align timeBar to bottom with Align
        valueBar!.point = p
    }
}
