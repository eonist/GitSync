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
        contentFrame = CGRect(0,0,width,600)/*represents the total size of the content *///TODO: could be ranmed to contentRect
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
            case NSEventPhase(rawValue:0):onInDirectScrollWheelChange(event);/*Swift.print("none");*/break;//swift 3 update, was -> NSEventPhase.none
            default:break;
        }
        super.scrollWheel(with: event)
    }
    
}

extension 
