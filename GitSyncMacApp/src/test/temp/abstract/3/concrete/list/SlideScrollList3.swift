import Foundation
@testable import Utils
@testable import Element

class SlideScrollList3:List3,SlidableScrollable3{
    var horSlider:Slider?
    var verSlider:Slider?
    override func resolveSkin() {
        super.resolveSkin()
        horSlider = self.addSubView(Slider(width,itemSize.height,.hor,itemSize,0,self))
        verSlider = self.addSubView(Slider(itemSize.width,height,.ver,itemSize,0,self))
        
        //Continue here:
            //thumbHeight is wrong, see old code replace height/itemsize.height
        
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/itemSize.height, verSlider!.height)
        Swift.print("thumbHeight: " + "\(thumbHeight)")
        Swift.print("contentSize.height: " + "\(contentSize.height)")
        Swift.print("maskSize.height: " + "\(maskSize.height)")
        verSlider!.setThumbSide(thumbHeight)
        
        let thumbWidth:CGFloat = SliderParser.thumbSize(width/itemSize.width, horSlider!.width)
        horSlider!.setThumbSide(thumbWidth)
    }
    override func onEvent(_ event:Event) {
        if(event == SliderEvent.change){
            let dir:Dir = event.origin === horSlider ? .hor : .ver
            setProgress((event as! SliderEvent).progress,dir)
        }
        super.onEvent(event)
    }
}
