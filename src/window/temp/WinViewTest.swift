import Cocoa


//Continue here, add GradientDecorator , CircleDecorator, DropShadowDecorator, others?


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
        grapix = RoundRectGrapix(grapix)
        grapix = GradientGrapix(grapix)
        
        CGContextEndTransparencyLayer(grapix.getGrapix().graphics.context)//end the transperancy-layer
    }
}
protocol IGrapixDecorator{
    func getGrapix() -> Grapix
    func fill()
    func clear()
    func beginFill()
    func drawFill()
    func stylizeFill()
}
class GrapixDecorator:IGrapixDecorator{
    var decoratable:IGrapixDecorator
    init(_ decoratable:IGrapixDecorator){
        self.decoratable = decoratable
        fill()
    }
    func fill(){
        clear()
        beginFill()
        drawFill()
        stylizeFill()
    }
    func clear(){
        decoratable.clear()
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
    func fill(){
        //
    }
    func clear(){
        CGContextClearRect(getGrapix().graphics.context, CGContextGetClipBoundingBox(getGrapix().graphics.context))//clear previouse drawings
    }
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
    }
    override func drawFill() {
        getGrapix().path = CGPathParser.rect(CGFloat(100), CGFloat(100))//Shapes
    }
}
class RoundRectGrapix:GrapixDecorator{//adds round-rectangular path
    override init(_ decoratable: IGrapixDecorator) {
        super.init(decoratable)
    }
    override func drawFill() {
        let fillet:Fillet = Fillet(20)
        getGrapix().path = CGPathParser.roundRect(0,0,CGFloat(200), CGFloat(200),CGFloat(fillet.topLeft), CGFloat(fillet.topRight), CGFloat(fillet.bottomLeft), CGFloat(fillet.bottomRight))//Shapes
        //getGrapix().path = CGPathParser.rect(CGFloat(150), CGFloat(50))//Shapes
    }
}
class GradientGrapix:GrapixDecorator{//adds Gradient fill
    override init(_ decoratable: IGrapixDecorator) {
        super.init(decoratable)
    }
    override func beginFill() {
        let randomColor:NSColor = NSColor.orangeColor()//ColorUtils.randomColor()
        GraphicModifier.applyProperties(getGrapix().graphics, FillStyle(randomColor)/*, lineStyle*/)//apply style
    }
}