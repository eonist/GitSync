import Cocoa
/**
 * TODO: Setup the test class
 * TODO: setup a new list class
 * TODO: add the new list class here
 * TODO: test rubberband scrolling on list
 * TODO: move the AnimatableView class before or after interactive view, i guess bfore because we may have animatable views that are not interactive in the future
 * TODO: account for when the content is smaller than the crop
 * TODO: fix the styling of the list so that it fits inside the mask, use debug colors etc to figure out the bug
 */
class TestView7:CustomView {
    override func resolveSkin() {
        super.resolveSkin()
        //testThumbButton()
        testRBList()
    }
    /**
     *
     */
    func testThumbButton(){
        StyleManager.addStyle("Button{fill:blue;float:left;clear:left;}")
        let thumb = Thumb(50,140,self)
        addSubview(thumb)
        //thumb.applyOvershot(-0.25)
        //thumb.applyOvershot(1.25)
    }
    /**
     *
     */
    func testRBList(){
        StyleManager.addStylesByURL("~/Desktop/css/list.css")
        StyleManager.addStylesByURL("~/Desktop/css/slider.css")
        StyleManager.addStylesByURL("~/Desktop/css/sliderList.css")
        
        let dp = DataProvider(FileParser.xml("~/Desktop/scrollist.xml"))
        let section = self.addSubView(Section(200, 200, self, "listSection")) as! Section/*this instance represents the inset shadow bagground and also holds the buttons*/
        let list = section.addSubView(RBSliderList(140,120,24,dp,section)) as! RBSliderList
        list
    }
}