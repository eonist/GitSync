import Foundation

class TestView:Element {
    var volumeSlider:VolumeSlider?
    var list:FastList?
    var sliderList:SliderList?
    override func resolveSkin() {
        Swift.print("TestView.resolveSkin()")
        skin = SkinResolver.skin(self)
        
        volumeSlider = addSubView(VolumeSlider(220,20,20,0,self))
        volumeSlider!.setProgressValue(0.0)
        
        //list = addSubView(FastList(150,250,self))
        sliderList = SliderList()
    }
    override func onEvent(event: Event) {
        if(event.assert(SliderEvent.change, volumeSlider)){
            let volumSliderProgress = (event as! SliderEvent).progress
            //Swift.print("volumSliderProgress: " + "\(volumSliderProgress)")
            list?.setProgress(volumSliderProgress)
        }
    }
}
