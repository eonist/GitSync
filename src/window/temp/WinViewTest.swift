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
class SkinLayer:NSView{//class RoundRectGrapix{//adds round-rectangular path
    init(){
        
    }
}
    
}
class Grapix{//base class for decorators
    init(){
        
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