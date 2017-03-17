import Foundation
@testable import Element
@testable import Utils

class GraphView2:Element,Scrollable2{
    var maskSize:CGSize = CGSize()
    var contentSize:CGSize = CGSize()
    var contentContainer:Element?
    var itemSize:CGSize {return CGSize(48,48)}//override this for custom value
    var interval:CGFloat{return floor(contentSize.w - maskSize.w)/itemSize.width}
    var progress:CGFloat{return SliderParser.progress(contentContainer!.x, maskSize.w, contentSize.w)}
    
    override func resolveSkin() {
        StyleManager.addStyle("GraphView2{float:left;clear:left;fill:green;fill-alpha:0.0;}")
        super.resolveSkin()
        /*config*/
        maskSize = CGSize(width,height)/*represents the visible part of the content *///TODO: could be ranmed to maskRect
        contentSize = CGSize(1600,height)/*represents the total size of the content *///TODO: could be ranmed to contentRect
        
        contentContainer = addSubView(Container(width,height,self,"content"))
    }
}
