import Cocoa

class TestView3:AnimatableView {
    var w:CGFloat = 200
    var h:CGFloat = 200
    var items:[Dictionary<String,AnyObject>] = []
    var throwArea:VerticalThrowArea?
    override func resolveSkin() {
        super.resolveSkin()
        animTest()
    }
    func animTest(){
        
        let itemContainer = addSubView(ItemContainer(frame: NSRect(0,0,w,h))) as! ItemContainer
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
        
        
        /**/
        throwArea = addSubView(VerticalThrowArea()) as? VerticalThrowArea
        throwArea!.frame.y = 20

        
        
        
        //write the a simple move code and hook up the DisplayLink
        
        //write the loop movment code
    }
    func movePictures(value:CGFloat){
        for(var i:Int = 0;i < items.count;i++){
            var spacing:Int = DISPLAY_HEIGHT;
            var totalHeight:Number = (_btnList.length) *spacing;//move this outside of the method
            var currentPos:Number = (aValue);
            if(_btnList[i].mc.y > totalHeight-spacing){
                var leftOver:Number = (currentPos-_btnList[i].tempPos+spacing-(totalHeight-_btnList[i].pos));
                //trace("over right border btn id: "+i+" leftover"+leftOver);
                _btnList[i].tempPos = currentPos+_btnList[i].pos+spacing-leftOver;
                //trace("over btn id: "+i+" percentage: "+percentage+" tempPos "+_btnList[i].tempPos)
            };
            if(_btnList[i].mc.y < ((-1*totalHeight)+spacing)){
                //trace("over left border btn id: "+i+" POSITIONS: "+" currentPos: "+currentPos+" tempPos: "+_btnList[i].tempPos)
                var leftOver2:Number = (currentPos-(_btnList[i].tempPos)-spacing-(-1*totalHeight-_btnList[i].pos));
                //trace("over left border btn id: "+i+" leftover"+leftOver2);
                _btnList[i].tempPos = currentPos+_btnList[i].pos-spacing-leftOver2;
                //trace("over btn id: "+i+" percentage: "+percentage+" currentPos: "+currentPos+" tempPos "+_btnList[i].tempPos)
            }
            _btnList[i].mc.y = Math.round((currentPos - _btnList[i].tempPos)+ _btnList[i].pos);
        }
    }
    
    override func onFrame(){
        Swift.print("onFrame() value: " + "\(throwArea!.mover!.value)")
        throwArea!.mover!.updatePosition()
        
        super.onFrame()
        
    }
}

private class ItemContainer:InteractiveView2{
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        layer!.masksToBounds = true/*masks the children to the frame*/
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}