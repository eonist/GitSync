import Foundation
//Continue here:
    //add the dark-mode style to generics.css
    //attempt to add the switch skin functionality in a small isolated test (w/ styles from generic.css, just switching a few parms)
    //center-align the input views
    //create the dialogs in Illustrator
    //create a color pallet for Dark-Mode
    //add the light-mode pallet
    //prepare 3 blog posts about FastList,ProgressIndicator,LineGraph for stylekit
    //add the Date Text UI Element to StatsView
    //write about the mc2/bump idea

class TestView:Element {
    var volumeSlider:VolumeSlider?
    var list:FastList?
    var sliderList:SliderList?
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
    func createRBSliderList(){
        let xml = FileParser.xml("~/Desktop/assets/xml/scrollist.xml".tildePath)//TODO:  create a method tht takes url and makes dp
        let dp:DataProvider = DataProvider(xml)
        //let sliderList:ISliderList = self.addSubView(SliderList(140, 73, 24, dp, self))
        let list = self.addSubView(RBSliderList(140, 73, 24, dp, self))
        list
    }
    /**
     *
     */
    func createRBSliderFastList(){
        let xml = FileParser.xml("~/Desktop/assets/xml/longlist.xml".tildePath)//TODO:  create a method tht takes url and makes dp
        let dp:DataProvider = DataProvider(xml)
        //let sliderList:ISliderList = self.addSubView(SliderList(140, 73, 24, dp, self))
        let list = self.addSubView(RBSliderFastList(140, 145, 24, dp, self))
        list
    }
    /**
     *
     */
    override func onEvent(event:Event) {
        if(event.assert(SliderEvent.change, volumeSlider)){
            let volumSliderProgress = (event as! SliderEvent).progress
            //Swift.print("volumSliderProgress: " + "\(volumSliderProgress)")
            list?.setProgress(volumSliderProgress)
        }
    }
}
