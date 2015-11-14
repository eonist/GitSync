import Cocoa

class WinViewTest:FlippedView {
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override func drawRect(dirtyRect: NSRect) {
        createContent()
    }
    /**
     *
     */
    func createContent(){
        
    }
}
