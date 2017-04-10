import Foundation
@testable import Utils
@testable import Element

class ElasticSlideScrollList3:SlideList3,ElasticSlidableScrollable3 {
    lazy var moverGroup:MoverGroup? = MoverGroup(self.setProgress,self.maskSize,self.contentSize)
    lazy var iterimScrollGroup:IterimScrollGroup? = IterimScrollGroup()
    override func resolveSkin() {
        super.resolveSkin()
        moverGroup!.xMover.event = onEvent/*Add an eventHandler for the mover object, , this has no functionality in this class, but may have in classes that extends this class, like hide progress-indicator when all animation has stopped*/
        moverGroup!.yMover.event = onEvent
    }
    override func onEvent(_ event:Event) {
        Swift.print("ElasticSlideScrollList3.onEvent: " + "\(event.type)")
        if(event.type == AnimEvent.stopped){
            Swift.print("moverGroup!.isDirectlyManipulating: " + "\(moverGroup!.isDirectlyManipulating)")
            if(!moverGroup!.isDirectlyManipulating){
                
                let dir:Dir = event.origin === moverGroup!.yMover ? .ver : .hor
                Swift.print("bounce back anim stopp dir: \(dir)")
                hideSlider(dir)/*hides the slider when bounce back anim stopps*/
            }
        }
        super.onEvent(event)
    }
}

/*override open func scrollWheel(with event: NSEvent) {
 Swift.print("SlideView3.scrollWheel() \(event.type)")
 super.scrollWheel(with: event)
 if(event.phase == NSEventPhase.mayBegin || event.phase == NSEventPhase.began){
 showSlider()
 }
 /*else if(event.phase == NSEventPhase.ended || event.phase == NSEventPhase.cancelled){
 //hideSlider()
 }*/
 }*/
