import Foundation
@testable import Utils
@testable import Element

class SlideScrollList3:List3,SlidableScrollable3{
    var horSlider:Slider?
    var verSlider:Slider?
    override func resolveSkin() {
        super.resolveSkin()
        
        
        verSlider = self.addSubView(Slider(itemSize.width,height,.ver,itemSize,0,self))
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/itemSize.height, verSlider!.height)
        verSlider!.setThumbSide(thumbHeight)
        verSlider!.thumb!.fadeOut()
    }
}
