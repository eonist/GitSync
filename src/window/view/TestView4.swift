import Cocoa

class TestView4:AnimatableView {
    var w:CGFloat = 200
    var h:CGFloat = 200
    var rect:RectGraphic?
    var y:CGFloat = 0
    var onMouseDownPos:CGPoint = CGPoint()
    override func resolveSkin() {
        super.resolveSkin()
        overShotTest()
    }
    func overShotTest(){
        //create a a container with a mask 200x200
        let itemContainer = addSubView(ItemContainer(frame: NSRect(0,0,w,h))) as! ItemContainer
        itemContainer.frame.y = 20
        
        
        //add a rectangle inside 200x200
        rect = RectGraphic(0,0,w,h,FillStyle(Colors.green()),nil)
        itemContainer.addSubview(rect!.graphic)
        rect!.draw()
        
        //onscrolwheel direct manipulation 
        
        //start to apply log10 on the y and dist to top.y
        
        //try your example with the mouse aswell
        
        //on mouse down -> record the position
        
        //on mouse move -> dif the cur pos with the onDownPos to get the current offset
        
    }
    override func mouseDown(event: MouseEvent) {
        onMouseDownPos = localPos() - rect!.graphic.frame.origin
        
        
    }
  
    override func mouseDragged(theEvent: NSEvent) {
        let offset = localPos() - onMouseDownPos
        Swift.print("offset: " + "\(offset)")
        moveRect(offset.y)
    }
    override func scrollWheel(theEvent: NSEvent) {
        
        if(theEvent.phase == NSEventPhase.Changed){//fires everytime there is direct scrollWheel gesture movment.
            y += theEvent.scrollingDeltaY
            moveRect(y)
            
        }
        
    }
    func moveRect(y:CGFloat){
        
        Swift.print("y: " + "\(y)")
        let offsetY = logConstraintValueForYPoisition(y,200)
        Swift.print("offsetY: " + "\(offsetY)")
        rect!.graphic.frame.y = offsetY
    }
    /**
     * NOTE: the vertical limit is the point where the value almost doesnt move at all.
     */
    func logConstraintValueForYPoisition(yPosition : CGFloat, _ verticalLimit:CGFloat) -> CGFloat {
        return verticalLimit * (log10(1.0 + yPosition/verticalLimit))
    }
}
