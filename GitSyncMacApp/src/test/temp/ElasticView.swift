import Cocoa
@testable import Element
@testable import Utils
/**
 * Testing x & y elastic scrolling
 */
class ElasticView:ContainerView2{//
    override var contentSize: CGSize {return CGSize(super.width*2,super.height*2)}
    var moverGroup:MoverGroup?
    var iterimScrollGroup:IterimScrollGroup?
    
    override func resolveSkin() {
        super.resolveSkin()
        iterimScrollGroup = IterimScrollGroup()
        moverGroup = MoverGroup(setProgress,maskSize,contentSize)
    }
    override func scrollWheel(with event: NSEvent) {
        //Swift.print("scrollWheel event.scrollingDeltaX: \(event.scrollingDeltaX) event.scrollingDeltaY: \(event.scrollingDeltaY)")
        switch event.phase{
            case NSEventPhase.changed:onScrollWheelChange(event)/*Fires everytime there is direct scrollWheel gesture movment and momentum, the momentum fades.*/
            case NSEventPhase.mayBegin:onScrollWheelEnter()/*Can be used to detect if two fingers are touching the trackpad*/
            case NSEventPhase.began:onScrollWheelEnter()/*The mayBegin phase doesn't fire if you begin the scrollWheel gesture very quickly*/
            case NSEventPhase.ended:onScrollWheelExit()//Swift.print("ended")/*if you release your touch-gesture and the momentum of the gesture has stopped.*/
            case NSEventPhase.cancelled:onScrollWheelExit()//Swift.print("cancelled")/*this trigers if the scrollWhell gestures goes off the trackpad etc*/
            //case NSEventPhase(rawValue:0):onInDirectScrollWheelChange(event);/*Swift.print("none");*/break;//swift 3 update, was -> NSEventPhase.none
            default:break;
        }
        super.scrollWheel(with:event)
    }
}
/*Pan related*/
extension ElasticView{
    func setProgress(_ value:CGFloat,_ dir:Dir){
        contentContainer!.point[dir] = value
    }
    func setProgress(_ point:CGPoint){
        contentContainer!.point = point
    }
    /**
     * NOTE: Basically when you perform a scroll-gesture on the touch-pad
     */
    func onScrollWheelChange(_ event:NSEvent){
        //Swift.print("👻📜 (ElasticScrollable).onScrollWheelChange : \(event.type)")
        iterimScroll(.hor).prevScrollingDelta = event.scrollingDelta[.hor]/*is needed when figuring out which dir the wheel is spinning and if its spinning at all*/
        iterimScroll(.ver).prevScrollingDelta = event.scrollingDelta[.ver]
        
        _ = iterimScroll(.hor).velocities.shiftAppend(event.scrollingDelta[.hor])/*insert new velocity at the begining and remove the last velocity to make room for the new*/
        _ = iterimScroll(.ver).velocities.shiftAppend(event.scrollingDelta[.ver])
        moverGroup!.value += event.scrollingDelta/*directly manipulate the value 1 to 1 control*/
        moverGroup!.updatePosition()/*the mover still governs the resulting value, in order to get the displacement friction working*/
        let p = CGPoint(moverGroup!.mover(.hor).result,moverGroup!.mover(.ver).result)
        setProgress(p)
    }
    /**
     * NOTE: Basically when you enter your scrollWheel gesture
     */
    func onScrollWheelEnter(){
        Swift.print("👻📜 (ElasticScrollable).onScrollWheelEnter")
        moverGroup!.stop()
        moverGroup!.hasStopped = true/*set the stop flag to true*/
        iterimScrollGroup!.prevScrollingDelta = 0/*set last wheel speed delta to stationary, aka not spinning*/
        moverGroup!.isDirectlyManipulating = true/*Toggle to directManipulationMode*/
        iterimScrollGroup!.velocities = Array(repeating: CGPoint(), count: 10)/*Reset the velocities*/
        //⚠️️scrollWheelEnter()
    }
    /**
     * NOTE: Basically when you release your scrollWheel gesture
     */
    func onScrollWheelExit(){
        Swift.print("👻📜 (ElasticScrollable).onScrollWheelExit")
        //Swift.print("IRBScrollable.onScrollWheelUp")
        moverGroup!.hasStopped = false/*Reset this value to false, so that the FrameAnimatior can start again*/
        moverGroup!.isDirectlyManipulating = false
        moverGroup!.value = moverGroup!.result/*Copy this back in again, as we used relative friction when above or bellow constraints*/
        
        //Swift.print("prevScrollingDeltaY: " + "\(iterimScrollY.prevScrollingDelta)")
        let caseA = iterimScrollX.prevScrollingDelta != 1.0 && iterimScrollX.prevScrollingDelta != -1.0
        Swift.print("caseA: " + "\(caseA)")
        let caseB = iterimScrollY.prevScrollingDelta != 1.0 && iterimScrollY.prevScrollingDelta != -1.0/*Not 1 and not -1 indicates that the wheel is not stationary*/
        Swift.print("caseB: " + "\(caseB)")
        if(caseA || caseB){
            let velocity:CGPoint = {
                Swift.print("iterimScrollX.velocities: " + "\(iterimScrollX.velocities)")
                Swift.print("iterimScrollY.velocities: " + "\(iterimScrollY.velocities)")
               
                let x:CGFloat = iterimScrollX.velocities.filter{$0 != 0}.average
                let y:CGFloat = iterimScrollY.velocities.filter{$0 != 0}.average
                return CGPoint(x,y)
            }()
            Swift.print("velocity: " + "\(velocity)")
            moverGroup!.velocity = velocity/*set the mover velocity to the current mouse gesture velocity, the reason this can't be additive is because you need to be more immediate when you change direction, this could be done by assering last direction but its not a priority atm*///td try the += on the velocity with more rects to see its effect
        }
        moverGroup!.start()/*start the frameTicker here, do this part in parent view or use event or Selector*//*This needs to start if your in the overshoot areas, if its not in the overshoot area it will just stop after a frame tick*/
    }
}
