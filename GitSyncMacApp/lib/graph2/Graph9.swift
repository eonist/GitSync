import Cocoa
@testable import Element
@testable import Utils
//Graph9
    //add fastList .hor ✅
    //try it with year,month,day ✅
    //try to add pinch gestures to the fold
    //try to calc the pos of mouse in relation to the timeBar
    //try to zoom in and out with correct indecies
    //try generate fake graphdata on anim stop
    //draw the fake graph data as a graphline with points
    //try to update the valuebar
    //try to update the timeIndicator 
    //add git to the fold

enum TimeType {
    case year,month,day
    static var types:[TimeType] {return [TimeType.year,TimeType.month,TimeType.day]}
}
class Graph9:Element{
    var timeBar:ScrollFastList?
    /*Date stuff*/
    let fromYear:Int = 2011
    let toYear:Int = 2017
    var range:Range<Int> {return fromYear..<toYear}
    /*Zooming vars*/
    var curZoom:Int = 0
    let maxZoom:Int = 3
    var zoom:CGFloat = 0
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
        let timeType:TimeType = TimeType.types[curZoom]
        let dp:DataProvider
        switch timeType{
            case .year:
                dp = YearDP()
            case .month:
                dp = YearDP()
            case .day:
                dp = YearDP()
        }
        timeBar!.dataProvider = dp
    }
}
