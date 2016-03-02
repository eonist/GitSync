import Cocoa

class TestView6:AnimatableView {
    var w:CGFloat = 200
    var h:CGFloat = 200
    var itemH:CGFloat = 150;
    let target:CGPoint = CGPoint(100,60)
    var circ:EllipseGraphic!
    var throwArea:VerticalThrowArea2?
    var maskContainer:ItemContainer!
    var itemContainer:InteractiveView2!
    
    override func resolveSkin() {
        super.resolveSkin()
        listAnimTest()
    }
    func listAnimTest(){
        maskContainer = addSubView(ItemContainer(frame: NSRect(0,0,w,h))) as! ItemContainer//create a container with a mask 200x200
        maskContainer.frame.y = 20

        itemContainer = maskContainer.addSubView(InteractiveView2(frame: NSRect(0,0,w,itemH*3))) as! InteractiveView2//create a container with 3 rects insider 200x150 per rect
        
        let colors:Array<NSColor> = [Colors.green(),Colors.yellow(),Colors.purple(),Colors.orange(),Colors.lightBlue()]
        for var i = 0; i < colors.count; ++i{/*Rect*/
            let r1 = RectGraphic(0,itemH*i,w,itemH,FillStyle(colors[i]),nil)//Add a red box to the view
            itemContainer.addSubview(r1.graphic)
            r1.draw()
        }
        throwArea = addSubView(VerticalThrowArea2()) as? VerticalThrowArea2
        throwArea!.frame.y = 20
    }
    /**
     * loop movment code
     */
    func moveViews(value:CGFloat){
        //Swift.print("moveViews() value: " + "\(value)")
        itemContainer.frame.y = value
    }
    override func scrollWheel(theEvent: NSEvent) {
        if(theEvent.phase == NSEventPhase.Changed){moveViews(throwArea!.mover!.result)}
    }
    override func onFrame(){
        //Swift.print("onFrame() value: " + "\(throwArea!.mover!.value)")
        if(throwArea!.mover!.hasStopped){//stop the frameTicker here
            CVDisplayLinkStop(displayLink)
        }else{//only move the view if the mover is not stopped
            throwArea!.mover!.updatePosition()
            moveViews(throwArea!.mover!.result)
        }
        super.onFrame()
    }
}
