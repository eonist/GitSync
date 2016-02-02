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
        let tempEvent = event//CustomEvent(event)
        super.mouseEntered(tempEvent)
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
    var event:NSEvent
    override var type:NSEventType {return event.type}
    override var locationInWindow:NSPoint {return event.locationInWindow}
    init(_ event:NSEvent){
        self.event = event
        Swift.print("event.type: " + "\(event.type)")
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}