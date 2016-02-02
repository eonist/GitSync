import Cocoa

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
        let skin = SkinA(NSRect(0,0,200,200),self)
        addSubview(skin)
        
        let viewB:ViewB! = ViewB(00,00)
        viewB.frame.origin = CGPoint(50,50)/**/
        addSubview(viewB)
    }
    override func mouseEntered(event: NSEvent) {
        Swift.print("ViewA.mouseEntered()")
        
        // I just want to listen to enter events that enters the skin, not enter events that enter my children
        Swift.print("event.locationInWindow: " + "\(event.locationInWindow)")
        //let hitView = hitTest(event.locationInWindow)
        //Swift.print("hitView: " + "\(hitView)")
        
        
        super.mouseEntered(event)
    }
    override func hitTest(aPoint: NSPoint) -> NSView? {
        Swift.print("ViewA.hitTest() aPoint: " + "\(aPoint)")
        return super.hitTest(aPoint)
    }
    override func mouseExited(event: NSEvent) {
        Swift.print("ViewA.mouseExited()")
        super.mouseExited(event)
    }
    /*override func mouseOver() {
    //Swift.print("ViewA.mouseOver() ")
    super.mouseOver()
    }
    override func mouseOut() {
    //Swift.print("ViewA.mouseOut() ")
    super.mouseOut()
    }*/
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}


