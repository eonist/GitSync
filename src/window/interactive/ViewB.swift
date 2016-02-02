import Cocoa

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
        let skin = SkinB(NSRect(0,0,200,200),self)
        addSubview(skin)
    }
    override func mouseEntered(event: NSEvent) {
        Swift.print("ViewB.mouseEntered()")
        
        Swift.print("event.locationInWindow: " + "\(event.locationInWindow)")
        Swift.print("(window?.mouseLocationOutsideOfEventStream)!: " + "\((window?.mouseLocationOutsideOfEventStream)!)")
        // I just want to listen to enter events that enters the skin, not enter events that enter my children
        //Swift.print("event.locationInWindow: " + "\(event.locationInWindow)")
        let mousePos = (window?.mouseLocationOutsideOfEventStream)!
        Swift.print("winMousePos: " + "\(winMousePos)")
        let localPoint:NSPoint = convertPoint(mousePos, fromView: nil)
        Swift.print("localPoint: " + "\(localPoint)")
        
        let globalPoint:NSPoint = convertPoint(mousePos, toView: nil)
        Swift.print("globalPoint: " + "\(globalPoint)")
        
        let hitView = hitTest(winMousePos)
        Swift.print("hitView: " + "\(hitView)")
        
        super.mouseEntered(event)
    }
    override func mouseExited(event: NSEvent) {
        Swift.print("ViewB.mouseExited()")
        super.mouseExited(event)
    }
    /*override func mouseOver() {
    //Swift.print("ViewB.mouseOver() ")
    super.mouseOver()
    }
    override func mouseOut() {
    //Swift.print("ViewB.mouseOut() ")
    super.mouseOut()
    }*/
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}




