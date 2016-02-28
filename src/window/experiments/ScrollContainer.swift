import Cocoa

class ScrollContainer :Container{
    var vSlider:VSlider?
    let sliderInterval:CGFloat = 1
    override func resolveSkin() {
        //super.resolveSkin()
        self.skin = SkinResolver.skin(self)
        self.addSubview(self.skin as! NSView)
        vSlider = self.addSubView(VSlider(24,height,30,0,self)) as? VSlider
        
        func onEvent(event:Event){
            if(event.type == SliderEvent.change && event.origin === vSlider){Swift.print("\(self.dynamicType)" + ".onEvent() progress: " + "\((event as! SliderEvent).progress)")}
        }
        
        vSlider!.event = onEvent
        
    }
    
    override func scrollWheel(theEvent: NSEvent) {
        //Swift.print("theEvent: " + "\(theEvent)")
        
        if(theEvent.phase == NSEventPhase.Changed){//fires everytime there is scrollWheel gesture movment
            
        }else if(theEvent.phase == NSEventPhase.MayBegin){//can be used to detect if two fingers are touching the trackpad
            
        }else if(theEvent.phase == NSEventPhase.Began){//can be used to detect when the scroll began.
            
        }else if(theEvent.phase == NSEventPhase.None){//if you release your touch-gesture and the momentum of the gesture has not stopped.
            //calculate the 
            //set the momentum to the Mover instance
            //start the CVDisplayLink
            //
        }else if(theEvent.phase == NSEventPhase.Ended){//if you release your touch-gesture and the momentum of the gesture has stopped.
            //dont start the CVDisplayLink, since your momentum has stopped
            //
        }
        
        
        let scrollAmount:CGFloat = (theEvent.deltaY/100)/sliderInterval/*_scrollBar.interval*/;
        var currentScroll:CGFloat = vSlider!.progress - scrollAmount;/*the minus sign makes sure the scroll works like in OSX LION*/
        currentScroll = NumberParser.minMax(currentScroll, 0, 1);//clips the scalar value
        //ListModifier.scrollTo(self,currentScroll); /*Sets the target item to correct y, according to the current scrollBar progress*/
        vSlider?.setProgressValue(currentScroll)
        
        
        super.scrollWheel(theEvent)
    }
    
    override func getClassType() -> String {
        return String(Container)
    }
}
