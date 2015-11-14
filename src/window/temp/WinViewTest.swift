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
        CGContextEndTransparencyLayer(grapix.getGrapix().graphics.context)
    }
}
protocol IGrapixDecorator{
    func getGrapix() -> Grapix
    func fill()
}
class GrapixDecorator:IGrapixDecorator{
    var decoratable:IGrapixDecorator
    init(_ decoratable:IGrapixDecorator){
        self.decoratable = decoratable
    }
    func fill(){
        decoratable.fill()
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
        CGContextBeginTransparencyLayer(graphics.context, nil);
    }
    /**
     *
     */
    func fill(){
        GraphicModifier.applyProperties(getGrapix().graphics, FillStyle(NSColor.purpleColor())/*, lineStyle*/)//apply style
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
        CGContextClearRect(getGrapix().graphics.context, NSMakeRect(0, 0, 500, 500))

        getGrapix().path = CGPathParser.rect(CGFloat(50), CGFloat(50))//Shapes
        super.fill()
    }
}
class GradientGrapix{//adds Gradient fill
    init(){
        
    }
}