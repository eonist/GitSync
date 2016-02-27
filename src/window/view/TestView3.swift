import Cocoa

class TestView3:AnimatableView {
    
    override func resolveSkin() {
        super.resolveSkin()
        animTest()
    }
    func animTest(){
        let throwArea = addSubView(VerticalThrowArea())
        throwArea.frame.y = 40
        
        //create 3 color rectangles
        
        //add these rectangles to a container that clips
        
        //write the a simple move code and hook up the DisplayLink
        
        //write the loop movment code
    }
}