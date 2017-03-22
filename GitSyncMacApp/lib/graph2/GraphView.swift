import Cocoa
@testable import Element
@testable import Utils

//1. Setup stats with real values, 30 days with ebs and lows. 
//2. When you scroll the ValueBar must adjust its range, you can caluclate this by using y for x code from Trig. The slope is found from the 2 points. 
//3. It's really important that this looks ok, animation wise
//4. you then adjust the graph height to fit the view
//5. you also scale the ValueBar to the latest max


//Zooming tests:
    //

class GraphView:ContainerView2,ElasticScrollable2{
    //var maskSize:CGSize = CGSize()
    //var contentSize:CGSize = CGSize()
    //var contentContainer:Element?
    override var itemSize:CGSize {return CGSize(48,48)}//override this for custom value
    override var interval:CGFloat{return floor(contentSize.w - maskSize.w)/itemSize.width}
    override var progress:CGFloat{return SliderParser.progress(contentContainer!.x, maskSize.w, contentSize.w)}
    var timeBar:TimeBar?
    var valueBar:ValueBar?
    /*Anim*/
    var iterimScroll:InterimScroll = InterimScroll()
    var mover:SnappyRubberBand?
    
    override func resolveSkin() {
        StyleManager.addStyle("GraphView{float:left;clear:left;fill:green;fill-alpha:0.0;}")
        super.resolveSkin()
        /*config*/
        maskSize = CGSize(width,height)/*represents the visible part of the content *///TODO: could be ranmed to maskRect
        contentSize = CGSize(1600,height)/*represents the total size of the content *///TODO: could be ranmed to contentRect
        /*Anim*/
        mover = SnappyRubberBand(Animation.sharedInstance,setProgress/*👈important*/,(0,maskSize.width),(0,contentSize.width),40)
        
        contentContainer = addSubView(Container(width,height,self,"content"))
        //addEllipse()
        addGraphLine()
        createTimeBar()
        createValueBar()
    }
    override open func scrollWheel(with event: NSEvent) {
        Swift.print("GraphView.scrollWheel")
        scroll(event)
        //super.scrollWheel(with: event)
    }
    func setProgress(_ value:CGFloat){
        //Swift.print("🖼️ moving lableContainer up and down progress: \(value)")
        //Swift.print("IScrollable.setProgress() progress: \(progress)")
        //let progressValue = contentSize.w < maskSize.w ? 0 : progress/*pins the lableContainer to the top if itemsHeight is less than height*/
        //Swift.print("progressValue: " + "\(progressValue)")
        
        //let x:CGFloat = ScrollableUtils.scrollTo(progressValue, maskSize.w, contentSize.w)
        contentContainer!.x = value/*we offset the y position of the lableContainer*/
        timeBar!.x = value
    }
    
}

extension GraphView{
    /**
     *
     */
    func addEllipse(){
        let gradient = LinearGradient(Gradients.blue(),[],π/2)
        let lineGradient = LinearGradient(Gradients.deepPurple(0.5),[],π/2)
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
        
        /*let rect = RectGraphic(0,0,width,height,fill,line)
         zoomContainer!.addSubview(rect.graphic)
         rect.draw()*/
        
        let ellipse = EllipseGraphic(p.x,p.y,200,200,fill.mix(Gradients.green()),line.mix(Gradients.lightGreen(0.5)))
        contentContainer!.addSubview(ellipse.graphic)
        ellipse.draw()
    }
    /**
     *
     */
    func addGraphLine(){
        //
        var css:String = "GraphLine{"
        css +=    "float:none;"
        css +=    "clear:none;"
        css +=    "line:#2AA3EF;"
        css +=    "line-alpha:1;"
        css +=    "line-thickness:0.5px;"
        css += "}"
        StyleManager.addStyle(css)
        typealias P = CGPoint
        
        //let points:[P] = [P(0,0),P(50,300),P(100,50),P(150,350),P(200,250),P()]
        
        var points:[P] = []
        for i in 0..<20{
            let x:CGFloat = 100*i
            let y:CGFloat = (0..<(height.int-32)).random.cgFloat
            let p = P(x,y)
            points.append(p)
        }
        
        let path:IPath = PolyLineGraphicUtils.path(points)
        let graphLine = contentContainer!.addSubView(GraphLine(width,height,path))
        _ = graphLine
    }
    /**
     * Creates the TimeBar
     */
    func createTimeBar(){
        //TODO: make line marks
        timeBar = addSubView(TimeBar(contentSize.width,32,20,self))
        let objSize = CGSize(timeBar!.w,32)
        Swift.print("objSize: " + "\(objSize)")
        let canvasSize = CGSize(w,h)
        Swift.print("canvasSize: " + "\(canvasSize)")
        let p = Align.alignmentPoint(objSize, canvasSize, Alignment.bottomLeft, Alignment.bottomLeft, CGPoint())
        Swift.print("p: " + "\(p)")
        //align timeBar to bottom with Align
        timeBar!.point = p
    }
    /**
     * Creates the ValueBar
     */
    func createValueBar(){
        valueBar = addSubView(ValueBar(32,height-32,self))
        let objSize = CGSize(32,valueBar!.h)
        Swift.print("objSize: " + "\(objSize)")
        let canvasSize = CGSize(w,h)
        Swift.print("canvasSize: " + "\(canvasSize)")
        let p = Align.alignmentPoint(objSize, canvasSize, Alignment.topLeft, Alignment.topLeft, CGPoint())
        Swift.print("p: " + "\(p)")
        //align timeBar to bottom with Align
        valueBar!.point = p
    }
}
//TimeBar
//ValueBar
//GraphLine2
//HorizontalView


/*override func scrollWheel(with event: NSEvent) {//TODO: move to displaceview
 Swift.print("scrollWheel: ")
 //scroll(event)/*forward the event to the extension which adjust Slider and calls setProgress in this method*/
 super.scrollWheel(with: event)/*forward the event other delegates higher up in the stack*/
 switch event.phase{
 case NSEventPhase.changed:onScrollWheelChange(event)/*Fires everytime there is direct scrollWheel gesture movment and momentum, the momentum fades.*/
 case NSEventPhase(rawValue:0):onScrollWheelChange(event);/*Swift.print("none");*/break;//swift 3 update, was -> NSEventPhase.none
 default:break;
 }
 }*/
/**
 * NOTE: Basically when you perform a scroll-gesture on the touch-pad
 */
/*func onScrollWheelChange(_ event:NSEvent) {/*Direct scroll, not momentum*/
 Swift.print("📜 Scrollable.onScrollWheelChange: \(event.type)")
 let progressVal:CGFloat = SliderListUtils.progress(event.deltaX, interval, progress)
 setProgress(progressVal)
 }*/
