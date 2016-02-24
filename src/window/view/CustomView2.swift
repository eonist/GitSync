import Cocoa

class CustomView2:WindowView{
    var section:Section?
    var closeButton:Button?
    var minimizeButton:Button?
    var maximizeButton:Button?
    /**
     * Add content here
     */
    override func resolveSkin() {
        super.resolveSkin()
         //createTitleBar()
    }
}
