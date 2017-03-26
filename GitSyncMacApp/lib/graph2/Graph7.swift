import Cocoa
@testable import Utils
@testable import Element

//Continue here:
    //Try to generalize the layout code in Fast list, so that it supports vertical and horizontal.

class Graph7:ContainerView2,Scrollable2{
    override var itemSize:CGSize {return CGSize(100,100)}//override this for custom value
    //override var interval:CGFloat{return floor(contentSize.w - maskSize.w)/itemSize.width}
    //override var progress:CGFloat{return SliderParser.progress(contentContainer!.x, maskSize.w, contentSize.w)}
    override var contentSize:CGSize {get{return CGSize(1800,1000/*super.contentSize.height*/)}set{fatalError("set not implemented")}}/*represents the total size of the content *///TODO: could be ranmed to contentRect
    func interval(_ dir:Dir)->CGFloat{
        return floor(contentSize[dir] - maskSize[dir])/itemSize[dir]
    }
    func progress(_ dir:Dir)->CGFloat{
        return SliderParser.progress(contentContainer!.point[dir], maskSize[dir], contentSize[dir])
    }
    override func resolveSkin() {
        StyleManager.addStyle("Graph7{float:left;clear:left;fill:green;fill-alpha:0.0;}")
        super.resolveSkin()
        createEllipse()
    }
}
extension Graph7{
    /**
     * 
     */
    func onScrollWheelChange(_ event:NSEvent) {/*Direct scroll, not momentum*/
        Swift.print("ScrollVList.onScrollWheelChange")
        if(event.deltaX != 0){
            let progressVal:CGFloat = SliderListUtils.progress(event.deltaX, interval(.hor), progress(.hor))
            setProgress(progressVal,.hor)
        }
        if(event.deltaY != 0){
            let progressVal:CGFloat = SliderListUtils.progress(event.deltaY, interval(.ver), progress(.ver))
            setProgress(progressVal,.ver)
        }
    }
   
    /**
     * 🚗 SetProgress
     */
    func setProgress(_ progress:CGFloat,_ dir:Dir){
        //Swift.print("ScrollVList.setProgress progress: \(progress)")
        let value:CGFloat = ScrollableUtils.scrollTo(progress, maskSize[dir], contentSize[dir])
        contentContainer!.point[dir] = value
    }
}
extension Graph7{
    func createEllipse(){
        /*Styles*/
        let gradient = LinearGradient(Gradients.blue(),[],π/2)
        let lineGradient = LinearGradient(Gradients.deepPurple(0.5),[],π/2)
        let fill:GradientFillStyle = GradientFillStyle(gradient);
        let lineStyle = LineStyle(20,NSColorParser.nsColor(Colors.green()).alpha(0.5),CGLineCap.round)
        let line = GradientLineStyle(lineGradient,lineStyle)
        /*size*/
        let objSize:CGSize = CGSize(200,200)
        Swift.print("objSize: " + "\(objSize)")
        let viewSize:CGSize = CGSize(width,height)
        Swift.print("viewSize: " + "\(viewSize)")
        let p = Align.alignmentPoint(objSize, viewSize, Alignment.centerCenter, Alignment.centerCenter,CGPoint())
        Swift.print("p: " + "\(p)")
        /*Graphics*/
        let ellipse = EllipseGraphic(p.x,p.y,200,200,fill.mix(Gradients.green()),line.mix(Gradients.lightGreen(0.5)))
        contentContainer!.addSubview(ellipse.graphic)
        ellipse.draw()
        
        
        /*let rect = RectGraphic(0,0,width,height,fill,line)
         zoomContainer!.addSubview(rect.graphic)
         rect.draw()*/
        
        
    }
}
