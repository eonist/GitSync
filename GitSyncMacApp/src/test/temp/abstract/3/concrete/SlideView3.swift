import Cocoa
@testable import Utils
@testable import Element

class SlideView3:ContainerView3, Slidable3 {
    var horSlider:Slider?
    var verSlider:Slider?
    func slider(_ dir:Dir) -> Slider { return dir == .ver ? verSlider! : horSlider!}/*Convenience*/
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
