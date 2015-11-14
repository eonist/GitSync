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
        getGrapix().path = CGPathParser.rect(CGFloat(100), CGFloat(100))//Shapes
        
    }
}
class RoundRectGrapix{//adds round-rectangular path
    init(){
        
    }
}
class GradientGrapix{//adds Gradient fill
    init(){
        
    }
}