import Cocoa
@testable import Element
@testable import Utils
/**
 * New Graph component (dynamic/zoomable/slidable/snappable) (year/month/day/hour)
 * Inspiration from DrawLab
 */
class Graph2:ElasticView{
    //override var itemsHeight: CGFloat {return height}
    //override var itemHeight: CGFloat {return 24}
    var gestureHUD:GestureHUD?
    
    override func resolveSkin() {
        StyleManager.addStyle("Graph2 {fill:green;fill-alpha:0;}")
        super.resolveSkin()
        
        let gradient = LinearGradient(Gradients.red(),[],π/2)
        let lineGradient = LinearGradient(Gradients.redOrange(0.5),[],π/2)
        /*Styles*/
        let fill:GradientFillStyle = GradientFillStyle(gradient);
        let lineStyle = LineStyle(20,NSColorParser.nsColor(Colors.green()).alpha(0.5),CGLineCap.round)
        let line = GradientLineStyle(lineGradient,lineStyle)
        
        let objSize:CGSize = CGSize(200,200)
        Swift.print("objSize: " + "\(objSize)")
        let viewSize:CGSize = CGSize(width,height)
        Swift.print("viewSize: " + "\(viewSize)")
        let p = Align.alignmentPoint(objSize, viewSize, Alignment.centerCenter, Alignment.centerCenter,CGPoint())
        Swift.print("p: " + "\(p)")
        let ellipse = EllipseGraphic(p.x,p.y,200,200,fill.mix(Gradients.redOrange()),line.mix(Gradients.red(0.5)))
        
        contentContainer!.addSubview(ellipse.graphic)
        ellipse.draw()
        
        /*Debug*/
        gestureHUD = GestureHUD(self)
        //self.acceptsTouchEvents = true/*Enables gestures*/
        //self.wantsRestingTouches = true/*Makes sure all touches are registered. Doesn't register when used in playground*/
    }
    /**
     * Detects when touches are made
     * NOTE: event.localPos(self) equals the pos of the mouseCursor
     */
    override func touchesBegan(with event:NSEvent) {
        //Swift.print("touchesBeganWithEvent: " + "\(event)")
        /*Debug*/
        gestureHUD!.touchesBegan(event)
    }
    /**
     * Detects if a two finger left or right swipe has occured
     */
    override func touchesMoved(with event:NSEvent) {
        //Swift.print("touchesMovedWithEvent: " + "\(event)")
        /*Debug*/
        gestureHUD!.touchesMoved(event)
    }
    /**
     * NOTE: playground doesn't fire a touch up when there is only one touch detected. to work aroudn this limitation you have to detect any touch and then when there are only 2, delete all debugCircs
     */
    override func touchesEnded(with event:NSEvent) {//for debugging
        Swift.print("touchesEndedWithEvent: " + "\(event)")
        //Swift.print("event.phase.type: " + "\(event.phase.type)" + " event.phase: " + "\(event.phase)")
        /*Debug*/
        gestureHUD!.touchesEnded(event)
    }
    override func touchesCancelled(with event:NSEvent) {//for debugging
        Swift.print("touchesCancelledWithEvent: " + "\(event)")
    }
    
    //bottomBar
    //rightBar
    //graphLine
    //graphPoint
    
}

//Pinch to zoom
//slidable in x-axis
//bounce back x-axis
//bounce back on zoom min and max
//Snappable x-axis (possibly snappable z-axis)
//1. try with fake date data first (14 days at 7 days resolution)
//2. you need to adjust the graph in the visible time span. 
    //from day 5 to 12 the range is 0...122, but for 6-13 its 0...96
    //you must adjust rightBar according to the interpolated high between 2 time units. 
//3. When you zoom you reach a threshold between time units, day to hour for instance. 
    //when the threshold is reached you animate the transition in the graphLine by:
    //See old notes about day units, and how many to use. 5, 9, 6, 7, 12
    //the day GraphDot becomes the EOD in hour mode, so graphline tesselate around this point
    //The graph Dot grows in size to reveal it self 0.2 sec anim, and shrinks if removed etc.
    //The graph dots animate to their destination regardless of zooming, zoom only zooms the canvas, graph can still move.
    //


    
