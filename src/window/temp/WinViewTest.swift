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
        var grapix = Grapix()
        
    }
}
protocol IGrapixDecorator{
    
}
class GrapixDecorator{
    
}
class Grapix:IGrapixDecorator{//base class for decorators
    var graphics:Graphics
    init(){
        graphics = Graphics()
    }
}
class RectGrapix{//adds rectangular path
    init(){
        
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