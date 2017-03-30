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
    }
}
extension Graph9{
    func createList(){
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/basic/list/vlist.css")//changes the css to align sideways
        
        let fromYear:Int = 2010
        let toYear:Int = 2017
        var range:Range<Int> {return fromYear..<toYear}
        let dp = YearDP(range)
        
        let dir:Dir = .hor
        let listSize:CGSize = dir == .ver ? CGSize(100,200) : CGSize(200,24)
        let itemSize:CGSize = CGSize(100,24)
        
        timeBar = addSubView(ScrollFastList(listSize.w,listSize.h,itemSize.height,dp,nil,nil,dir,itemSize.width))
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
