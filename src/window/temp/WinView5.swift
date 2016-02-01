import Cocoa

class WinView5:FlippedView {
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        createContent()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    func createContent(){
        Swift.print("init")
        hitTesting()
    }
    func hitTesting(){
        Swift.print("hitTesting")
        //setup a blue box in a view (100x100) (use the view code from WindowView)
        let viewA:ViewA = ViewA(00,00)
        addSubView(viewA)
    }
}
class ViewA:InteractiveView2{
    init(_ width: CGFloat, _ height: CGFloat) {
        super.init(frame: NSRect(0,0,width,height))//<--This can be a zero rect since the children contains the actual graphics. And when you use Layer-hosted views the subchildren doesnt clip
        self.wantsLayer = true/*if true then view is layer backed*/
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children*/
        layer!.masksToBounds = false//this is needed!!!
        createContent()
    }
    func createContent(){
        Swift.print("ViewA create content")
        let blueBox = RectGraphic(200,200,NSColor.blueColor())
        addSubview(blueBox.graphic)
        blueBox.draw()
        //blueBox.graphic.frame.origin = CGPoint(50,50)
        
        let viewB:ViewB! = ViewB(00,00)
        viewB.frame.origin = CGPoint(50,50)/**/
        addSubview(viewB)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
class ViewB:InteractiveView2{
    init(_ width: CGFloat, _ height: CGFloat) {
        super.init(frame: NSRect(0,0,width,height))//<--This can be a zero rect since the children contains the actual graphics. And when you use Layer-hosted views the subchildren doesnt clip
        self.wantsLayer = true/*if true then view is layer backed*/
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children*/
        layer!.masksToBounds = false//this is needed!!!
        createContent()
    }
    func createContent(){
        Swift.print("ViewB create content")
        let skin = Skin2(NSRect(0,0,200,200),self)
        addSubview(skin)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
class InteractiveView2:FlippedView{
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true/*if true then view is layer backed*/
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children*/
        layer!.masksToBounds = false//this is needed!!!
    }
    /**
     * NOTE: looping backwards is very important as its the only way to target the front-most views in the stack
     * NOTE: why is this needed? because normal hitTesting doesnt work if the frame size is zero. or if a subView is outside the frame.
     */
    override func hitTest(aPoint: NSPoint) -> NSView? {
        for var i = self.subviews.count-1; i > -1; --i{//<--you could store the count outside the loop for optimization, i dont know if this is imp in swift
            let view = self.subviews[i]
            let hitView = view.hitTest(aPoint)/*if true then a point was found within its hittable area*/
            if(hitView != nil){return hitView}
        }
        return nil/*if no hitView is found return nil, the parent hitTest will then continue its search through its siblings etc*/
    }
    override func mouseMoved(theEvent: NSEvent) {
        Swift.print("InteractiveView2.moved() " + "\(self.className)")
    }
    override func mouseDown(theEvent: NSEvent) {
        Swift.print("InteractiveView2.mouseDown() " + "\(self.className)")
        super.mouseDown(theEvent)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}



//Continue here: Create a class that has a graphic and a trackingframe and also gets its parent in the init

class Skin2:FlippedView{//rename to TrackingView?
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    init(_ frameRect:NSRect,_ parent:NSView) {
        super.init(frame: frameRect)
        self.wantsLayer = true/*if true then view is layer backed*/
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children*/
        layer!.masksToBounds = false//this is needed!!!
        let trackingArea:NSTrackingArea = NSTrackingArea(rect: NSRect(0,0,200,200), options: [NSTrackingAreaOptions.ActiveAlways, NSTrackingAreaOptions.MouseMoved,NSTrackingAreaOptions.MouseEnteredAndExited], owner: parent, userInfo: nil)
        addTrackingArea(trackingArea)//<---this will be in the Skin class in the future and the owner will be set to Element to get interactive events etc
        createContent()
    }
    /**
     *
     */
    func createContent(){
        let redBox:RoundRectGraphic = RoundRectGraphic(0,0,200,200,Fillet(50),FillStyle(NSColor.redColor()),LineStyle(5,NSColor.greenColor()),OffsetType(OffsetType.center))
        addSubview(redBox.graphic)
        redBox.draw()
        //redBox.graphic.frame.origin = CGPoint(50,50)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}


//try to change the size of the trackingframe aswell


//continue here: aswell as rollOver rollOut etc




