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
        testRBList()
    }
    /**
     *
     */
    func testRBList(){
        StyleManager.addStylesByURL("~/Desktop/css/list.css")
        
        let dp = DataProvider(FileParser.xml("~/Desktop/test.xml"))
        
        let section = self.addSubView(Section(200, 200, self, "listSection")) as! Section/*this instance represents the inset shadow bagground and also holds the buttons*/
        let list = section.addSubView(RBSliderList(140,120,24,dp,section)) as! RBSliderList
        list
        scrollController = RBScrollController(self,CGRect(0,0,w,h),CGRect(0,0,w,itemH*colors.count))
    }
    /**
     * loop movment code
     */
    func moveViews(value:CGFloat){
        itemContainer.frame.y = value
    }
    override func scrollWheel(theEvent:NSEvent) {
        scrollController?.scrollWheel(theEvent)//forward the event
        if(theEvent.phase == NSEventPhase.Changed){moveViews(scrollController!.mover.result)}
    }
    override func onFrame(){
        if(scrollController!.mover.hasStopped){//stop the frameTicker here
            CVDisplayLinkStop(displayLink)
        }else{//only move the view if the mover is not stopped
            scrollController!.mover.updatePosition()
            moveViews(scrollController!.mover.result)
        }
        super.onFrame()
    }
}
