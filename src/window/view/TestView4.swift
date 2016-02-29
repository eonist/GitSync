import Cocoa

class TestView4:AnimatableView {
    var w:CGFloat = 200
    var h:CGFloat = 200
    var rect:RectGraphic?
    var y:CGFloat = 0
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
        
        
    }
    override func scrollWheel(theEvent: NSEvent) {
       
            if(theEvent.phase == NSEventPhase.Changed){//fires everytime there is direct scrollWheel gesture movment.
                y += theEvent.scrollingDeltaY
                Swift.print("y: " + "\(y)")
                let offsetY = logConstraintValueForYPoisition(y)
                Swift.print("offsetY: " + "\(offsetY)")
                //rect!.graphic.frame.y = offsetY
            }
        
    }
    func logConstraintValueForYPoisition(yPosition : CGFloat) -> CGFloat {
        return  (log10(yPosition))
    }
}
