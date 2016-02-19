import Cocoa

class ScrollContainer :Container{
    override func resolveSkin() {
        //super.resolveSkin()
        self.skin = SkinResolver.skin(self)
        self.addSubview(self.skin as! NSView)
        let vSlider = self.addSubView(VSlider(24,120,30,0,self)) as! VSlider
        
        func onEvent(event:Event){
            if(event.type == SliderEvent.change && event.origin === vSlider){Swift.print("\(self.dynamicType)" + ".onEvent() progress: " + "\((event as! SliderEvent).progress)")}
        }
        
        vSlider.event = onEvent
        
    }
    
    override func scrollWheel(theEvent: NSEvent) {
        Swift.print("theEvent: " + "\(theEvent)")
        super.scrollWheel(theEvent)
    }
    override func getClassType() -> String {
        return String(Container)
    }
}
