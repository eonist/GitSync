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
        
        
        /*Swift.print("NSEventType.MouseEntered: " + "\(NSEventType.MouseEntered)")
        Swift.print("event.type: " + "\(event.type)")
        Swift.print("event.locationInWindow: " + "\(event.locationInWindow)")
        Swift.print("event.modifierFlags: " + "\(event.modifierFlags)")
        Swift.print("event.timestamp: " + "\(event.timestamp)")
        Swift.print("event.windowNumber: " + "\(event.windowNumber)")
        Swift.print("event.context: " + "\(event.context)")
        Swift.print("event.eventNumber: " + "\(event.eventNumber)")*/
        /*Swift.print("event.clickCount: " + "\(event.clickCount)")
        Swift.print("event.pressure: " + "\(event.pressure)")*/
        //let cgEvent = event.CGEvent
        
        
        //let mouseCGEvent = CGEventCreateMouseEvent(nil, CGEventType.MouseMoved, NSMakePoint(50,50), CGMouseButton.Left)
        //let mouseNSEvent = NSEvent(CGEvent: mouseCGEvent!)//
        //let tempEvent = NSEvent.mouseEventWithType(event.type, location: NSMakePoint(50,50), modifierFlags: NSEventModifierFlags.CommandKeyMask, timestamp: 1, windowNumber: (self.window?.windowNumber)!, context: NSGraphicsContext.currentContext(), eventNumber: 1, clickCount: Int(1), pressure: Float(1.0))
        
        
        //Swift.print("mouseEvent: " + "\(mouseEvent)")
        //int mask = 0x100;
        //let mouseEvent = NSEvent(CGEvent: event.CGEvent!)//(mouseEventWithType:NSLeftMouseDown)
        
        //let customEvent = CustomEvent(event,"")
        
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



class InteractionUtils{
    /**
     * This method finds the immediate origin. Aka the first descendant of current
     */
    func immediate(current:NSView,_ origin:NSView)->NSView{//origin may be a CALayer, test this later
        var view:NSView = origin
        while(view.superview != current) {
            view = view.superview!
        }
        return view;
    }
}




//continue here: keep testing, use the hitTest to get origin. If you want window to know if button was clicked then override mouseDown and assert with: InteractionUtils.isDescendant(btn,origin) this method will 




/**/


/*
class CustomEvent:NSEvent{


override var type:NSEventType{return event.type}
override var locationInWindow: NSPoint { return event.locationInWindow }
override var modifierFlags:NSEventModifierFlags{return event.modifierFlags}
override var timestamp:NSTimeInterval {return event.timestamp}
override var windowNumber:Int{return event.windowNumber}
override var context:NSGraphicsContext? {return event.context}
override var eventNumber:Int {return event.eventNumber}
var event:NSEvent
/*Swift.print("event.clickCount: " + "\(event.clickCount)")
Swift.print("event.pressure: " + "\(event.pressure)")*/
init(_ event:NSEvent, _ userData:String){
//let cgEvent = event.CGEvent!
self.event = event
super.init()
}
required init?(coder aDecoder: NSCoder) {
fatalError("init(coder:) has not been implemented")
}
}
/**/
/**/*/