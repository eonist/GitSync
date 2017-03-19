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
    override var itemSize:CGSize {return CGSize(100,100)}//override this for custom value
    override var interval:CGFloat{return floor(contentSize.w - maskSize.w)/itemSize.width}
    override var progress:CGFloat{return SliderParser.progress(contentContainer!.x, maskSize.w, contentSize.w)}
    
    override func resolveSkin() {
        StyleManager.addStyle("CurveGraphScrollTest{float:none;clear:none;fill:green;fill-alpha:0.0;}")
        super.resolveSkin()
        
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
