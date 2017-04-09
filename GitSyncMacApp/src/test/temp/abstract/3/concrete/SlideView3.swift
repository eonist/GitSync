import Cocoa
@testable import Utils
@testable import Element

class SlideView3:ContainerView3, Slidable3 {
    var horSlider:Slider?
    var verSlider:Slider?
    func slider(_ dir: Dir) -> Slider {
        switch dir{
            case .hor: return horSlider!
            case .ver: return verSlider!
        }
    }
    override func resolveSkin() {
        super.resolveSkin()
        /*slider*/
        //intervalX = floor(contentSize.height - maskSize.height)/itemHeight// :TODO: use ScrollBarUtils.interval instead?// :TODO: explain what this is in a comment
        
        verSlider = addSubView(Slider(width,24))
        horSlider = addSubView(Slider(24,height))
        
        /*let thumbHeight:CGFloat = SliderParser.thumbSize(height/itemsHeight, slider!.height)
         slider!.setThumbHeightValue(thumbHeight)
         slider!.thumb!.fadeOut()//inits fade out anim on init*/
    }
    override func onEvent(_ event:Event) {
        //Swift.print("event: " + "\(event)")
        if(event == SliderEvent.change){
            if(event.origin === horSlider){
                setProgress((event as! SliderEvent).progress,.hor)
            }else{
                setProgress((event as! SliderEvent).progress,.ver)
            }
            
        }/*events from the slider*/
        super.onEvent(event)
    }
}
