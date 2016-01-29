import Cocoa

class WinView5:FlippedView {
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        createContent()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    func createContent(){
        hitTest()
    }
    /**
     *
     */
    func hitTest(){
        //setup a blue box in a view (100x100) (use the view code from WindowView)
        
        //add a redbox in a view inside the blue view (100x100)
        
        //offset the redbox view a bit so that the entire bounds of the hirarchy becomes 150
        
        //then test what the bound is on view 1
    }
}
