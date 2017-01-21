import Cocoa

class BarGraph:Graph {
    var bars:[Bar] = []
    var twoFingersTouches:NSMutableDictionary?/*temp storage for the twoFingerTouches data*/
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
            bar.setPosition($0)//remember to offset with half the width in the css
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
        }else if(swipeType == .left){
            Swift.print("swipe left")
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
        }else if(){
            
        }
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
