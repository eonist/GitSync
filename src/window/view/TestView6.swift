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
        //create a container with a mask 200x200
        maskContainer = addSubView(ItemContainer(frame: NSRect(0,0,w,h))) as! ItemContainer
        maskContainer.frame.y = 20
        
        //create a container with 3 rects insider 200x150 per rect
        itemContainer = maskContainer.addSubView(InteractiveView2(frame: NSRect(0,0,w,itemH*3))) as! InteractiveView2
        itemContainer.frame.y = 0
        
        /*Rect*/
        let r1 = RectGraphic(0,0,w,itemH,FillStyle(Colors.green()),nil)//Add a red box to the view
        itemContainer.addSubview(r1.graphic)
        r1.draw()
        
        let r2 = RectGraphic(0,itemH,w,itemH,FillStyle(Colors.yellow()),nil)//Add a red box to the view
        itemContainer.addSubview(r2.graphic)
        r2.draw()
        
        let r3 = RectGraphic(0,itemH*2,w,itemH,FillStyle(Colors.purple()),nil)//Add a red box to the view
        itemContainer.addSubview(r3.graphic)
        r3.draw()
        
        let r4 = RectGraphic(0,itemH*3,w,itemH,FillStyle(Colors.orange()),nil)//Add a red box to the view
        itemContainer.addSubview(r4.graphic)
        r4.draw()
        
        let r5 = RectGraphic(0,itemH*4,w,itemH,FillStyle(Colors.lightBlue()),nil)//Add a red box to the view
        itemContainer.addSubview(r5.graphic)
        r5.draw()
        
        let colors:Array<NSColor> = [Colors.green(),Colors.yellow(),Colors.purple(),Colors.orange(),Colors.lightBlue()]
        for var i = 0; i < colors.count; ++i{
            print(i)
        }
        
        
        throwArea = addSubView(VerticalThrowArea2()) as? VerticalThrowArea2
        throwArea!.frame.y = 20
        
        //add the scrollEvent mover scheme to move the container with the rects
        
        //when y+height of rectContainer is above y+height of the maskContainer then stop moving the rectContainer
            //create checkpoints and print when the checkpoinst are passed
        
        //then apply spring and more friction when the above event happens. 
        
        //if the above works do the same scheme for when rectContainer.y top is bellow top maskContainer.y
        
        //then apply the when dragging bellow and above the limits then apply log10 friction. on release apply normal conditions, spring and friction
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
