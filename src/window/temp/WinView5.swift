import Cocoa

class WinView5:FlippedView {
    var viewA:NSView!
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        createContent()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    func createContent(){
        hitTest()
    }
    /**
     *
     */
    func hitTest(){
        Swift.print("hitTest")
        //setup a blue box in a view (100x100) (use the view code from WindowView)
        viewA = addSubView(ViewA(100,100))
        
        //add a redbox in a view inside the blue view (100x100)
        
        //offset the redbox view a bit so that the entire bounds of the hirarchy becomes 150
        
        //then test what the bound is on view 1
    }
    override func updateTrackingAreas() {
        Swift.print("viewA.bounds: " + "\(viewA.bounds)")
        
    }
    
}
private class ViewA:FlippedView{
    init(_ width: CGFloat, _ height: CGFloat) {
        super.init(frame: NSRect(0,0,width,height))//<--This can be a zero rect since the children contains the actual graphics. And when you use Layer-hosted views the subchildren doesnt clip
        self.wantsLayer = true/*if true then view is layer backed*/
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children*/
        layer!.masksToBounds = false//this is needed!!!
        createContent()
    }
    /**
     *
     */
    func createContent(){
        Swift.print("create content")
        let blueBox = RectGraphic(200,200,NSColor.blueColor())
        addSubview(blueBox.graphic)
        blueBox.draw()
        blueBox.graphic.frame.origin = CGPoint(50,50)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

private class ViewB:FlippedView{
    init(_ width: CGFloat, _ height: CGFloat) {
        super.init(frame: NSRect(0,0,width,height))//<--This can be a zero rect since the children contains the actual graphics. And when you use Layer-hosted views the subchildren doesnt clip
        self.wantsLayer = true/*if true then view is layer backed*/
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children*/
        layer!.masksToBounds = false//this is needed!!!
        createContent()
    }
    /**
     *
     */
    func createContent(){
        Swift.print("create content")
        let redBox = RectGraphic(200,200,NSColor.redColor())
        addSubview(redBox.graphic)
        redBox.draw()
        //redBox.graphic.frame.origin = CGPoint(50,50)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}