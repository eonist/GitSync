import Cocoa

class WinViewTest:FlippedView {
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override func drawRect(dirtyRect: NSRect) {
        createContent()
    }
    /**
     *
     */
    func createContent(){
        
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
}
class GrapixDecorator:IGrapixDecorator{
    var decoratable:IGrapixDecorator
    init(_ decoratable:IGrapixDecorator){
        self.decoratable = decoratable
    }
    func getGrapix() -> Grapix{
        return self.decoratable.getGrapix()
    }
}
class Grapix:IGrapixDecorator{//base class for decorators
    var graphics:Graphics
    init(){
        graphics = Graphics()
    }
    /**
     *
     */
    func getGrapix()->Grapix{
        return self
    }
}
class RectGrapix:GrapixDecorator{//adds rectangular path
    
}
class RoundRectGrapix{//adds round-rectangular path
    init(){
        
    }
}
class GradientGrapix{//adds Gradient fill
    init(){
        
    }
}