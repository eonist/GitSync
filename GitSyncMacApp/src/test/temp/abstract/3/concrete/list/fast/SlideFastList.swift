import Cocoa
@testable import Utils
@testable import Element

class SlideFastList:FastList3,Slidable3 {
    lazy var horSlider:Slider? = self.hSlider
    lazy var verSlider:Slider? = self.vSlider
    
}
