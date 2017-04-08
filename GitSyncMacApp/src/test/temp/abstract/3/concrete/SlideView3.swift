import Cocoa
@testable import Utils

class SlideView3:ContainerView3, Slidable3 {
    var slider
    var horSlider:Slider?
    var verSlider:Slider?
    override func resolveSkin() {
        super.resolveSkin()
        /*slider*/
        //intervalX = floor(contentSize.height - maskSize.height)/itemHeight// :TODO: use ScrollBarUtils.interval instead?// :TODO: explain what this is in a comment
        slider = addSubView(Slider(/*itemHeight,height,0,0,self*/))
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/itemsHeight, slider!.height)
        slider!.setThumbHeightValue(thumbHeight)
        slider!.thumb!.fadeOut()//inits fade out anim on init
    }
    override func onEvent(_ event:Event) {
        //Swift.print("event: " + "\(event)")
        if(event === (SliderEvent.change,slider!)){
            setProgress((event as! SliderEvent).progress)
        }/*events from the slider*/
        super.onEvent(event)
    }
}
