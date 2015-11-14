import Cocoa

class WinViewTest:FlippedView {
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override func drawRect(dirtyRect: NSRect) {
        let skinLayer:SkinLayer = SkinLayer()
        addSubview(skinLayer)
    }
}
class SkinLayer:Graphic{//container class that hold the decorator structure.
    override func drawRect(dirtyRect: NSRect) {
        Swift.print("SkinLayer.drawRect() ")
        //create the structure here
        var grapix:IGrapixDecorator = Grapix()
        grapix = RectGrapix(grapix)
        //grapix = RoundRectGrapix(grapix)
        
        CGContextEndTransparencyLayer(grapix.getGrapix().graphics.context)//end the transperancy-layer
    }
}
protocol IGrapixDecorator{
    func getGrapix() -> Grapix
    func fill()
    func beginFill()
    func drawFill()
    func stylizeFill()
}
class GrapixDecorator:IGrapixDecorator{
    var decoratable:IGrapixDecorator
    init(_ decoratable:IGrapixDecorator){
        self.decoratable = decoratable
    }
    func fill(){
        decoratable.fill()
    }
    func beginFill(){
        decoratable.beginFill()
    }
    func drawFill(){
        decoratable.drawFill()
    }
    func stylizeFill(){
        decoratable.stylizeFill()
    }
    func getGrapix() -> Grapix{
        return self.decoratable.getGrapix()
    }
}
class Grapix:IGrapixDecorator{//base class for decorators
    var graphics:Graphics
    var path:CGPath = CGPathCreateMutable()
    init(){
        graphics = Graphics()
        CGContextBeginTransparencyLayer(graphics.context, nil);//begin the transperancy-layer
    }
    /**
     *
     */
    func fill(){
        beginFill()
        drawFill()
        stylizeFill()
    }
    /**
     *
     */
    func beginFill(){
        GraphicModifier.applyProperties(getGrapix().graphics, FillStyle(NSColor.purpleColor())/*, lineStyle*/)//apply style
    }
    func drawFill(){
        //
    }
    func stylizeFill(){
        GraphicModifier.stylize(getGrapix().path,getGrapix().graphics)//realize style on the graphic
    }
    /**
     *
     */
    func getGrapix()->Grapix{
        return self
    }
}
class RectGrapix:GrapixDecorator{//adds rectangular path
    override init(_ decoratable: IGrapixDecorator) {
        super.init(decoratable)
        fill()
    }
    override func fill() {
        Swift.print("RectGrapix.fill()")
        getGrapix().path = CGPathParser.rect(CGFloat(100), CGFloat(100))//Shapes
        super.fill()
    }
}
class RoundRectGrapix:GrapixDecorator{//adds round-rectangular path
    override init(_ decoratable: IGrapixDecorator) {
        super.init(decoratable)
        fill()
    }
    override func fill() {
        Swift.print("RoundRectGrapix.fill()")
        CGContextClearRect(getGrapix().graphics.context, NSMakeRect(0, 0, 500, 500))//clear previouse drawings
        super.beginFill()
        getGrapix().path = CGPathParser.rect(CGFloat(150), CGFloat(50))//Shapes
        super.stylizeFill()
    }
}
class GradientGrapix{//adds Gradient fill
    init(){
        
    }
}