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
        //let tempEvent = CustomEvent(event)//event//
        //let newCGEvent = event.CGEvent
        //Swift.print("newCGEvent: " + "\(newCGEvent)")
        //let newNSEvent = NSEvent(CGEvent: newCGEvent!)
        //Swift.print("newNSEvent: " + "\(newNSEvent)")
        
        
        
        
        
        
        let mouseEvent = NSEvent.mouseEventWithType(event.type, location: event.locationInWindow, modifierFlags: <#T##NSEventModifierFlags#>, timestamp: <#T##NSTimeInterval#>, windowNumber: <#T##Int#>, context: <#T##NSGraphicsContext?#>, eventNumber: <#T##Int#>, clickCount: <#T##Int#>, pressure: <#T##Float#>)
        //int mask = 0x100;
        //let mouseEvent = NSEvent(CGEvent: event.CGEvent!)//(mouseEventWithType:NSLeftMouseDown)
        
        
        
        super.mouseEntered(mouseEvent!)
    }
    override func mouseExited(event: NSEvent) {
        Swift.print("ViewB.mouseExited()")
        super.mouseExited(event)
    }
    override func mouseOver() {
        //Swift.print("ViewB.mouseOver() ")
        super.mouseOver()
    }
    override func mouseOut() {
        //Swift.print("ViewB.mouseOut() ")
        super.mouseOut()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
//Continue here: how do you work with unsafe pointer , see that gradient class or fuzzy search
//Search through your notes for NSEvent and MouseEnter etc.



class CustomEvent:NSEvent{
    init(_ event:NSEvent, userData:String){
        //let cgEvent = event.CGEvent!
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}