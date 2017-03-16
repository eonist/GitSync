import Cocoa
@testable import Element
@testable import Utils
class GraphView:Element{
    var contentContainer:Element?
    
    override func resolveSkin() {
        //StyleManager.addStyle("GraphView{fill:green;}")
        super.resolveSkin()
        contentContainer = addSubView(Container(width,height,self,"content"))
    }
    override func scrollWheel(with event: NSEvent) {//TODO: move to displaceview
        //scroll(event)/*forward the event to the extension which adjust Slider and calls setProgress in this method*/
        super.scrollWheel(with: event)/*forward the event other delegates higher up in the stack*/
        switch event.phase{
        case NSEventPhase.changed:onScrollWheelChange(event)/*Fires everytime there is direct scrollWheel gesture movment and momentum, the momentum fades.*/
        case NSEventPhase(rawValue:0):onScrollWheelChange(event);/*Swift.print("none");*/break;//swift 3 update, was -> NSEventPhase.none
        default:break;
        }
    }
    /**
     * NOTE: Basically when you perform a scroll-gesture on the touch-pad
     */
    func onScrollWheelChange(_ event:NSEvent) {/*Direct scroll, not momentum*/
        Swift.print("📜 Scrollable.onScrollWheelChange: \(event.type)")
        let progressVal:CGFloat = SliderListUtils.progress(event.deltaY, interval, progress)
        setProgress(progressVal)
    }
}
//TimeBar
//ValueBar
//GraphLine2
//HorizontalView
