import Foundation
@testable import Element
@testable import Utils

class TimeBar3:ElasticScrollFastList{
    override func createMover(){
        /*RubberBand*/
        let frame:RubberBand.Frame = (min:0,len:maskSize[dir])//CGRect(0,0,width,height)/*represents the visible part of the content *///TODO: could be ranmed to maskRect
        let itemsRect:RubberBand.Frame = (min:0,len:contentSize[dir])/*represents the total size of the content *///TODO: could be ranmed to contentRect
        mover = SnappyRubberBand(Animation.sharedInstance,setProgress/*👈important*/,frame,itemsRect)
        mover!.event = onEvent/*Add an eventHandler for the mover object, , this has no functionality in this class, but may have in classes that extends this class, like hide progress-indicator when all animation has stopped*/
    }
}
