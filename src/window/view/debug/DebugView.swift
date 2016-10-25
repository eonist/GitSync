import Foundation

class DebugView:Element{
    var startButton:TextButton?
    var stopButton:TextButton?
    override func resolveSkin() {
        Swift.print("DebugView.resolveSkin()")
        skin = SkinResolver.skin(self)
        
        //add ProgressIndicator
        //add a progressSlider (volumeControl)
        //add a start button (TexteButton)
        startButton = addSubView(TextButton(100,24,"start",self))
        //add a stop button (TexteButton)
        stopButton = addSubView(TextButton(100,24,"stop",self))
        
    }
}