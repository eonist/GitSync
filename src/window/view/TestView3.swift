import Cocoa

class TestView3:AnimatableView {
    var w:CGFloat = 200
    var h:CGFloat = 200
    var items:[Dictionary<String,AnyObject>] = []
    override func resolveSkin() {
        super.resolveSkin()
        animTest()
    }
    func animTest(){
        
        let itemContainer = ItemContainer(frame: NSRect(0,0,w,h))
        itemContainer.frame.y = 20
        
        //create 3 color rectangles
        
        /*Rect*/
        let r1 = RectGraphic(0,0,w,h,FillStyle(NSColor.redColor()),nil)//Add a red box to the view
        itemContainer.addSubview(r1.graphic)
        r1.draw()
        
        let r2 = RectGraphic(0,0,w,h,FillStyle(NSColor.blueColor()),nil)//Add a red box to the view
        itemContainer.addSubview(r2.graphic)
        r2.draw()
        
        let r3 = RectGraphic(0,0,w,h,FillStyle(NSColor.greenColor()),nil)//Add a red box to the view
        itemContainer.addSubview(r3.graphic)
        r3.draw()
        
        
        let views:Array<NSView> = [r1.graphic,r2.graphic,r3.graphic]
        
        for(var i:Int = 0;i < views.count;i++){
            self.items.append(["view":views[i], "pos": h * CGFloat(i), "tempPos":0])
            //imageContainer.addChild(_btnList[i].mc);//add these rectangles to a container that clips
            (self.items[i]["view"] as! NSView).frame.y = self.items[i]["pos"] as! CGFloat/*positions the view*/
        }
        
        
        
        
        
        let throwArea = addSubView(VerticalThrowArea())
        throwArea.frame.y = 40
        
       
        
        //write the a simple move code and hook up the DisplayLink
        
        //write the loop movment code
    }
}

private class ItemContainer:InteractiveView2{
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        layer!.masksToBounds = true/*masks the children to the frame*/
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}