import Cocoa
@testable import Element
@testable import Utils
/**
 * TODO: Pinch to zoom
 * TODO: slidable in x-axis
 * TODO: bounce back x-axis
 * TODO: bounce back on zoom min and max
 */
enum Dir {
    case hor, ver, z
}
class ElasticView:Element{
    var maskFrame:CGRect = CGRect()
    var contentFrame:CGRect = CGRect()
    var contentContainer:Element?
    var zoomContainer:Element?
    var moverY:RubberBand?
    var moverX:RubberBand?
    var moverZ:RubberBand?
    func mover(_ dir:Dir)->RubberBand{/*Convenience*/
        return dir == .hor ? moverX! : (dir == .ver ? moverY! : moverZ!)
    }
    var iterimScrollY:InterimScroll = InterimScroll()
    var iterimScrollX:InterimScroll = InterimScroll()
    var iterimScrollZ:InterimScroll = InterimScroll()
    func iterimScroll(_ dir:Dir)->InterimScroll{/*Convenience*/
        return dir == .hor ? iterimScrollX : (dir == .ver ? iterimScrollY : iterimScrollZ)
    }
    var prevMagnificationValue:CGFloat = 0
    var initBoundWidth:CGFloat?
    var initBoundHeight:CGFloat?
    //var tempPagePos:CGPoint?
    /**/
    var valueZ:CGFloat?
    
    override func resolveSkin() {
        super.resolveSkin()//self.skin = SkinResolver.skin(self)//
        
        /*init*/
        contentContainer = addSubView(Container(width,height,self,"content"))
        zoomContainer = contentContainer!.addSubView(Container(width,height,contentContainer,"zoom"))
        layer!.masksToBounds = true/*masks the children to the frame, I don't think this works, seem to work now*/
        /*config*/
        maskFrame = CGRect(0,0,width,height)/*represents the visible part of the content *///TODO: could be ranmed to maskRect
        contentFrame = CGRect(0,0,width,height)/*represents the total size of the content *///TODO: could be ranmed to contentRect
        /*anim*/
        moverY = RubberBand(Animation.sharedInstance,setY/*👈important*/,(maskFrame.y,maskFrame.size.height),(contentFrame.y,contentFrame.size.height))
        moverX = RubberBand(Animation.sharedInstance,setX/*👈important*/,(maskFrame.x,maskFrame.size.width),(contentFrame.x,contentFrame.size.width))
        valueZ = height
        let initMin:CGFloat = 0
        moverZ = RubberBand(Animation.sharedInstance,setZ/*👈important*/,(maskFrame.y,maskFrame.size.height),(initMin,valueZ!))
        
        /*pinch to zoom*/
        let magGesture = NSMagnificationGestureRecognizer(target: self, action: #selector(onMagnifyGesture))
        self.addGestureRecognizer(magGesture)
        initBoundWidth = contentContainer!.bounds.size.width
        initBoundHeight = contentContainer!.bounds.size.height
    }
    override func scrollWheel(with event: NSEvent) {
        Swift.print("scrollWheel")
        switch event.phase{
        case NSEventPhase.changed:onScrollWheelChange(event,event.scrollingDeltaX != 0 ? .hor : .ver)/*Fires everytime there is direct scrollWheel gesture movment and momentum, the momentum fades.*/
            case NSEventPhase.mayBegin:onScrollWheelEnter()/*Can be used to detect if two fingers are touching the trackpad*/
            case NSEventPhase.began:onScrollWheelEnter()/*The mayBegin phase doesnt fire if you begin the scrollWheel gesture very quickly*/
            case NSEventPhase.ended:onScrollWheelExit()//Swift.print("ended")/*if you release your touch-gesture and the momentum of the gesture has stopped.*/
            case NSEventPhase.cancelled:onScrollWheelExit()//Swift.print("cancelled")/*this trigers if the scrollWhell gestures goes off the trackpad etc*/
            //case NSEventPhase(rawValue:0):onInDirectScrollWheelChange(event);/*Swift.print("none");*/break;//swift 3 update, was -> NSEventPhase.none
            default:break;
        }
        super.scrollWheel(with: event)
    }
    
}
/*Pan related*/
extension ElasticView{
    func setY(_ value:CGFloat){
        contentContainer!.frame.y = value
    }
    func setX(_ value:CGFloat){
        contentContainer!.frame.x = value
    }
    /**
     * NOTE: Basically when you perform a scroll-gesture on the touch-pad
     */
    func onScrollWheelChange(_ event:NSEvent, _ dir:Dir = .ver){
        Swift.print("👻📜 (ElasticScrollable).onScrollWheelChange : \(event.type)")
        iterimScrollY.prevScrollingDelta = event.scrollingDeltaY/*is needed when figuring out which dir the wheel is spinning and if its spinning at all*/
        iterimScrollX.prevScrollingDelta = event.scrollingDeltaX
        Swift.print("mover!.isDirectlyManipulating: " + "\(moverY!.isDirectlyManipulating)")
        _ = iterimScrollY.velocities.pushPop(event.scrollingDeltaY)/*insert new velocity at the begining and remove the last velocity to make room for the new*/
        _ = iterimScrollX.velocities.pushPop(event.scrollingDeltaX)
        moverY!.value += event.scrollingDeltaY/*directly manipulate the value 1 to 1 control*/
        moverX!.value += event.scrollingDeltaX
        moverY!.updatePosition()/*the mover still governs the resulting value, in order to get the displacement friction working*/
        moverX!.updatePosition()
        setY(moverY!.result)//new ⚠️️
        setX(moverX!.result)//new ⚠️️
    }
    /**
     * NOTE: Basically when you enter your scrollWheel gesture
     */
    func onScrollWheelEnter(){
        Swift.print("👻📜 (ElasticScrollable).onScrollWheelEnter")
        //Swift.print("IRBScrollable.onScrollWheelDown")
        moverY!.stop()
        moverX!.stop()
        moverY!.hasStopped = true/*set the stop flag to true*/
        moverX!.hasStopped = true
        iterimScrollY.prevScrollingDelta = 0/*set last wheel speed delta to stationary, aka not spinning*/
        iterimScrollX.prevScrollingDelta = 0
        moverY!.isDirectlyManipulating = true/*Toggle to directManipulationMode*/
        moverX!.isDirectlyManipulating = true
        iterimScrollY.velocities = Array(repeating: 0, count: 10)/*Reset the velocities*/
        iterimScrollX.velocities = Array(repeating: 0, count: 10)
        //⚠️️scrollWheelEnter()
    }
    /**
     * NOTE: Basically when you release your scrollWheel gesture
     */
    func onScrollWheelExit(){
        Swift.print("👻📜 (ElasticScrollable).onScrollWheelExit")
        //Swift.print("IRBScrollable.onScrollWheelUp")
        moverY!.hasStopped = false/*Reset this value to false, so that the FrameAnimatior can start again*/
        moverX!.hasStopped = false
        moverY!.isDirectlyManipulating = false
        moverX!.isDirectlyManipulating = false
        moverY!.value = moverY!.result/*Copy this back in again, as we used relative friction when above or bellow constraints*/
        moverX!.value = moverX!.result
        Swift.print("prevScrollingDeltaY: " + "\(iterimScrollY.prevScrollingDelta)")
        /*Y*/
        if(iterimScrollY.prevScrollingDelta != 1.0 && iterimScrollY.prevScrollingDelta != -1.0){/*Not 1 and not -1 indicates that the wheel is not stationary*/
            var velocity:CGFloat = 0
            if(iterimScrollY.prevScrollingDelta > 0){velocity = NumberParser.max(iterimScrollY.velocities)}/*Find the most positive velocity value*/
            else{velocity = NumberParser.min(iterimScrollY.velocities)}/*Find the most negative velocity value*/
            moverY!.velocity = velocity/*set the mover velocity to the current mouse gesture velocity, the reason this can't be additive is because you need to be more immediate when you change direction, this could be done by assering last direction but its not a priority atm*///td try the += on the velocity with more rects to see its effect
            moverY!.start()/*start the frameTicker here, do this part in parent view or use event or Selector*/
        }else{/*stationary*/
            moverY!.start()/*This needs to start if your in the overshoot areas, if its not in the overshoot area it will just stop after a frame tick*/
        }
        /*X*/
        if(iterimScrollX.prevScrollingDelta != 1.0 && iterimScrollX.prevScrollingDelta != -1.0){/*Not 1 and not -1 indicates that the wheel is not stationary*/
            var velocity:CGFloat = 0
            if(iterimScrollX.prevScrollingDelta > 0){velocity = NumberParser.max(iterimScrollX.velocities)}/*Find the most positive velocity value*/
            else{velocity = NumberParser.min(iterimScrollX.velocities)}/*Find the most negative velocity value*/
            moverX!.velocity = velocity/*set the mover velocity to the current mouse gesture velocity, the reason this can't be additive is because you need to be more immediate when you change direction, this could be done by assering last direction but its not a priority atm*///td try the += on the velocity with more rects to see its effect
            moverX!.start()/*start the frameTicker here, do this part in parent view or use event or Selector*/
        }else{/*stationary*/
            moverX!.start()/*This needs to start if your in the overshoot areas, if its not in the overshoot area it will just stop after a frame tick*/
        }
    }
}
/*Zoom related*/
extension ElasticView{
    /**
     * TODO: The current solution doesn't let you zoom and pan at the same time. So you possibly need to make your own
     */
    func onMagnifyGesture(gestureRecognizer: NSMagnificationGestureRecognizer) {
        Swift.print("⚠️️ DocView.onMagnifyGesture() magnification: " + "\(gestureRecognizer.magnification)")
        if(gestureRecognizer.state == .changed){
            Swift.print("the zoom changed")
            let fractionalDelta:CGFloat = gestureRecognizer.magnification - prevMagnificationValue
            Swift.print("fractionalDelta: " + "\(fractionalDelta)")
            let zDelta:CGFloat = 1000 * fractionalDelta
            Swift.print("zDelta: " + "\(zDelta)")
            iterimScrollY.prevScrollingDelta = zDelta/*is needed when figuring out which dir the wheel is spinning and if its spinning at all*/
            _ = iterimScrollY.velocities.pushPop(zDelta)/*insert new velocity at the begining and remove the last velocity to make room for the new*/
            moverZ!.value += zDelta/*directly manipulate the value 1 to 1 control*/
            moverZ!.updatePosition()/*the mover still governs the resulting value, in order to get the displacement friction working*/
            setZ(moverZ!.result)
            prevMagnificationValue = gestureRecognizer.magnification
        }else if(gestureRecognizer.state == .began){//include maybegin here
            Swift.print("the zoom began")
            moverZ!.stop()
            moverZ!.hasStopped = true
            iterimScrollZ.prevScrollingDelta = 0
            moverZ!.isDirectlyManipulating = true
            iterimScrollZ.velocities = Array(repeating: 0, count: 10)
            prevMagnificationValue = 0
        }else if(gestureRecognizer.state == .ended){
            Swift.print("the zoom ended")
            moverZ!.hasStopped = false
            moverZ!.isDirectlyManipulating = false
            moverZ!.value = moverZ!.result
            /*Y*/
            if(iterimScrollZ.prevScrollingDelta != 0){/*Not 1 and not -1 indicates that the wheel is not stationary*/
                var velocity:CGFloat = 0
                if(iterimScrollZ.prevScrollingDelta > 0){velocity = NumberParser.max(iterimScrollZ.velocities)}/*Find the most positive velocity value*/
                else{velocity = NumberParser.min(iterimScrollZ.velocities)}/*Find the most negative velocity value*/
                moverZ!.velocity = velocity/*set the mover velocity to the current mouse gesture velocity, the reason this can't be additive is because you need to be more immediate when you change direction, this could be done by assering last direction but its not a priority atm*///td try the += on the velocity with more rects to see its effect
                moverZ!.start()/*start the frameTicker here, do this part in parent view or use event or Selector*/
            }else{/*stationary*/
                moverZ!.start()/*This needs to start if your in the overshoot areas, if its not in the overshoot area it will just stop after a frame tick*/
            }
            prevMagnificationValue = 0
        }
    }
    /**
     *
     */
    func setZ(_ value:CGFloat){
        Swift.print("setZ: " + "\(value)")
        let scalarZoom:CGFloat = height/(height-value)//0-1
        Swift.print("scalarZoom: " + "\(scalarZoom)")
        directZoom(scalarZoom)
    }
    /**
     * PARAM: zoom: accumulated zoom. starts at 1
     */
    func directZoom(_ zoom:CGFloat){
        let objSize:CGSize = CGSize(zoomContainer!.frame.size.width*zoom,zoomContainer!.frame.size.height*zoom)
        let canvasSize:CGSize = CGSize(width,height)
        let newPos:CGPoint = Align.alignmentPoint(objSize, canvasSize, Alignment.centerCenter, Alignment.centerCenter, CGPoint())
        zoomContainer!.point = newPos
        Utils.applyContentsScale(zoomContainer!, zoom)//<---TODO: add this method in page?
        zoomContainer!.bounds.w = initBoundWidth!/* * scale*/
        zoomContainer!.bounds.h = initBoundHeight!/* * scale*/
        zoomContainer!.scaleUnitSquare(to: NSSize(zoom,zoom))
    }
}
private class Utils{
    /**
     * Applies contentsScale to descendants of a view that has been zoomed (so that we avoid pixelation while zooming)
     * NOTE: maybe you can use a method in ElementModifier as it has similar code
     * TODO: a setNeedsDisplay() on fillShape and lineShape could fix a potential problem were contesScale is applied if there isnt a redraw. But this is not confirmed
     */
    class func applyContentsScale(_ view:NSView,_ multiplier:CGFloat){
        //Swift.print("applyContentsScale()")
        for child in view.subviews{
            if(child is IGraphic){
                let graphic:IGraphic = child as! IGraphic
                graphic.fillShape.contentsScale = 2.0 * multiplier/*<--2.0 represents retina screen*/
                graphic.lineShape.contentsScale = 2.0 * multiplier
                
            }
            if(child.subviews.count > 0) {applyContentsScale(child,multiplier)}/*<--this line makes it recursive*/
        }
    }
}
