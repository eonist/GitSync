import Cocoa
@testable import Utils
@testable import Element

protocol Scrollable3:Progressable3 {
    func onScrollWheelChange(_ event:NSEvent)
    func onScrollWheelEnter()
    func onScrollWheelExit()
    func onInDirectScrollWheelChange(_ event:NSEvent)
}
extension Scrollable3{
    /**
     * NOTE: if the prev Change event only had -1 or 1 or 0. Then you released with no momentum and so no anim should be initiated
     */
    func scroll(_ event:NSEvent){
        Swift.print("Scrollable3.scroll() \(event.phase.type) scrollDeltaX: \(event.scrollingDeltaX) deltaX: \(event.deltaX)")
        switch event.phase{
            case NSEventPhase.changed:onScrollWheelChange(event)/*Fires everytime there is direct scrollWheel gesture movment and momentum, the momentum fades.*/
            case NSEventPhase.mayBegin:onScrollWheelEnter()/*Can be used to detect if two fingers are touching the trackpad*/
            case NSEventPhase.began:onScrollWheelEnter()/*The mayBegin phase doesn't fire if you begin the scrollWheel gesture very quickly*/
            case NSEventPhase.ended:onScrollWheelExit()//Swift.print("ended")/*if you release your touch-gesture and the momentum of the gesture has stopped.*/
            case NSEventPhase.cancelled:onScrollWheelExit()//Swift.print("cancelled")/*this trigers if the scrollWhell gestures goes off the trackpad etc*/
            case NSEventPhase(rawValue:0):onInDirectScrollWheelChange(event);/**//*onScrollWheelChange(event)*/_ = "";/*this is the same as momentum aka inDirect scroll, Toggeling this on and off can break things*/
            default:break;
        }
        //super.scrollWheel(with:event)
    }
    func onScrollWheelChange(_ event:NSEvent){
        setProgress(event.delta)
        let progress:CGPoint = SliderParser.progress(event.delta, maskSize, contentSize)
        setProgress(progress)
    }/*Direct scroll, not momentum*/
    func onInDirectScrollWheelChange(_ event:NSEvent){
        
    }
    func onScrollWheelEnter(){}
    func onScrollWheelExit(){}
}
extension ContainerView3 {//private maybe?
    /**
     * TODO: Try to override with generics ContainerView<VerticalScrollable>  etc
     */
    override open func scrollWheel(with event: NSEvent) {
        //Swift.print("scroll")
        if(self is Scrollable3){
            (self as! Scrollable3).scroll(event)
        }
        super.scrollWheel(with: event)
    }
}
