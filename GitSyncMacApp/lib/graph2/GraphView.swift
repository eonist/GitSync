import Cocoa
@testable import Element
@testable import Utils
class GraphView:Element{
    var contentContainer:Element?
    var itemsHeight:CGFloat {fatalError("Must override in subClass")}//override this for custom value
    var itemHeight:CGFloat {fatalError("Must override in subClass")}//override this for custom value
    var interval:CGFloat{return floor(itemsHeight - height)/itemHeight}
    var progress:CGFloat{return SliderParser.progress(contentContainer!.y, height, itemsHeight)}
    
    override func resolveSkin() {
        //StyleManager.addStyle("GraphView{fill:green;}")
        super.resolveSkin()
        contentContainer = addSubView(Container(width,height,self,"content"))
        
        addEllipse()
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
    func setProgress(_ progress:CGFloat){
        Swift.print("🖼️ moving lableContainer up and down progress: \(progress)")
        //Swift.print("IScrollable.setProgress() progress: \(progress)")
        let progressValue = self.itemsHeight < height ? 0 : progress/*pins the lableContainer to the top if itemsHeight is less than height*/
        //Swift.print("progressValue: " + "\(progressValue)")
        
        let y:CGFloat = ScrollableUtils.scrollTo(progressValue, height, itemsHeight)
        contentContainer!.y = y/*we offset the y position of the lableContainer*/
    }
    
}

extension GraphView{
    
}
//TimeBar
//ValueBar
//GraphLine2
//HorizontalView
