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
        //setup a blue box in a view
        
        //add a redbox in a view inside the blue view
        
        
    }
}