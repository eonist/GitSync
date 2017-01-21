import Cocoa

class BarGraph:Graph {
    var bars:[Bar] = []
    override var vValues: [CGFloat] {return Utils.vValues()}
    /*Gesture related*/
    var twoFingersTouches:NSMutableDictionary?/*temp storage for the twoFingerTouches data*/
    /*Animation related*/
    var animator:Animator?
    var graphPts:[CGPoint] = []/*Animates to these points*/
    var initGraphPts:[CGPoint] = []/*Animates from these points*/
    
    override init(_ width:CGFloat, _ height:CGFloat, _ parent:IElement?, _ id: String? = nil) {
        super.init(width, height, parent, id)
        
        self.acceptsTouchEvents = true/*Enables gestures*/
    }
    override func createGraph(_ graphPts:[CGPoint]) {
        createBars(graphPts)
    }
    /**
     * Creates the Bars
     */
    func createBars(_ graphPts:[CGPoint]){
        //graphArea?.addSubview()
        graphPts.forEach{
            let barHeight:CGFloat = newSize!.height - spacing!.height - $0.y
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
        let maxValue:CGFloat = NumberParser.max(vValues)//Finds the largest number in among vValues
        
        graphPts = GraphUtils.points(newSize!, newPostition!, spacing!, vValues, maxValue)
        initGraphPts = graphPoints.map{$0.frame.origin}//grabs the location of where the pts are now
        Swift.print("initGraphPts: " + "\(initGraphPts)")
        /*GraphPoints*/
        
        if(animator != nil){animator!.stop()}/*stop any previous running animation*/
        animator = Animator(Animation.sharedInstance,0.5,0,1,interpolateValue,Easing.easeInQuad)
        animator!.start()
    }
    /**
     * Interpolates between 0 and 1 while the duration of the animation
     */
    func interpolateValue(_ val:CGFloat){
        Swift.print("interpolateValue() val: " + "\(val)")
        for i in 0..<graphPts.count{
            let pos:CGPoint = initGraphPts[i].interpolate(graphPts[i], val)/*interpolates from one point to another*/
            let barHeight:CGFloat = newSize!.height - spacing!.height - pos.y
            let bar:Bar = bars[i]
            bar.setPosition(CGPoint(bar.frame.origin.x,pos.y))
            bar.setBarHeight(barHeight)
            bar.graphic!.draw()
        }
    }
    /**
     * Detects when touches are made
     */
    override func touchesBegan(with event:NSEvent) {
        //Swift.print("touchesBeganWithEvent: " + "\(touchesBeganWithEvent)")
        twoFingersTouches = GestureUtils.twoFingersTouches(self, event)
    }
    /**
     * Detects if a two finger left or right swipe has occured
     */
    override func touchesMoved(with event:NSEvent) {
        //Swift.print("touchesMovedWithEvent: " + "\(touchesMovedWithEvent)")
        let swipeType:SwipeType = GestureUtils.swipe(self, event, &twoFingersTouches)
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
    override func touchesEnded(with event:NSEvent) {//for debugging
        //Swift.print("touchesEndedWithEvent: " + "\(touchesEndedWithEvent)")
    }
    override func touchesCancelled(with event:NSEvent) {//for debugging
        //Swift.print("touchesCancelledWithEvent: " + "\(touchesCancelledWithEvent)")
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
