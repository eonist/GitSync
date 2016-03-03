import Cocoa
/**
 * TODO: Setup the test class
 * TODO: setup a new list class
 * TODO: add the new list class here
 * TODO: test rubberband scrolling on list
 * TODO: move the AnimatableView class before or after interactive view, i guess bfore because we may have animatable views that are not interactive in the future
 * TODO: account for when the content is smaller than the crop
 */
class TestView7:AnimatableView {
    override func resolveSkin() {
        super.resolveSkin()
        testRBList()
    }
    /**
     *
     */
    func testRBList(){
        StyleManager.addStylesByURL("~/Desktop/css/list.css")
        
        let dp = DataProvider(FileParser.xml("~/Desktop/test.xml"))
        
        let section = self.addSubView(Section(200, 200, self, "listSection")) as! Section/*this instance represents the inset shadow bagground and also holds the buttons*/
        let list = section.addSubView(List(140,120,24,dp,section)) as! List
        list
    }
}
