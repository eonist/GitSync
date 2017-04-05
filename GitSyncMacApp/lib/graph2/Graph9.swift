import Cocoa
@testable import Element
@testable import Utils
import GitSyncMac

class Graph9:Element{
    lazy var gestureHUD:GestureHUD = GestureHUD(self)
    var dateText:TextArea?
    var timeBar:TimeBar3?
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
    /*State related*/
    var prevRange:Range<Int>?
    var prevRangeScrollChange:Range<Int>?
    var prevZoom:Int?
    override func resolveSkin(){
        StyleManager.addStyle("Graph9{float:left;clear:left;fill:green;fill-alpha:0.0;}")//Needed so that scrollWheel works
        StyleManager.addStylesByURL("~/Desktop/datetext.css")
        super.resolveSkin()
        dateText = addSubView(TextArea(NaN,NaN,"00/00/00 - 00/00/00",self,"date"))/*A TextField that displays the time range of the graph*/
        /**/
        contentContainer = addSubView(Container(width,height,self,"content"))
        createTimeBar()
        updateDateText()
        createGraphLine()
        createGraphPoints()
        createValueBar()
        /*Debug*/
        acceptsTouchEvents = true/*Enables gestures*/
        wantsRestingTouches = true/*Makes sure all touches are registered. Doesn't register when used in playground*/
        
        //Swift.print("visibleRange: " + "\(visibleRange)")
    }
    override func onEvent(_ event:Event) {
        /*if(event is AnimEvent){
         }*/
        if(event === (AnimEvent.stopped, timeBar!.mover!)){
            //Swift.print("Graph9.timeBar completed")
            //Swift.print("event.origin: " + "\(event.origin)")
            //Swift.print("event.type: " + "\(event.type)")
            //Swift.print("event.origin: " + "\(event.origin)")
            //Swift.print("prevVisibleRange: " + "\(prevVisibleRange)")
            //Swift.print("visibleRange: " + "\(visibleRange)")
            Swift.print("timeBar!.visibleItemRange: " + "\(timeBar!.visibleItemRange)")
            let isVelocityZero:Bool = timeBar!.mover!.velocity == 0//quick fix
            //Swift.print("isVelocityZero: " + "\(isVelocityZero)")
            if(isVelocityZero && hasPanningChanged(&prevRange)){
                Swift.print("✅ a change has happened")
                //prevVisibleRange = visibleRange
                update()
            }else{
                Swift.print("🚫 a change has not happened")
            }
        }
        super.onEvent(event)
    }
}
