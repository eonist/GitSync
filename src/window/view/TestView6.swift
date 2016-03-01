import Cocoa

class TestView6:AnimatableView {
    var w:CGFloat = 200
    var h:CGFloat = 200
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
        let itemContainer = maskContainer.addSubView(InteractiveView2(frame: NSRect(0,0,w,h))) as! ItemContainer
        itemContainer.frame.y = 0
        
        //add a textField here
        /* let textField = TextField(frame: NSRect(x: 0, y: 0, width: w, height: h))
        itemContainer.addSubview(textField)
        textField.stringValue = "hello world"
        */
        //create 3 color rectangles
        
        /*Rect*/
        let r1 = RectGraphic(0,0,w,h,FillStyle(Colors.green()),nil)//Add a red box to the view
        itemContainer.addSubview(r1.graphic)
        r1.draw()
        
        let r2 = RectGraphic(0,0,w,h,FillStyle(Colors.yellow()),nil)//Add a red box to the view
        itemContainer.addSubview(r2.graphic)
        r2.draw()
        
        let r3 = RectGraphic(0,0,w,h,FillStyle(Colors.purple()),nil)//Add a red box to the view
        itemContainer.addSubview(r3.graphic)
        r3.draw()
        
        let views:Array<NSView> = [/*textField,*/ r1.graphic,r2.graphic,r3.graphic]
        
        for(var i:Int = 0;i < views.count;i++){
            self.items.append(["view":views[i], "pos": h * CGFloat(i), "tempPos":0])
            //imageContainer.addChild(_btnList[i].mc);//add these rectangles to a container that clips
            (self.items[i]["view"] as! NSView).frame.y = self.items[i]["pos"] as! CGFloat/*positions the view*/
        }
        //add the scrollEvent mover scheme to move the container with the rects
        
        //when y+height of rectContainer is above y+height of the maskContainer then stop moving the rectContainer
        
        //then apply spring and more friction when the above event happens. 
        
        //if the above works do the same scheme for when rectContainer.y top is bellow top maskContainer.y
        
        //then apply the when dragging bellow and above the limits then apply log10 friction. on release apply normal conditions, spring and friction
        
    }
}
