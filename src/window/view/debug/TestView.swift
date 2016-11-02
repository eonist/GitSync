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
        
        let xml = FileParser.xml("~/Desktop/assets/xml/scrollist.xml".tildePath)//TODO:  create a method tht takes url and makes dp
        let dp:DataProvider = DataProvider(xml)
        list = addSubView(FastList(150,73,24,dp,self))
        
        /*let xml = FileParser.xml("~/Desktop/assets/xml/scrollist.xml".tildePath)//TODO:  create a method tht takes url and makes dp
        let dp:DataProvider = DataProvider(xml)
        let sliderList:SliderList = self.addSubView(SliderList(140, 73, 24, dp, self))
        ListModifier.select(sliderList, "white")*/
    }
    override func onEvent(event: Event) {
        if(event.assert(SliderEvent.change, volumeSlider)){
            let volumSliderProgress = (event as! SliderEvent).progress
            //Swift.print("volumSliderProgress: " + "\(volumSliderProgress)")
            list?.setProgress(volumSliderProgress)
        }
    }
}
