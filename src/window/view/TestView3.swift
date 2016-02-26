import Cocoa

class TestView3:CustomView {
    private var displayLink: CVDisplayLink!
    override func resolveSkin() {
        super.resolveSkin()
        frameAnimTest()
    }
    func frameAnimTest(){
        //displayLink = DisplayLinkUtils.setUpDisplayLink()
    }
}
