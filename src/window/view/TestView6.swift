import Cocoa

class TestView6:CustomView {
    var w:CGFloat = 200
    var h:CGFloat = 200
    var itemH:CGFloat = 150;


    var scrollController:RBScrollController?
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
        
        let colors:Array<NSColor> = [Colors.green(),Colors.yellow(),Colors.purple(),Colors.orange(),Colors.lightBlue(),Colors.pink(),Colors.lightGray(),Colors.darkBlue(),Colors.orange()]
        for var i = 0; i < colors.count; ++i{/*Rect*/
            let r1 = RectGraphic(0,itemH*i,w,itemH,FillStyle(colors[i]),nil)//Add a red box to the view
            itemContainer.addSubview(r1.graphic)
            r1.draw()
        }
        scrollController = RBScrollController(self,CGRect(0,0,w,h),CGRect(0,0,w,itemH*colors.count))
    }
    /**
     * loop movment code
     */
    func moveViews(value:CGFloat){
        itemContainer.frame.y = value
    }
    override func scrollWheel(theEvent:NSEvent) {
        scrollController?.scrollWheel(theEvent)//forward the event
        if(theEvent.phase == NSEventPhase.Changed){moveViews(scrollController!.mover.result)}
    }
    override func onFrame(){
        if(scrollController!.mover.hasStopped){//stop the frameTicker here
            CVDisplayLinkStop(displayLink)
        }else{//only move the view if the mover is not stopped
            scrollController!.mover.updatePosition()
            moveViews(scrollController!.mover.result)
        }
        super.onFrame()
    }
}
