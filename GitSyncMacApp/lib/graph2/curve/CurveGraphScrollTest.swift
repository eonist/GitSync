import Cocoa
@testable import Utils
@testable import Element

//1800 in width, that scrolls
//add curveGraph
//add 2 dots that marks the spot
//scale the cruvegraph
//find the dot points
//add dot points to array of points within visual field
//find min y from these points
//find the dif between bottom.y and min y
//find the ratio between height and diff
//scale a line graph with a point scale with the new ratio
//take it for a spin

class CurveGraphScrollTest:ContainerView2{
    typealias P = CGPoint
    var points:[CGPoint]?
    var graphPoint1:Element?
    var graphPoint2:Element?
    var graphLine:GraphLine?
    
    override var itemSize:CGSize {return CGSize(100,100)}//override this for custom value
    override var interval:CGFloat{return floor(contentSize.w - maskSize.w)/itemSize.width}
    override var progress:CGFloat{return SliderParser.progress(contentContainer!.x, maskSize.w, contentSize.w)}
    
    override func resolveSkin() {
        StyleManager.addStyle("CurveGraphScrollTest{float:none;clear:none;fill:green;fill-alpha:0.0;}")
        super.resolveSkin()
        /*config*/
        maskSize = CGSize(width,height)/*represents the visible part of the content *///TODO: could be ranmed to maskRect
        contentSize = CGSize(1800,height)/*represents the total size of the content *///TODO: could be ranmed to contentRect
        
        addGraphLine()
        addGraphPoint()
    }
}
extension CurveGraphScrollTest{
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
extension CurveGraphScrollTest{
    func addGraphLine(){
        addGraphLineStyle()
        let path:IPath = PolyLineGraphicUtils.path([])
        graphLine = contentContainer!.addSubView(GraphLine(width,height,path))
    }
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
    func addGraphPoint(){
        /*gp1*/
        addGraphPointStyle()
        graphPoint1 = self.addSubView(Element(NaN,NaN,self,"graphPoint"))
        graphPoint1!.setPosition(P())
        /*gp2*/
        graphPoint2 = self.addSubView(Element(NaN,NaN,self,"graphPoint"))
        graphPoint2!.point = P()
    }
    func addGraphPointStyle(){
        /*GraphPoint*/
        var css:String = ""
        css += "Element#graphPoint{"
        css +=     "float:none;"
        css +=     "clear:none;"
        css +=     "fill:#128BF2,#192633;"
        css +=     "width:12px,11px;"
        css +=     "height:12px,11px;"
        css +=     "margin-left:-6px,-5.5px;"
        css +=     "margin-right:6px,5.5px;"
        css +=     "margin-top:-6px,-5.5px;"
        css +=     "margin-bottom:6px,5.5px;"
        css +=     "drop-shadow:drop-shadow(1px 90 #000000 0.3 0.5 0.5 0 0 false);"
        css +=     "corner-radius:6px,5.5px;"
        css += "}"
        StyleManager.addStyle(css)
    }
}
