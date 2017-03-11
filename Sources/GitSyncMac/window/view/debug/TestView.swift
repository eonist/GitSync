import Foundation
@testable import Utils
@testable import Element
//teting fastlist
class TestView:Element {
    var volumeSlider:VolumeSlider?
    var list: DEPRECATED_FastList?
    var sliderList: DEPRECATED_SliderList?
    override func resolveSkin() {
        Swift.print("TestView.resolveSkin()")
        skin = SkinResolver.skin(self)
        
        //volumeSlider = addSubView(VolumeSlider(220,20,20,0,self))
        //volumeSlider!.setProgressValue(0.0)
        
        //createList()
        //createSliderList()
        //createRBSliderList()
        createRBSliderFastList()
    }
    func createFastList(){
        let dp:DataProvider = DataProvider("~/Desktop/assets/xml/scrollist.xml".tildePath)
        list = addSubView(DEPRECATED_FastList(140,73,24,dp,self))
    }
    func createSliderFastList(){
        let dp = DataProvider("~/Desktop/assets/xml/scrollist.xml".tildePath)
        //let sliderList:ISliderList = self.addSubView(SliderList(140, 73, 24, dp, self))
        let sliderList: DEPRECATED_ISliderList = self.addSubView(SliderFastList(140, 73, 24, dp, self))
        _ = sliderList
        /**/
        //ListModifier.select(sliderList, "white")
    }
    /**
     *
     */
    func createRBSliderList(){
        let xml = FileParser.xml("~/Desktop/assets/xml/scrollist.xml".tildePath)//TODO:  create a method tht takes url and makes dp
        let dp:DataProvider = DataProvider(xml)
        //let sliderList:ISliderList = self.addSubView(SliderList(140, 73, 24, dp, self))
        let list = self.addSubView(DEPRECATED_RBSliderList(140, 73, 24, dp, self))
        _ = list
    }
    /**
     *
     */
    func createRBSliderFastList(){
        let xml = FileParser.xml("~/Desktop/assets/xml/longlist.xml".tildePath)//TODO:  create a method tht takes url and makes dp
        let dp:DataProvider = DataProvider(xml)
        //let sliderList:ISliderList = self.addSubView(SliderList(140, 73, 24, dp, self))
        let list = self.addSubView(DEPRECATED_RBSliderFastList(140, 145, 24, dp, self))
        _ = list
    }
    /**
     *
     */
    override func onEvent(_ event:Event) {
        if(event.assert(SliderEvent.change, volumeSlider)){
            let volumSliderProgress = (event as! SliderEvent).progress
            //Swift.print("volumSliderProgress: " + "\(volumSliderProgress)")
            list?.setProgress(volumSliderProgress)
        }
    }
}
