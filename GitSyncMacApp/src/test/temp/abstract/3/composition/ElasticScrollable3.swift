import Cocoa
@testable import Utils
@testable import Element

protocol ElasticScrollable3:Elastic3,Scrollable3 {
    func scrollWheelExitedAndIsStationary()
}
extension ElasticScrollable3{
    /*Pan related*/
    /*func setProgress(_ value:CGFloat,_ dir:Dir){
     contentContainer!.point[dir] = value
     }*/
    /*func setProgress(_ point:CGPoint){
     contentContainer!.point = point
     }*/
    func onInDirectScrollWheelChange(_ event: NSEvent) {}//we must override this or else we get a too loose elastic effect. 
    /**
     * NOTE: Basically when you perform a scroll-gesture on the touch-pad
     */
    func onScrollWheelChange(_ event:NSEvent){
        //Swift.print("👻📜 (ElasticScrollable3).onScrollWheelChange : \(event.type)")
        iterimScrollGroup!.setPrevDelta(event)
        iterimScrollGroup!.shiftAppend(event)/*insert new velocity at the begining and remove the last velocity to make room for the new*/
        moverGroup!.value += event.scrollingDelta/*directly manipulate the value 1 to 1 control*/
        moverGroup!.updatePosition()/*the mover still governs the resulting value, in order to get the displacement friction working*/
        let p = moverGroup!.result
        setProgress(p)
    }
    /**
     * NOTE: Basically when you enter your scrollWheel gesture
     */
    func onScrollWheelEnter(){
        Swift.print("👻📜 (ElasticScrollable3).onScrollWheelEnter")
        moverGroup!.isDirectlyManipulating = true//this was moved
        moverGroup!.stop()
        moverGroup!.hasStopped = true/*set the stop flag to true*/
        iterimScrollGroup!.prevScrollingDelta = 0/*set last wheel speed delta to stationary, aka not spinning*/
        /*Toggle to directManipulationMode*/
        Swift.print("moverGroup!.isDirectlyManipulating: " + "\(moverGroup!.isDirectlyManipulating)")
        iterimScrollGroup!.velocities = Array(repeating: CGPoint(), count: 10)/*Reset the velocities*/
        //⚠️️scrollWheelEnter()
    }
    /**
     * NOTE: Basically when you release your scrollWheel gesture
     */
    func onScrollWheelExit(){
        Swift.print("👻📜 (ElasticScrollable3).onScrollWheelExit")
        //Swift.print("IRBScrollable.onScrollWheelUp")
        moverGroup!.hasStopped = false/*Reset this value to false, so that the FrameAnimatior can start again*/
        moverGroup!.isDirectlyManipulating = false
        moverGroup!.value = moverGroup!.result/*Copy this back in again, as we used relative friction when above or bellow constraints*/
        
        //Swift.print("prevScrollingDeltaY: " + "\(iterimScrollY.prevScrollingDelta)")
        let caseA = iterimScrollGroup!.iterimScrollX.prevScrollingDelta != 1.0 && iterimScrollGroup!.iterimScrollX.prevScrollingDelta != -1.0
        Swift.print("caseA: " + "\(caseA)")
        let caseB = iterimScrollGroup!.iterimScrollY.prevScrollingDelta != 1.0 && iterimScrollGroup!.iterimScrollY.prevScrollingDelta != -1.0/*Not 1 and not -1 indicates that the wheel is not stationary*/
        Swift.print("caseB: " + "\(caseB)")
        if(caseA || caseB){
            let velocity:CGPoint = {
                Swift.print("iterimScrollX.velocities: " + "\(iterimScrollGroup!.iterimScrollX.velocities)")
                Swift.print("iterimScrollY.velocities: " + "\(iterimScrollGroup!.iterimScrollY.velocities)")
                
                let x:CGFloat = iterimScrollGroup!.iterimScrollX.velocities.filter{$0 != 0}.average
                let y:CGFloat = iterimScrollGroup!.iterimScrollY.velocities.filter{$0 != 0}.average
                return CGPoint(x,y)
            }()
            Swift.print("velocity: " + "\(velocity)")
            moverGroup!.velocity = velocity/*set the mover velocity to the current mouse gesture velocity, the reason this can't be additive is because you need to be more immediate when you change direction, this could be done by assering last direction but its not a priority atm*///td try the += on the velocity with more rects to see its effect
        }
        moverGroup!.start()/*start the frameTicker here, do this part in parent view or use event or Selector*//*This needs to start if your in the overshoot areas, if its not in the overshoot area it will just stop after a frame tick*/
    }
    func scrollWheelExitedAndIsStationary(){}/*override when you need this call*/
}
