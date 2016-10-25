import Foundation

class DebugView:Element{
    var volumeSlider:VolumeSlider?
    var startButton:TextButton?
    var stopButton:TextButton?
    override func resolveSkin() {
        Swift.print("DebugView.resolveSkin()")
        skin = SkinResolver.skin(self)
        
        //add ProgressIndicator
        //add a progressSlider (volumeControl)
        volumeSlider = addSubView(VolumeSlider(120,20,20,0,self))
        volumeSlider!.setProgressValue(0.5)
        //add a start button (TexteButton)
        startButton = addSubView(TextButton(100,24,"start",self))
        //add a stop button (TexteButton)
        stopButton = addSubView(TextButton(100,24,"stop",self))
        
    }
    override func onEvent(event: Event) {
        if(event.assert(SliderEvent.change, volumeSlider)){
            let volumSliderProgress = (event as! SliderEvent).progress
            Swift.print("volumSliderProgress: " + "\(volumSliderProgress)")
        }
    }
}