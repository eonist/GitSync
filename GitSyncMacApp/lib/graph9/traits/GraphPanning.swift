import Cocoa
@testable import Element
@testable import Utils


/*Panning controller*/
extension Graph9{
    override func scrollWheel(with event:NSEvent) {
        Swift.print("Graph9.scrollWheel()")
        //super.scrollWheel(with:event)
        (timeBar! as! TimeBar3).adHockScrollWheel(event)
        if(event.phase == .changed || event.phase == NSEventPhase(rawValue:0)){
            /*if(hasPanningChanged){
             updateDateText()
             }*/
            
        }
    }
}
