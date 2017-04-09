import Cocoa
@testable import Utils
@testable import Element
/**
 * Slidable is for Elements that has a slider attached
 */
protocol Slidable3:Progressable3 {
    func updateSlider()
    func slider(_ dir:Dir) -> Slider/*?*/
    //func sliderInterval(_ dir:Dir)->CGFloat/*?{get set}*///I think this is the same as intervall, remove
}
/**
 * ⚠️️ IMPORTANT: Slidable does not override scroll because a SlideView can't detect scroll. SlideScrollView however can access scroll and call hide and show slider. And then use protocol ambiguity to call scroll on the Scrollable after
 */
extension Slidable3 {
    func setProgress(_ point:CGPoint){
        slider(.hor).setProgressValue(point.x)
        slider(.ver).setProgressValue(point.y)
    }
    func setProgress(_ progress:CGFloat, _ dir:Dir) {
        slider(dir).setProgressValue(progress)
    }
    /**
     * Updates the slider interval and the sliderThumbSize (after DP events: add/remove etc)
     */
    func updateSlider(){
        /*
        sliderInterval = floor(self.itemsHeight - height)/itemHeight
        let thumbHeight:CGFloat = SliderParser.thumbSize(height/itemsHeight, slider!.height/*<--this should probably be .getHeight()*/);
        slider!.setThumbHeightValue(thumbHeight)
        let progress:CGFloat = SliderParser.progress(lableContainer!.y, height, itemsHeight)//TODO: use getHeight() instead of height
        slider!.setProgressValue(progress)
        */
    }
    func hideSlider(){
        Swift.print("🏂 hide slider")
        //self.slider!.thumb!.setSkinState("inActive")
        //if(slider?.thumb?.getSkinState() == SkinStates.none){slider?.thumb?.fadeOut()}/*only fade out if the state is none, aka not over*/
        //slider?.thumb?.fadeOut()
    }
    func showSlider(){
        Swift.print("🏂 show slider")
        //self.slider!.thumb!.setSkinState(SkinStates.none)
        //slider!.thumb!.fadeIn()
    }
}
