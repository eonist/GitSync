import Cocoa
@testable import Utils
@testable import Element
/**
 * This tests pinching in and out and transitioning between timeLevels
 */
class Graph5:ContainerView2{
    lazy var gestureHUD:GestureHUD  =  GestureHUD(self)
    var dayNames:[String] {return ["M","T","W","T","F","S","S"]}
    var monthNames:[String] { return ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]}
    var yearNames:[String] { return ["11","12","13","14","15","16","17"] }
    var timeLevels:[[String]]  {return [dayNames,monthNames,yearNames]}
    override var itemSize:CGSize {return CGSize(48,48)}//override this for custom value
    var timeBar:TimeBar2?
    /*Anim*/
    
    //TimeBar with 7 items
    //gesture recognizer
    //change timeBar textFields on gesture event
    var curZoom:Int = 0
    let maxZoom:Int = 3
    
    override func resolveSkin() {
        StyleManager.addStyle("Graph5{float:left;clear:left;fill:green;fill-alpha:0.0;}")//Needed so that scrollWheel works
        super.resolveSkin()
        
        /*config*/
        Swift.print("⚠️️IMPLEMENT THE BELLOW AS COMPUTED PROPS⚠️️")
        //maskSize = CGSize(width,height)/*represents the visible part of the content *///TODO: could be ranmed to maskRect
        //contentSize = CGSize(1600,height)/*represents the total size of the content *///TODO: could be ranmed to contentRect
        
        /*add UI*/
        createTimeBar()
        
        /*debug*/
        self.acceptsTouchEvents = true/*Enables gestures*/
        self.wantsRestingTouches = true/*Makes sure all touches are registered. Doesn't register when used in playground*/
    }
    
    
    var zoom:CGFloat = 0
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
        var timeLevel:[String] = timeLevels[curZoom]
        timeLevel = timeLevel.slice2(0, 7)
        (0..<7).forEach{ i in
            timeBar!.textAreas[i].setTextValue(timeLevel[i])
        }
    }
}
extension Graph5{
    /**
     * Creates the TimeBar
     */
    func createTimeBar(){
        //TODO: make line marks
        timeBar = addSubView(TimeBar2(contentSize.width,32,dayNames,self))
        let objSize = CGSize(timeBar!.w,32)
        Swift.print("objSize: " + "\(objSize)")
        let canvasSize = CGSize(w,h)
        Swift.print("canvasSize: " + "\(canvasSize)")
        let p = Align.alignmentPoint(objSize, canvasSize, Alignment.bottomLeft, Alignment.bottomLeft, CGPoint())
        Swift.print("p: " + "\(p)")
        //align timeBar to bottom with Align
        timeBar!.point = p
    }
}
/*Debug*/
extension Graph5{
    override func touchesBegan(with event:NSEvent) {
        gestureHUD.touchesBegan(event)
    }
    override func touchesMoved(with event:NSEvent) {
        gestureHUD.touchesMoved(event)
    }
    override func touchesEnded(with event:NSEvent) {
        gestureHUD.touchesEnded(event)
    }
}
