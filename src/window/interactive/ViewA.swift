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
    /*override func mouseEntered(event: NSEvent) {
    //Swift.print("ViewA.mouseEntered()")
    super.mouseEntered(event)
    }*/
    /*override func hitTest(aPoint: NSPoint) -> NSView? {
    //Swift.print("ViewA.hitTest() aPoint: " + "\(aPoint)")
    return super.hitTest(aPoint)
    }*/
    /*override func mouseExited(event: NSEvent) {
    //Swift.print("ViewA.mouseExited()")
    super.mouseExited(event)
    }*/
    override func mouseOver(event:MouseEvent) {
        if(event.origin === self){Swift.print("ViewA.mouseOver() origin: " + "\(event.origin)")}
        super.mouseOver(event)
    }
    override func mouseOut(event:MouseEvent) {
        if(event.origin === self){Swift.print("ViewA.mouseOut() origin: " + "\(event.origin)")}
        super.mouseOut(event)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}


