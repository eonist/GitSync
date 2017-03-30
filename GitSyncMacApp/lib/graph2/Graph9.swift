import Foundation
@testable import Element
@testable import Utils
//Graph9
    //add fastList .hor 👈
    //try it with year,month,day
    //try to add pinch gestures to the fold
    //try to calc the pos of mouse in relation to the timeBar
    //try to zoom in and out with correct indecies
    //try generate fake graphdata on anim stop
    //draw the fake graph data as a graphline with points
    //try to update the valuebar
    //try to update the timeIndicator
    //add git to the fold
class Graph9:Element{
    var timeBar:Element?
    override func resolveSkin() {
        StyleManager.addStyle("Graph9{float:left;clear:left;fill:green;fill-alpha:0.0;}")//Needed so that scrollWheel works
        super.resolveSkin()
        createList()
        alignTimeBar()
    }
}
extension Graph9{
    func createList(){
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/basic/list/vlist.css")//changes the css to align sideways
        StyleManager.addStyle("Graph9 VList{float:none;clear:none;}")
        let fromYear:Int = 2010
        let toYear:Int = 2017
        var range:Range<Int> {return fromYear..<toYear}
        let dp = YearDP(range)
        
        timeBar = addSubView(ScrollFastList(w,24,24,dp,self,nil,.hor,100))
    }
    /**
     *
     */
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
