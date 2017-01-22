import Cocoa

class BarGraph:Graph {
    var bars:[Bar] = []
    var tempVValues:[CGFloat]
    override var vValues:[CGFloat] {return tempVValues}
    /*Gesture related*/
    var twoFingersTouches:[String:NSTouch]?/*temp storage for the twoFingerTouches data*/
    /*Animation related*/
    var animator:Animator?
    //var graphPts:[CGPoint] = []/*Animates to these points*/
    var initGraphPts:[CGPoint] = []/*Animates from these points*/
    /*Debugging*/
    var debugCircDict = [String:EllipseGraphic]()
    override init(_ width:CGFloat, _ height:CGFloat, _ parent:IElement?, _ id: String? = nil) {
        tempVValues = Utils.vValues()//random data is set on init
        super.init(width, height, parent, id)
        self.acceptsTouchEvents = true/*Enables gestures*/
    }
    override func createGraph() {
        createBars()
        //createGraphPoints()
    }
    /**
     * Creates the Bars
     */
    func createBars(){
        //graphArea?.addSubview()
        
        graphPts.forEach{
            let barHeight:CGFloat = $0.y.distance(to:newSize!.height - spacing!.height)// - $0.y
            let bar:Bar = graphArea!.addSubView(Bar(NaN,barHeight,graphArea))//width is set in the css
            bars.append(bar)
            bar.setPosition($0)
        }
    }
    /**
     * Horizontal lines (static)
     */
    func createHLines(){
        let count:Int = vValues.count-2
        var y:CGFloat = spacing!.height
        for _ in 0..<count{
            let hLine = graphArea!.addSubView(Element(newSize!.width-(spacing!.width*2),NaN,graphArea,"hLine"))
            hLine.setPosition(CGPoint(spacing!.width,y))
            y += spacing!.height
        }
    }
    /**
     *
     */
    func iterate(){
        Swift.print("iterate")
        updateGraph()
    }
    /**
     *
     */
    func updateGraph(){
        tempVValues = Utils.vValues()//random data is set
        Swift.print("tempVValues: " + "\(tempVValues)")
        //recalc the maxValue
        maxValue = GraphUtils.maxValue(vValues)//NumberParser.max(vValues)//Finds the largest number in among vValues
        
        //initGraphPts = self.graphPts.map{$0}//grabs the location of where the pts are now
        //self.graphPts = GraphUtils.points(newSize!, newPostition!, spacing!, vValues, maxValue)
        
        initGraphPts = bars.map{$0.frame.origin}//grabs the location of where the pts are now
        graphPts = GraphUtils.points(newSize!, newPosition!, spacing!, vValues, maxValue!)
        //Swift.print("initGraphPts: " + "\(initGraphPts)")
        //Swift.print("graphPts: " + "\(graphPts)")
        /*GraphPoints*/
        
        if(animator != nil){animator!.stop()}/*stop any previous running animation*/
        animator = Animator(Animation.sharedInstance,0.5,0,1,interpolateValue,Easing.easeInQuad)
        animator!.start()
    }
    /**
     * Interpolates between 0 and 1 while the duration of the animation
     */
    func interpolateValue(_ val:CGFloat){
        
        /*GraphPoints*/
        /*for i in 0..<graphPts.count{
            let pos:CGPoint = initGraphPts[i].interpolate(graphPts[i], val)/*interpolates from one point to another*/
            graphPoints[i].setPosition(pos)//moves the points
        }*/
        //Swift.print("interpolateValue() val: \(val)")
        for e in 0..<graphPts.count{
            let pos:CGPoint = initGraphPts[e].interpolate(graphPts[e], val)/*interpolates from one point to another*/
            //if(i == 0){Swift.print("pos.y: " + "\(pos.y)")}
            let barHeight:CGFloat = pos.y.distance(to: newSize!.height - (spacing!.height ))//pos.y 
            let bar:Bar = bars[e]
            bar.setPosition(CGPoint(bar.frame.origin.x,pos.y))
            bar.setBarHeight(barHeight)
            bar.graphic!.draw()
        }
    }
    /**
     * Detects when touches are made
     */
    override func touchesBegan(with event:NSEvent) {
        Swift.print("touchesBeganWithEvent: " + "\(event)")
        twoFingersTouches = GestureUtils.twoFingersTouches(self, event)
        let touches:Set<NSTouch> = event.touches(matching:NSTouchPhase.began, in: self)//touchesMatchingPhase:NSTouchPhaseAny inView:self
        
        for touch in touches {//
            //Swift.print("id: "+"\((touch as! NSTouch).identity)")
            let id:String = "\(touch.identity)"
            let pos:CGPoint = event.localPos(self) - CGPoint(20,20)//touch.normalizedPosition
            //Swift.print("pos: " + "\(pos)")
            let touchPos:CGPoint = CGPoint(touch.normalizedPosition.x,1 + (touch.normalizedPosition.y * -1))//flip the touch coordinates
            
            Swift.print("touchPos: " + "\(touchPos)")
            
            let ellipse = EllipseGraphic(pos.x,pos.y,40,40,FillStyle(NSColor.white.alpha(0.5)),nil)
            debugCircDict[id] = ellipse
            addSubview(ellipse.graphic)
            ellipse.draw()
        }
    }
    /**
     * Detects if a two finger left or right swipe has occured
     */
    override func touchesMoved(with event:NSEvent) {
        //Swift.print("touchesMovedWithEvent: " + "\(event)")
        /*DebugCirc*/
        let touches:Set<NSTouch> = event.touches(matching:NSTouchPhase.any, in: self)//touchesMatchingPhase:NSTouchPhaseAny inView:self
        for touch in touches {
            let id:String = "\(touch.identity)"
            let pos:CGPoint = event.localPos(self) - CGPoint(20,20)//offset pos // touch.normalizedPosition
            //Swift.print("pos: " + "\(pos)")
            let ellipse:EllipseGraphic? = debugCircDict[id]
            ellipse?.setPosition(pos)
            ellipse?.draw()
        }
        /*swipe detection*/
        let swipeType:SwipeType = GestureUtils.swipe(self, event, twoFingersTouches)
        if (swipeType == .right){
            Swift.print("swipe right")
            iterate()
        }else if(swipeType == .left){
            Swift.print("swipe left")
            iterate()
        }else{
            //Swift.print("swipe none")
        }
        
    }
    
    //Basically:
        //onTouchBegan
            //create debugCircle 
            //add the debugCirc to a dictionary that uses the touch.id for key
            //add debugCirc to view
        //onTouchMove
            //loop though event.touches
                //debugCirc[movingTouch.id].setPosition(movingTouch.normalizedPosition)
        //onTouchEnded
            //loop though event.touches
                //remove debugCirc[movingTouch.id]
                //remove debugCirc from view
    
    
    //Finding location of touches:
        //the normalizedTouch is the relative location on the trackpad. values range from 0-1. And are y-flipped
        //you could set debugCirc to mouseLoc if 1 tohc occurs
            //and then relative pos if more touches are added
    
    override func touchesEnded(with event:NSEvent) {//for debugging
        Swift.print("touchesEndedWithEvent: " + "\(event)")
        let touches:Set<NSTouch> = event.touches(matching:NSTouchPhase.ended, in: self)//touchesMatchingPhase:NSTouchPhaseAny inView:self
        for touch in touches {
            let id:String = "\(touch.identity)"
            let ellipse:EllipseGraphic? = debugCircDict.removeValue(forKey: id)
            ellipse?.graphic.removeFromSuperview()
        }
    }
    override func touchesCancelled(with event:NSEvent) {//for debugging
        Swift.print("touchesCancelledWithEvent: " + "\(event)")
    }
    
    override func createVLines(_ size:CGSize, _ position:CGPoint, _ spacing:CGSize) {//we don't want VLines in the BarGraph
        //createHLines()//instead of vLines we create hLines
    }
    override func getClassType() -> String {return "\(Graph.self)"}
    required init(coder:NSCoder) { fatalError("init(coder:) has not been implemented")}
}
class Bar:Element{
    //Use Graphics lib instead of the skin framework to draw the bars.
    //Stub out the code first, then test
    var graphic:RoundRectGraphic?//<--we could also use PolyLineGraphic, but we may support curvey Graphs in the future
    
    override func resolveSkin() {
        //Swift.print("GraphLine.resolveSkin")
        skin = SkinResolver.skin(self)//you could use let style:IStyle = StyleResolver.style(element), but i think skin has to be created to not cause bugs
        //I think the most apropriate way is to make a custom skin and add it as a subView wich would implement :ISkin etc, see TextSkin for details
        //Somehow derive the style data and make a basegraphic with it
        //let lineStyle:ILineStyle = StylePropertyParser.lineStyle(skin!)!//<--grab the style from that was resolved to this component
        let fillStyle:IFillStyle = StylePropertyParser.fillStyle(skin!)
        //LineStyleParser.describe(lineStyle)
        graphic = RoundRectGraphic(-getWidth()/2,0,getWidth(),getHeight(),Fillet(getWidth()/2),fillStyle,nil)
        _ = addSubView(graphic!.graphic)
        graphic!.draw()
    }
    override func setSkinState(_ skinState:String) {
        //update the line, implement this if you want to be able to set the theme of this component
    }
    override func setSize(_ width:CGFloat, _ height:CGFloat) {
        //update the line, implement this if you need win resize support for this component
    }
    /**
     *
     */
    func setBarHeight(_ height:CGFloat){
        let w = getWidth()
        if(height < w && height > 0){//clamps the height to width unless its 0 at which point it doesn't render
            graphic?.setSizeValue(CGSize(w,w))
        }else{ //h >= w || h == 0
            graphic?.setSizeValue(CGSize(w,height))
        }
        graphic!.draw()
    }
}
private class Utils{
    /**
     * Generates random y-axis values
     */
    static func vValues()->[CGFloat]{
        var values:[CGFloat] = []/*commits in a single day*/
        for _ in (0..<7).reversed() {
            let val:CGFloat = IntParser.random(4, 24).cgFloat/*generate vValues via random, as we use faux data for now*/
            values.append(val)
        }
        return values
    }
}
//Continue here:
    //Extract the gesture out of CommitGraph✅
    //override createGraph✅
    //create dummy methods with sudo code that calcs the bars and draws them etc✅
    //dashed line support in css for that ultimate BarGraph look
    //create the touch point visualisations
    //don't do the rounded look before you have the square look working
    //download AppleWatch mockup image (optionally .SVG)
