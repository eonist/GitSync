import Foundation
//Continue here:
    //test the FastList with rubberband
    //test the FastList with 1000's of items

class TestView:Element {
    var volumeSlider:VolumeSlider?
    var list:FastList?
    var sliderList:SliderList?
    override func resolveSkin() {
        Swift.print("TestView.resolveSkin()")
        skin = SkinResolver.skin(self)
        
        volumeSlider = addSubView(VolumeSlider(220,20,20,0,self))
        volumeSlider!.setProgressValue(0.0)
        
        //createList()
        //createSliderList()
        createRBFastList()
    }
    func createFastList(){
        let xml = FileParser.xml("~/Desktop/assets/xml/scrollist.xml".tildePath)//TODO:  create a method tht takes url and makes dp
        let dp:DataProvider = DataProvider(xml)
        list = addSubView(FastList(140,73,24,dp,self))
    }
    func createSliderFastList(){
        let xml = FileParser.xml("~/Desktop/assets/xml/scrollist.xml".tildePath)//TODO:  create a method tht takes url and makes dp
        let dp:DataProvider = DataProvider(xml)
        //let sliderList:ISliderList = self.addSubView(SliderList(140, 73, 24, dp, self))
        let sliderList:ISliderList = self.addSubView(SliderFastList(140, 73, 24, dp, self))
        sliderList
        /**/
        //ListModifier.select(sliderList, "white")
    }
    /**
     *
     */
    func createRBFastList(){
        let xml = FileParser.xml("~/Desktop/assets/xml/scrollist.xml".tildePath)//TODO:  create a method tht takes url and makes dp
        let dp:DataProvider = DataProvider(xml)
        //let sliderList:ISliderList = self.addSubView(SliderList(140, 73, 24, dp, self))
        let list = self.addSubView(RBSliderList(140, 73, 24, dp, self))
        list
    }
    override func onEvent(event: Event) {
        if(event.assert(SliderEvent.change, volumeSlider)){
            let volumSliderProgress = (event as! SliderEvent).progress
            //Swift.print("volumSliderProgress: " + "\(volumSliderProgress)")
            list?.setProgress(volumSliderProgress)
        }
    }
}
