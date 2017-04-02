import Cocoa
@testable import Element
@testable import Utils
//Graph9
    //try generate fake graphdata on snapTo anim stop
    //draw the fake graph data as a graphline with points ✅
    //try to update the valuebar
    //add git to the fold (you need to make gitStat parsers for months and years)
    //make it scalable via setSize

class Graph9:Element{
    var dateText:TextArea?
    var timeBar:FastList?
    var valueBar:ValueBar?
    var contentContainer:Element?
    var graphPoints:[Element]?
    var graphLine:GraphLine?
    var graphPts:[CGPoint]?
    var prevGraphPts:[CGPoint]?
    var animator:Animator?
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
        createGraphLine()
        createGraphPoints()
        createValueBar()
    }
    override func onEvent(_ event:Event) {
        if(event === (AnimEvent.stopped, (timeBar! as! TimeBar3).mover!)){
            Swift.print("Graph9.timeBar stopped")
            Swift.print("event.origin: " + "\(event.origin)")
            updateGraph()
        }
        super.onEvent(event)
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
     * Interpolates between 0 and 1 while the duration of the animation
     * NOTE: ReCalc the hValue indicators (each week has a different max hValue etc)
     */
    func interpolateValue(_ val:CGFloat){
        //Swift.print("interpolateValue() val: " + "\(val)")
        var positions:[CGPoint] = []
        /*GraphPoints*/
        for i in 0..<graphPts!.count{
            let pos:CGPoint = prevGraphPts![i].interpolate(graphPts![i], val)/*interpolates from one point to another*/
            positions.append(pos)
            graphPoints![i].setPosition(pos)//moves the points
        }
        /*GraphLine*/
        let path:IPath = PolyLineGraphicUtils.path(positions)/*convert points to a Path*/
        //TODO: Ideally we should create the CGPath from the points use CGPathParser.polyline
        let cgPath = CGPathUtils.compile(CGMutablePath(), path)//convert path to cgPath
        graphLine!.line!.cgPath = cgPath.clone()//applies the new path
        graphLine!.line!.draw()//draws the path
    }
}

