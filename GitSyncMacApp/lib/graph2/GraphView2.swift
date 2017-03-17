import Cocoa
@testable import Element
@testable import Utils

class GraphView2:ContainerView2{
    typealias P = CGPoint
    var points:[CGPoint] = []
    
    override var itemSize:CGSize {return CGSize(48,48)}//override this for custom value
    override var interval:CGFloat{return floor(contentSize.w - maskSize.w)/itemSize.width}
    override var progress:CGFloat{return SliderParser.progress(contentContainer!.x, maskSize.w, contentSize.w)}
    
    override func resolveSkin() {
        StyleManager.addStyle("GraphView2{float:left;clear:left;fill:green;fill-alpha:0.0;}")
        super.resolveSkin()
        /*config*/
        maskSize = CGSize(width,height)/*represents the visible part of the content *///TODO: could be ranmed to maskRect
        contentSize = CGSize(1600,height)/*represents the total size of the content *///TODO: could be ranmed to contentRect
        
        contentContainer = addSubView(Container(width,height,self,"content"))
        addGraphLine()
    }
    
    
}
extension GraphView2{
    /**
     *
     */
    func addGraphLine(){
        addGraphLineStyle()
        
        points = (0..<18).map{
            let x:CGFloat = 100*$0
            let y:CGFloat = (0..<(height.int-32)).random.cgFloat
            return P(x,y)
        }
        
        let path:IPath = PolyLineGraphicUtils.path(points)
        let graphLine = contentContainer!.addSubView(GraphLine(width,height,path))
        _ = graphLine
    }
    /**
     *
     */
    func addGraphLineStyle(){
        var css:String = "GraphLine{"
        css +=    "float:none;"
        css +=    "clear:none;"
        css +=    "line:#2AA3EF;"
        css +=    "line-alpha:1;"
        css +=    "line-thickness:0.5px;"
        css += "}"
        StyleManager.addStyle(css)
    }
}
/*Animation*/
extension GraphView2{
    override func onScrollWheelChange(_ event:NSEvent) {/*Direct scroll, not momentum*/
        let progressVal:CGFloat = SliderListUtils.progress(event.deltaX, interval, progress)
        setProgress(progressVal)
    }
    func setProgress(_ progress:CGFloat){
        let x:CGFloat = ScrollableUtils.scrollTo(progress, maskSize.w, contentSize.w)
        Swift.print("x: " + "\(x)")
        contentContainer!.x = x
    }
}
