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
    var graphPts:[CGPoint]?
    var prevGraphPts:[CGPoint]?
    var graphPoints:[Element]?
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
        }
        super.onEvent(event)
    }
    /**
     * Re-calc and set the graphPoint positions (for instance if the hValues has changed etc)
     */
    func updateGraph(){
        
        prevGraphPts = graphPoints.map{$0.frame.origin}//grabs the location of where the pts are now
        graphPts = randomGraphPoints
        
        /*GraphPoints*/
        
        if(animator != nil){animator!.stop()}/*stop any previous running animation*/
        animator = Animator(Animation.sharedInstance,0.5,0,1,interpolateValue,Quad.easeIn)
        animator!.start()
        
        
    }
}

