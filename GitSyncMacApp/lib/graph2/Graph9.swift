import Cocoa
@testable import Element
@testable import Utils
//Graph9
    //add Elasticity yo Graph9 
    //add snapTo animation
    //try generate fake graphdata on snapTo anim stop
    //draw the fake graph data as a graphline with points
    //try to update the valuebar
    //try to update the timeIndicator 
    //add git to the fold
    //make it scalable via setSize


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
