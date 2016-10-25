import Foundation

class DebugView:Element{
    override func resolveSkin() {
        Swift.print("DebugView.resolveSkin()")
        super.resolveSkin()
        
        //add ProgressIndicator
        //add a progressSlider (volumeControl)
        //add a start button (TexteButton)
        //add a stop button (TexteButton)
        
    }
}