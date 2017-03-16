import Cocoa
@testable import Element
@testable import Utils
class GraphView:Element{
    var maskFrame:CGRect = CGRect()
    var contentFrame:CGRect = CGRect()
    var contentContainer:Element?
    var contentsLen:CGFloat {return contentFrame.h}//override this for custom value
    var itemLen:CGFloat {return 24}//override this for custom value
    var maskFrameLen:CGFloat {return maskFrame.w}
    var interval:CGFloat{return floor(contentsLen - maskFrameLen)/itemLen}
    var progress:CGFloat{return SliderParser.progress(contentContainer!.y, height, contentsLen)}
    
    override func resolveSkin() {
        StyleManager.addStyle("GraphView{fill:green;fill-alpha:0;}")
        super.resolveSkin()
        /*config*/
        maskFrame = CGRect(0,0,width,height)/*represents the visible part of the content *///TODO: could be ranmed to maskRect
        contentFrame = CGRect(0,0,width,600)/*represents the total size of the content *///TODO: could be ranmed to contentRect
        
        contentContainer = addSubView(Container(width,height,self,"content"))
        addEllipse()
    }
    override func scrollWheel(with event: NSEvent) {//TODO: move to displaceview
        Swift.print("scrollWheel: ")
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
        let progressValue = self.contentsLen < height ? 0 : progress/*pins the lableContainer to the top if itemsHeight is less than height*/
        //Swift.print("progressValue: " + "\(progressValue)")
        
        let y:CGFloat = ScrollableUtils.scrollTo(progressValue, height, contentsLen)
        contentContainer!.y = y/*we offset the y position of the lableContainer*/
    }
    
}

extension GraphView{
    /**
     *
     */
    func addEllipse(){
        let gradient = LinearGradient(Gradients.blue(),[],π/2)
        let lineGradient = LinearGradient(Gradients.deepPurple(0.5),[],π/2)
        /*Styles*/
        let fill:GradientFillStyle = GradientFillStyle(gradient);
        let lineStyle = LineStyle(20,NSColorParser.nsColor(Colors.green()).alpha(0.5),CGLineCap.round)
        let line = GradientLineStyle(lineGradient,lineStyle)
        
        let objSize:CGSize = CGSize(200,200)
        Swift.print("objSize: " + "\(objSize)")
        let viewSize:CGSize = CGSize(width,height)
        Swift.print("viewSize: " + "\(viewSize)")
        let p = Align.alignmentPoint(objSize, viewSize, Alignment.centerCenter, Alignment.centerCenter,CGPoint())
        Swift.print("p: " + "\(p)")
        
        /*let rect = RectGraphic(0,0,width,height,fill,line)
         zoomContainer!.addSubview(rect.graphic)
         rect.draw()*/
        
        let ellipse = EllipseGraphic(p.x,p.y,200,200,fill.mix(Gradients.green()),line.mix(Gradients.lightGreen(0.5)))
        contentContainer!.addSubview(ellipse.graphic)
        ellipse.draw()
    }
}
//TimeBar
//ValueBar
//GraphLine2
//HorizontalView
