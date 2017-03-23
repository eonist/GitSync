import Cocoa
@testable import Element
@testable import Utils

protocol ElasticScrollable2:Elastic2,Scrollable2 {
    func setProgress(_ value:CGFloat)
}
extension ElasticScrollable2{
    /*func setProgress(_ value:CGFloat){
        contentContainer!.frame.x = value
     }*/
     func onScrollWheelChange(_ event:NSEvent){
        Swift.print("👻📜 (ElasticScrollable2).onScrollWheelChange : \(event.type)")
        iterimScroll.prevScrollingDelta = event.scrollingDeltaX
        _ = iterimScroll.velocities.pushPop(event.scrollingDeltaX)
        mover!.value += event.scrollingDeltaX
        mover!.updatePosition()
        setProgress(mover!.result)
    }
    /**
     * NOTE: Basically when you enter your scrollWheel gesture
     */
     func onScrollWheelEnter(){
        Swift.print("👻📜 (ElasticScrollable2).onScrollWheelEnter")
        //Swift.print("IRBScrollable.onScrollWheelDown")
        mover!.stop()
        mover!.hasStopped = true
        iterimScroll.prevScrollingDelta = 0
        mover!.isDirectlyManipulating = true
        iterimScroll.velocities = Array(repeating: 0, count: 10)/*reset*/
        //⚠️️scrollWheelEnter()
    }
    /**
     * NOTE: Basically when you release your scrollWheel gesture
     */
     func onScrollWheelExit(){
        Swift.print("👻📜 (ElasticScrollable2).onScrollWheelExit")
        Swift.print("iterimScroll.prevScrollingDelta: " + "\(iterimScroll.prevScrollingDelta)")
        //Swift.print("IRBScrollable.onScrollWheelUp")
        mover!.hasStopped = false
        mover!.isDirectlyManipulating = false
        mover!.value = mover!.result
        
        /*X*/
        if(iterimScroll.prevScrollingDelta != 1.0 && iterimScroll.prevScrollingDelta != -1.0){/*Not 1 and not -1 indicates that the wheel is not stationary*/
            var velocity:CGFloat = 0
            if(iterimScroll.prevScrollingDelta > 0){velocity = NumberParser.max(iterimScroll.velocities)}/*Find the most positive velocity value*/
            else{velocity = NumberParser.min(iterimScroll.velocities)}/*Find the most negative velocity value*/
            mover!.velocity = velocity/*set the mover velocity to the current mouse gesture velocity, the reason this can't be additive is because you need to be more immediate when you change direction, this could be done by assering last direction but its not a priority atm*///td try the += on the velocity with more rects to see its effect
            mover!.start()/*start the frameTicker here, do this part in parent view or use event or Selector*/
        }else{/*stationary*/
            mover!.start()/*This needs to start if your in the overshoot areas, if its not in the overshoot area it will just stop after a frame tick*/
        }
    }
}
