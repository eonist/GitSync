import Cocoa
@testable import Utils
@testable import Element

class SlideView3:ContainerView3, Slidable3 {
    var horSlider:Slider?
    var verSlider:Slider?
    override func resolveSkin() {
        super.resolveSkin()
        /*slider*/
        horSlider = self.addSubView(Slider(60,6,.hor,CGSize(30,6),0,self))
        verSlider = self.addSubView(Slider(6,60,.ver,CGSize(6,30),0,self))
        
        //let intervalX:CGFloat = floor(contentSize.height - maskSize.height)/24// :TODO: use ScrollBarUtils.interval instead?// :TODO: explain what this is in a comment
        /*ver slider*/
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/contentSize.height, verSlider!.height)
         verSlider!.setThumbSide(thumbHeight)
         //verSlider!.thumb!.fadeOut()//inits fade out anim on init/**/
        
        /*horSlider*/
        /*let thumbWidth:CGFloat = SliderParser.thumbSize(width/contentSize.width, verSlider!.width)
         verSlider!.setThumbSide(thumbWidth)
         verSlider!.thumb!.fadeOut()//inits fade out anim on init*/
    }
    override func onEvent(_ event:Event) {
        if(event == SliderEvent.change){
            let dir:Dir = event.origin === horSlider ? .hor : .ver
            setProgress((event as! SliderEvent).progress,dir)
        }/*events from the slider*/
        super.onEvent(event)
    }
}
