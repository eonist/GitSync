import Foundation
@testable import Utils
@testable import Element
//teting fastlist
/**
 * Sort of deperecated.
 */
class TestView2:Element {
    var volumeSlider:VolumeSlider?
    var list: DEPRECATED_FastList?
    var sliderList: DEPRECATED_SliderList?
    override func resolveSkin() {
        Swift.print("TestView.resolveSkin()")
        skin = SkinResolver.skin(self)
        
        //volumeSlider = addSubView(VolumeSlider(220,20,20,0,self))
        //volumeSlider!.setProgressValue(0.0)
        
        
    }
    
}
/**
 * TestView when making the progressIndicator
 */
class TestView3:Element{
    var volumeSlider:VolumeSlider?
    var startButton:TextButton?
    var stopButton:TextButton?
    var progressIndicator:ProgressIndicator?
    override func resolveSkin() {
        Swift.print("DebugView.resolveSkin()")
        skin = SkinResolver.skin(self)
        
        //add ProgressIndicator
        progressIndicator = addSubView(ProgressIndicator(30,30,self))
        //add a progressSlider (volumeControl)
        
        volumeSlider = addSubView(VolumeSlider(120,20,20,0,self))
        volumeSlider!.setProgressValue(0.0)
        
        //add a start button (TexteButton)
        startButton = addSubView(TextButton(100,24,"start",self))
        //add a stop button (TexteButton)
        stopButton = addSubView(TextButton(100,24,"stop",self))
    }
    override func onEvent(_ event:Event) {
        if(event.assert(SliderEvent.change, volumeSlider)){
            let volumSliderProgress = (event as! SliderEvent).progress
            Swift.print("volumSliderProgress: " + "\(volumSliderProgress)")
            progressIndicator!.progress(volumSliderProgress)
        }else if(event.assert(ButtonEvent.upInside, startButton)){
            Swift.print("start")
            progressIndicator!.start()
        }else if(event.assert(ButtonEvent.upInside, stopButton)){
            Swift.print("stop")
            progressIndicator!.stop()
        }
    }
}
