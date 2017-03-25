import Cocoa
@testable import Utils
@testable import Element
/**
 * This tests animate graphpoint to graphline on scrollend
 */
class Graph3:ContainerView2,Scrollable2{
    typealias P = CGPoint
    var points:[CGPoint] = []
    var graphPoint1:Element?
    var graphLine:GraphLine?
    var space:CGFloat = 100/*x space between points*/
    var animator:Animator?
    override var itemSize:CGSize {return CGSize(100,100)}//override this for custom value
    override var interval:CGFloat{return floor(contentSize.w - maskSize.w)/itemSize.width}
    override var progress:CGFloat{return SliderParser.progress(contentContainer!.x, maskSize.w, contentSize.w)}
    /**
     * 🔨 Setup
     */
    override func resolveSkin() {
        StyleManager.addStyle("Graph3{float:none;clear:none;fill:green;fill-alpha:0.0;}")
        super.resolveSkin()
        /*config*/
        maskSize = CGSize(width,height)/*represents the visible part of the content *///TODO: could be ranmed to maskRect
        contentSize = CGSize(1800,height)/*represents the total size of the content *///TODO: could be ranmed to contentRect
        
        addGraphLine()
        addGraphPoint()
    }
    var startY:CGFloat?
    var endY:CGFloat?
}
extension Graph3{
    /**
     *
     */
    override open func scrollWheel(with event: NSEvent) {
        Swift.print("Graph3.scrollWheel")
        scroll(event)
        //super.scrollWheel(with: event)
    }
    /**
     *
     */
    func onScrollWheelChange(_ event:NSEvent) {/*Direct scroll, not momentum*/
        Swift.print("onScrollWheelChange() event.scrollingDeltaX: \(event.scrollingDeltaX)")
        if(event.scrollingDeltaX == 0){
            scrollingEnded()
        }
        
        let progressVal:CGFloat = SliderListUtils.progress(event.deltaX, interval, progress)
        setProgress(progressVal)
    }
    /**
     * 🚗 SetProgress
     */
    func setProgress(_ progress:CGFloat){
        let x:CGFloat = ScrollableUtils.scrollTo(progress, maskSize.w, contentSize.w)
        Swift.print("x: " + "\(x)")
        contentContainer!.x = x
        
    }
    func moveY(_ y:CGFloat){
        graphPoint1!.point = P(width/2,y)
    }
    
    func onScrollWheelEnter() {
        Swift.print("onScrollWheelEnter")
        startY = graphPoint1!.point.y
    }
    func scrollingEnded(){
        Swift.print("onScrollWheelExit")
        let x:CGFloat = contentContainer!.x
        let x2:CGFloat = (-1 * x) + (width/2)
        let y2:CGFloat = findY(x2,points)
        endY = y2
        
        if(animator != nil){animator!.stop()}/*stop any previous running animation*/
        animator = Animator(Animation.sharedInstance,0.2,startY!,endY!,moveY,Sine.easeOut)
        animator!.event = {(event:Event) -> Void in }
        animator!.start()
    }
    func onScrollWheelExit() {
        
    }
}
extension Graph3{
    /**
     * 🐍 GraphLine
     */
    func addGraphLine(){
        addGraphLineStyle()
        let h:Int = height.int
        points = (0...30).map{
            let x:CGFloat = 100*$0
            let y:CGFloat = (0..<(h)).random.cgFloat
            return P(x,y)
        }
        let path:IPath = PolyLineGraphicUtils.path(points)
        graphLine = contentContainer!.addSubView(GraphLine(width,height,path))
    }
    /**
     * 🎯 GraphPoint
     */
    func addGraphPoint(){
        /*gp1*/
        addGraphPointStyle()
        
        let p = findGraphP(width/2,points)
        Swift.print("-p-: " + "\(p)")
        
        graphPoint1 = self.addSubView(Element(NaN,NaN,self,"graphPoint"))
        graphPoint1!.setPosition(p)
    }
}
/**
 * 🎨 Styles
 */
extension Graph3{
    func addGraphLineStyle(){
        var css:String = "GraphLine{"
        css +=    "float:none;"
        css +=    "clear:none;"
        css +=    "line:#2AA3EF;"
        css +=    "line-alpha:1;"
        css +=    "line-thickness:0.5px;"
        css += "}"
        StyleManager.addStyle(css)
    }
    func addGraphPointStyle(){
        /*GraphPoint*/
        var css:String = ""
        css += "Element#graphPoint{"
        css +=     "float:none;"
        css +=     "clear:none;"
        css +=     "fill:#128BF2,#192633;"
        css +=     "width:12px,11px;"
        css +=     "height:12px,11px;"
        css +=     "margin-left:-6px,-5.5px;"
        css +=     "margin-right:6px,5.5px;"
        css +=     "margin-top:-6px,-5.5px;"
        css +=     "margin-bottom:6px,5.5px;"
        css +=     "drop-shadow:drop-shadow(1px 90 #000000 0.3 0.5 0.5 0 0 false);"
        css +=     "corner-radius:6px,5.5px;"
        css += "}"
        StyleManager.addStyle(css)
    }
}

extension Graph3{
    /**
     *
     */
    func findGraphP(_ x:CGFloat, _ points:[P]) -> P{
        let y:CGFloat = findY(x,points)
        let p:P = P(x,y)
        return p
    }
    /**
     *
     */
    func findY(_ x:CGFloat, _ points:[P])->CGFloat{
        Swift.print("x: " + "\(x)")
        var seg:(p1:P,p2:P)?
        for i in 0..<points.count-1{
            let cur = points[i]
            let next = points[i+1]
            if(x >= cur.x && x <= next.x){//within
                seg = (cur,next)
                break
            }
        }
        //seg = seg ?? (points[points.count-2],points.last!)
        Swift.print("seg: " + "\(seg)")
        let slope:CGFloat = CGPointParser.slope(seg!.p1, seg!.p2)
        Swift.print("slope: " + "\(slope)")
        let y:CGFloat = CGPointParser.y(seg!.p1, x, slope)/*seg!.p2.x*/
        return y
    }
}
//When you scroll fast
    //lots of new points pass through
    //To avoid a jittery feel 👈
    //we must......????
    //the end destination of the graphPoints
        //must always be the end destination of the animation

    //maybe you can make gravity, like easing the closer that it gets to the target but based on actual dist not percentage
    //So you create a mover that moves with 10px per sec speed, and slows down the last 40pix before it reaches its destination

    //To prototype this you need to create a random graph on 1800px canvas from 0 to height
        //then you animate a dot in the center to always try and reach the graph intersection on this gravity springsolver
        //it also needs to easeOut based on dist from origin
    //at first you just do animator easinOut animation to test the look
        //then you do more complex easing by checking distance, when an animation started etc. 
