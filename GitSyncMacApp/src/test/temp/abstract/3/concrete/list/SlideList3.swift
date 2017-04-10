import Cocoa
@testable import Utils
@testable import Element

class SlideList3:List3,Slidable3 {
    var horSlider:Slider?
    var verSlider:Slider?
    override func resolveSkin() {
        super.resolveSkin()
        horSlider = self.addSubView(Slider(width,itemSize.height,.hor,itemSize,0,self))
        verSlider = self.addSubView(Slider(itemSize.width,height,.ver,itemSize,0,self))
        
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/contentSize.height, verSlider!.height)
        verSlider!.setThumbSide(thumbHeight)
        verSlider!.thumb!.fadeOut()//inits fade out anim on init
        
        let thumbWidth:CGFloat = SliderParser.thumbSize(width/itemSize.width, horSlider!.width)
        horSlider!.setThumbSide(thumbWidth)
        horSlider!.thumb!.fadeOut()//inits fade out anim on init
    }
    override func onEvent(_ event:Event) {
        if(event == SliderEvent.change){
            let dir:Dir = event.origin === horSlider ? .hor : .ver
            setProgress((event as! SliderEvent).progress,dir)
        }
        super.onEvent(event)
    }
}
extension SlideList3{
    override open func scrollWheel(with event: NSEvent) {
        Swift.print("SlideView3.scrollWheel() \(event.type)")
        super.scrollWheel(with: event)
        if(event.phase == NSEventPhase.mayBegin || event.phase == NSEventPhase.began){
            showSlider()
        }
        /*else if(event.phase == NSEventPhase.ended || event.phase == NSEventPhase.cancelled){
         //hideSlider()
         }*/
    }
}
