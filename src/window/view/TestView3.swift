import Cocoa

class TestView3:AnimatableView {
    static var w:CGFloat = 400
    static var h:CGFloat = 600
    var w:CGFloat = TestView3.w
    var h:CGFloat = TestView3.h
    var items:[Dictionary<String,AnyObject>] = []
    var throwArea:VerticalThrowArea?
    override func resolveSkin() {
        super.resolveSkin()
        animTest()
    }
    func animTest(){
        
        let itemContainer = addSubView(ItemContainer(frame: NSRect(0,0,w,h))) as! ItemContainer
        itemContainer.frame.y = 20
        
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
  
        throwArea = addSubView(VerticalThrowArea()) as? VerticalThrowArea
        throwArea!.frame.y = 20

        
    }
    /**
     * loop movment code
     */
    func moveViews(value:CGFloat){
        for(var i:Int = 0;i < items.count;i++){
            let spacing:CGFloat = h
            let totalHeight:CGFloat = CGFloat(items.count) * spacing;//move this outside of the method
            let currentPos:CGFloat = CGFloat(value);
            if((items[i]["view"] as! NSView).frame.y > totalHeight-spacing){
                let leftOver:CGFloat = (currentPos - (items[i]["tempPos"] as! CGFloat) + spacing - (totalHeight - (items[i]["pos"] as! CGFloat)))
                //trace("over right border btn id: "+i+" leftover"+leftOver);
                items[i]["tempPos"] = currentPos + (items[i]["pos"] as! CGFloat) + spacing - leftOver;
                //trace("over btn id: "+i+" percentage: "+percentage+" tempPos "+_btnList[i].tempPos)
            };
            if((items[i]["view"] as! NSView).frame.y < ((-1 * totalHeight) + spacing)){
                //trace("over left border btn id: "+i+" POSITIONS: "+" currentPos: "+currentPos+" tempPos: "+_btnList[i].tempPos)
                let leftOver2:CGFloat = (currentPos-(items[i]["tempPos"] as! CGFloat)-spacing-(-1*totalHeight-(items[i]["pos"] as! CGFloat)));
                //trace("over left border btn id: "+i+" leftover"+leftOver2);
                items[i]["tempPos"] = currentPos + (items[i]["pos"] as! CGFloat) - spacing - leftOver2;
                //trace("over btn id: "+i+" percentage: "+percentage+" currentPos: "+currentPos+" tempPos "+_btnList[i].tempPos)
            }
            (items[i]["view"] as! NSView).frame.y = round((currentPos - (items[i]["tempPos"] as! CGFloat)) + (items[i]["pos"] as! CGFloat));
        }
    }
    override func mouseDragged(theEvent: NSEvent) {//we dont need to forward the dragEvent futher
        Swift.print("TestView3.mouseDragged()")
        moveViews(throwArea!.mover!.value)
    }
    override func scrollWheel(theEvent: NSEvent) {
        if(theEvent.phase == NSEventPhase.Changed){moveViews(throwArea!.mover!.value)}
    }
    override func onFrame(){
        //Swift.print("onFrame() value: " + "\(throwArea!.mover!.value)")
        if(throwArea!.mover!.hasStopped){CVDisplayLinkStop(displayLink)}//stop the frameTicker here
        throwArea!.mover!.updatePosition()
        moveViews(throwArea!.mover!.value)
        super.onFrame()
    }
}

class ItemContainer:InteractiveView2{
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        layer!.masksToBounds = true/*masks the children to the frame*/
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}