import Cocoa
@testable import Element
@testable import Utils

protocol SlidableScrollable3:Slidable3,Scrollable3 {
    //func onScrollWheelMomentumEnded(_ dir:Dir)
}
extension SlidableScrollable3 {
    /**
     * TODO: you could also override scroll and hock after the forward scroll call and then retrive the progress from the var. less code, but the value must be written in Displaceview, it could mess up Elastic, because it needs different progress. etc, do later
     */
    func onScrollWheelChange(_ event:NSEvent) {
        //Swift.print("🏂📜 SlidableScrollable3.onScrollWheelChange: \(event.type)")
        //Swift.print("event.scrollingDelta: " + "\(event.scrollingDelta)")
        //Swift.print("interval(.hor): " + "\(interval(.hor))")
        /*Swift.print("slider(.hor).progress: " + "\(slider(.hor).progress)")*/
        let horProg:CGFloat = SliderListUtils.progress(event.delta[.hor], interval(.hor), slider(.hor).progress)//TODO: ⚠️️ merge these 2 lines into one and make a method in SliderListUtils that returns point
        let verProg:CGFloat = SliderListUtils.progress(event.delta[.ver], /*5*/interval(.ver), slider(.ver).progress)
        let progress:CGPoint = CGPoint(horProg,verProg)
        //Swift.print("progress: " + "\(progress)")
        (self as Slidable3).setProgress(progress)
        (self as Scrollable3).setProgress(progress)
    }
    func onInDirectScrollWheelChange(_ event: NSEvent) {//enables momentum
        onScrollWheelChange(event)
        /*if(event.scrollingDeltaX == 0){
         onScrollWheelMomentumEnded(.hor)
         }
         if(event.scrollingDeltaY == 0){
         onScrollWheelMomentumEnded(.ver)
         }*/
    }
    func onScrollWheelEnter() {
        showSlider()
    }
    func onScrollWheelCancelled() {
        hideSlider()
    }
    func onScrollWheelExit() {
        Swift.print("onScrollWheelExit()")
        hideSlider()
    }
    func onScrollWheelMomentumBegan() {
        showSlider()//cancels out the hide call when onScrollWheelExit
    }
    /**
     * Called only be called when scrollwheel becomes stationary. find the code that does this.
     */
    func onScrollWheelMomentumEnded()  {
        hideSlider()
    }
}

/*func progress(_ dir:Dir)->CGFloat{
 return SliderListUtils.progress(event.delta[dir], interval(dir), slider(dir).progress)
 }*/
