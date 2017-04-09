import Cocoa
@testable import Element
@testable import Utils

protocol SlidableScrollable3:Slidable3, Scrollable3 {}
extension SlidableScrollable3 {
    /**
     *
     */
    /*func progress(_ dir:Dir)->CGFloat{
     return SliderListUtils.progress(event.delta[dir], interval(dir), slider(dir).progress)
     }*/
    /**
     * TODO: you could also override scroll and hock after the forward scroll call and then retrive the progress from the var. less code, but the value must be written in Displaceview, it could mess up Elastic, because it needs different progress. etc, do later
     */
    func onScrollWheelChange(_ event:NSEvent) {
        Swift.print("🏂📜 SlidableScrollable3.onScrollWheelChange: \(event)")
        let horProg:CGFloat = SliderListUtils.progress(event.delta[.hor], interval(.hor), slider(.hor).progress)//TODO: ⚠️️ merge these 2 lines into one and make a method in SliderListUtils that returns point
        let verProg:CGFloat = SliderListUtils.progress(event.delta[.ver], interval(.ver), slider(.ver).progress)
        (self as Slidable3).setProgress(CGPoint(horProg,verProg))
        (self as Scrollable3).setProgress(CGPoint(horProg,verProg))
    }
    func onInDirectScrollWheelChange(_ event: NSEvent) {//enables momentum
        onScrollWheelChange(event)
    }
    func onScrollWheelEnter() {//IMPORTANT: methods that are called from deep can only override upstream
        showSlider()
    }
    func onScrollWheelExit() {//IMPORTANT: methods that are called from deep can only override upstream
        hideSlider()
    }
}


