import Cocoa

class ScrollContainer :Container{
    var vSlider:VSlider?
    let sliderInterval:CGFloat = 1
    override func resolveSkin() {
        //super.resolveSkin()
        self.skin = SkinResolver.skin(self)
        self.addSubview(self.skin as! NSView)
        vSlider = self.addSubView(VSlider(24,120,30,0,self)) as? VSlider
        
        func onEvent(event:Event){
            if(event.type == SliderEvent.change && event.origin === vSlider){Swift.print("\(self.dynamicType)" + ".onEvent() progress: " + "\((event as! SliderEvent).progress)")}
        }
        
        vSlider!.event = onEvent
        
    }
    
    override func scrollWheel(theEvent: NSEvent) {
        Swift.print("theEvent: " + "\(theEvent)")
        
        
        
        let scrollAmount:CGFloat = (theEvent.deltaY/100)/sliderInterval/*_scrollBar.interval*/;
        var currentScroll:CGFloat = vSlider!.progress - scrollAmount;/*the minus sign makes sure the scroll works like in OSX LION*/
        currentScroll = NumberParser.minMax(currentScroll, 0, 1);
        //ListModifier.scrollTo(self,currentScroll); /*Sets the target item to correct y, according to the current scrollBar progress*/
        vSlider?.setProgressValue(currentScroll)
        
        
        super.scrollWheel(theEvent)
    }
    override func getClassType() -> String {
        return String(Container)
    }
}
