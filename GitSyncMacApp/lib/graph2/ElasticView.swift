import Cocoa
@testable import Element
@testable import Utils
/**
 * TODO: Pinch to zoom
 * TODO: slidable in x-axis
 * TODO: bounce back x-axis
 * TODO: bounce back on zoom min and max
 */
class ElasticView:Element{
    var maskFrame:CGRect = CGRect()
    var contentFrame:CGRect = CGRect()
    var contentContainer:Element?
    /**/
    var mover:RubberBand?
    var iterimScroll:InterimScroll = InterimScroll()
    
    override func resolveSkin() {
        super.resolveSkin()//self.skin = SkinResolver.skin(self)//
        contentContainer = addSubView(Container(width,height,self,"content"))
        layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now*/
        
        maskFrame = CGRect(0,0,width,height)/*represents the visible part of the content *///TODO: could be ranmed to maskRect
        contentFrame = CGRect(0,0,width,height)/*represents the total size of the content *///TODO: could be ranmed to contentRect
        mover = RubberBand(Animation.sharedInstance,setProgress/*👈important*/,maskFrame,contentFrame)
        mover!.event = onEvent/*Add an eventHandler for the mover object, , this has no functionality in this class, but may have in classes that extends this class, like hide progress-indicator when all animation has stopped*/
    
    }
    /**
     *
     */
    func setProgress(_ value:CGFloat){//DIRECT TRANSMISSION 💥
        Swift.print("Elastic2.setProgress() value: " + "\(value)")
        contentContainer!.frame.y = value/*<--this is where we actully move the labelContainer*/
        //the bellow var may not be need to be set
        iterimScroll.progressValue = value / -(contentFrame.size.height - maskFrame.size.height)/*get the the scalar values from value.*/
    }
    
    override func scrollWheel(with event: NSEvent) {
        Swift.print("scrollWheel")
        switch event.phase{
            case NSEventPhase.changed:onScrollWheelChange(event)/*Fires everytime there is direct scrollWheel gesture movment and momentum, the momentum fades.*/
            case NSEventPhase.mayBegin:onScrollWheelEnter()/*Can be used to detect if two fingers are touching the trackpad*/
            case NSEventPhase.began:onScrollWheelEnter()/*The mayBegin phase doesnt fire if you begin the scrollWheel gesture very quickly*/
            case NSEventPhase.ended:onScrollWheelExit();//Swift.print("ended")/*if you release your touch-gesture and the momentum of the gesture has stopped.*/
            case NSEventPhase.cancelled:onScrollWheelExit();//Swift.print("cancelled")/*this trigers if the scrollWhell gestures goes off the trackpad etc*/
            //case NSEventPhase(rawValue:0):onInDirectScrollWheelChange(event);/*Swift.print("none");*/break;//swift 3 update, was -> NSEventPhase.none
            default:break;
        }
        super.scrollWheel(with: event)
    }
    
}

extension ElasticView{
    /**
     * NOTE: Basically when you perform a scroll-gesture on the touch-pad
     */
    func onScrollWheelChange(_ event:NSEvent){
        Swift.print("👻📜 (ElasticScrollable).onScrollWheelChange : \(event.type)")
        iterimScroll.prevScrollingDelta = event.scrollingDeltaY/*is needed when figuring out which dir the wheel is spinning and if its spinning at all*/
        Swift.print("mover!.isDirectlyManipulating: " + "\(mover!.isDirectlyManipulating)")
        _ = iterimScroll.velocities.pushPop(event.scrollingDeltaY)/*insert new velocity at the begining and remove the last velocity to make room for the new*/
        mover!.value += event.scrollingDeltaY/*directly manipulate the value 1 to 1 control*/
        mover!.updatePosition()/*the mover still governs the resulting value, in order to get the displacement friction working*/
        setProgress(mover!.result)//new ⚠️️
    }
    /**
     * NOTE: Basically when you enter your scrollWheel gesture
     */
    func onScrollWheelEnter(){
        Swift.print("👻📜 (ElasticScrollable).onScrollWheelEnter")
        //Swift.print("IRBScrollable.onScrollWheelDown")
        mover!.stop()
        mover!.hasStopped = true/*set the stop flag to true*/
        iterimScroll.prevScrollingDelta = 0/*set last wheel speed delta to stationary, aka not spinning*/
        mover!.isDirectlyManipulating = true/*Toggle to directManipulationMode*/
        iterimScroll.velocities = Array(repeating: 0, count: 10)/*Reset the velocities*/
        //⚠️️scrollWheelEnter()
    }
    /**
     * NOTE: Basically when you release your scrollWheel gesture
     */
    func onScrollWheelExit(){
        Swift.print("👻📜 (ElasticScrollable).onScrollWheelExit")
        //Swift.print("IRBScrollable.onScrollWheelUp")
        mover!.hasStopped = false/*Reset this value to false, so that the FrameAnimatior can start again*/
        mover!.isDirectlyManipulating = false
        mover!.value = mover!.result/*Copy this back in again, as we used relative friction when above or bellow constraints*/
        Swift.print("prevScrollingDeltaY: " + "\(iterimScroll.prevScrollingDelta)")
        if(iterimScroll.prevScrollingDelta != 1.0 && iterimScroll.prevScrollingDelta != -1.0){/*Not 1 and not -1 indicates that the wheel is not stationary*/
            var velocity:CGFloat = 0
            if(iterimScroll.prevScrollingDelta > 0){velocity = NumberParser.max(iterimScroll.velocities)}/*Find the most positive velocity value*/
            else{velocity = NumberParser.min(iterimScroll.velocities)}/*Find the most negative velocity value*/
            mover!.velocity = velocity/*set the mover velocity to the current mouse gesture velocity, the reason this can't be additive is because you need to be more immediate when you change direction, this could be done by assering last direction but its not a priority atm*///td try the += on the velocity with more rects to see its effect
            mover!.start()/*start the frameTicker here, do this part in parent view or use event or Selector*/
        }else{/*stationary*/
            mover!.start()/*This needs to start if your in the overshoot areas, if its not in the overshoot area it will just stop after a frame tick*/
            //scrollWheelExitedAndIsStationary()/*This is only called if you exit scrollWheel when in overshot areas in the slider, think above 0 and bellow 1 in progress*/
        }
        //⚠️️scrollWheelExit()
    }
}
