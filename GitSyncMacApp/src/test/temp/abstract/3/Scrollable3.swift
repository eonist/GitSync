import Cocoa
@testable import Utils
@testable import Element

protocol Scrollable3:Progressable3 {
    func onScrollWheelChange(_ event:NSEvent)
    func onScrollWheelEnter()
    func onScrollWheelExit()
    func onScrollWheelCancelled()
    func onInDirectScrollWheelChange(_ event:NSEvent)
    /*Momentum*/
    func onScrollWheelMomentumEnded()
    func onScrollWheelMomentumBegan()
}
extension Scrollable3{
    /**
     * NOTE: if the prev Change event only had -1 or 1 or 0. Then you released with no momentum and so no anim should be initiated
     */
    func scroll(_ event:NSEvent){
        //Swift.print("event.momentumPhase: " + "\(event.momentumPhase)")
        //Swift.print("event.phase: " + "\(event.phase)")
        if(event.phase != NSEventPhase.changed || event.momentumPhase != NSEventPhase.changed){
            Swift.print("event.momentumPhase: " + "\(event.momentumPhase)")
            Swift.print("event.phase: " + "\(event.phase)")
        }
        //continue here: 🏀
            //problem is onExit when stationarry, but has moved
                //maybe the momentumPhase and phase can be used together to detect 👉 the difference in momentum-exit and non-momentum-exit 👈
        
        //Swift.print("Scrollable3.scroll() \(event.phase.type) scrollDeltaX: \(event.scrollingDeltaX) deltaX: \(event.deltaX)")
        switch event.phase{
            case NSEventPhase.changed/*4*/:onScrollWheelChange(event)/*Fires everytime there is direct scrollWheel gesture movment and momentum, the momentum fades.*/
            case NSEventPhase.mayBegin/*32*/:onScrollWheelEnter()/*Can be used to detect if two fingers are touching the trackpad*/
            case NSEventPhase.began/*1*/:onScrollWheelEnter()/*The mayBegin phase doesn't fire if you begin the scrollWheel gesture very quickly*/
            case NSEventPhase.ended/*8*/:onScrollWheelExit()//Swift.print("ended")/*if you release your touch-gesture and the momentum of the gesture has stopped.*/
            case NSEventPhase.cancelled/*16*/:onScrollWheelCancelled()/*this trigers if the scrollWhell gestures goes off the trackpad etc, and also if there was no movement and you release again*/
            //case NSEventPhase(rawValue:0):onInDirectScrollWheelChange(event);/**//*onScrollWheelChange(event)*/_ = "";/*this is the same as momentum aka inDirect scroll, Toggeling this on and off can break things*/
            /*case NSEventPhase.stationary: 2*/
            default:break;
        }
        switch event.momentumPhase{
            case NSEventPhase.began:onScrollWheelMomentumBegan();//this happens when the momntum starts
            case NSEventPhase.changed:onInDirectScrollWheelChange(event);
            case NSEventPhase.ended:onScrollWheelMomentumEnded();
            default:break;
        }
        
        //super.scrollWheel(with:event)
    }
    func onScrollWheelChange(_ event:NSEvent){
        Swift.print("Scrollable3.onScrollWheelChange()")
        //Swift.print("contentSize: " + "\(contentSize)")
        //let progress:CGFloat = SliderParser.progress(event.delta, maskSize, contentSize).y
        let progressVal:CGPoint = SliderListUtils.progress(event.delta, interval, progress)
        //setProgress(progressVal)
        setProgress(progressVal)
    }/*Direct scroll, not momentum*/
    func onInDirectScrollWheelChange(_ event:NSEvent){
        onScrollWheelChange(event)
    }
    func onScrollWheelEnter(){Swift.print("Scrollable3.onScrollWheelEnter()")}
    /*This happens after when there has been panning*/
    func onScrollWheelExit(){Swift.print("Scrollable3.onScrollWheelExit()")}
    func onScrollWheelMomentumEnded(){Swift.print("Scrollable3.onScrollWheelMomentumEnded")}
    /*This happens when there has been no panning, just 2 finger touch and release with out moving around*/
    func onScrollWheelCancelled(){Swift.print("Scrollable3.onScrollWheelCancelled")}
}
extension ContainerView3 {//private maybe?
    /**
     * TODO: Try to override with generics ContainerView<VerticalScrollable>  etc
     */
    override open func scrollWheel(with event: NSEvent) {
       // Swift.print("ContainerView3.scrollWheel")
        if(self is ElasticSlidableScrollable3){
            (self as! ElasticSlidableScrollable3).scroll(event)
        }else if(self is Scrollable3){
            (self as! Scrollable3).scroll(event)
        }/*else if(self is Slidable3){
         if(event.phase == NSEventPhase.mayBegin || event.phase == NSEventPhase.began){
         (self as! Slidable3).showSlider()
         }
         }*/
        super.scrollWheel(with: event)
    }
}
