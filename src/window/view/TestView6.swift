import Cocoa

class TestView6:AnimatableView {
    var w:CGFloat = 200
    var h:CGFloat = 200
    var itemH:CGFloat = 150;
    let target:CGPoint = CGPoint(100,60)
    var circ:EllipseGraphic!
    override func resolveSkin() {
        super.resolveSkin()
        listAnimTest()
    }
    func listAnimTest(){
        //create a container with a mask 200x200
        let maskContainer = addSubView(ItemContainer(frame: NSRect(0,0,w,h))) as! ItemContainer
        maskContainer.frame.y = 20
        
        //create a container with 3 rects insider 200x150 per rect
        let itemContainer = maskContainer.addSubView(InteractiveView2(frame: NSRect(0,0,w,h))) as! InteractiveView2
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
        
        //add the scrollEvent mover scheme to move the container with the rects
        
        //when y+height of rectContainer is above y+height of the maskContainer then stop moving the rectContainer
        
        //then apply spring and more friction when the above event happens. 
        
        //if the above works do the same scheme for when rectContainer.y top is bellow top maskContainer.y
        
        //then apply the when dragging bellow and above the limits then apply log10 friction. on release apply normal conditions, spring and friction
        
    }
}
