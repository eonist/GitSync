import Cocoa

class TestView3:AnimatableView {
    
    override func resolveSkin() {
        super.resolveSkin()
        animTest()
    }
    func animTest(){
        let throwArea = VerticalThrowArea()
    }
}
