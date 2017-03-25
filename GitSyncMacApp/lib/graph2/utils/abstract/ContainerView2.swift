import Cocoa
@testable import Utils
@testable import Element

class ContainerView2:Element,Containable2 {
    var maskSize:CGSize = CGSize()
    var contentSize:CGSize = CGSize()
    var contentContainer:Element?
    var itemSize:CGSize {fatalError("must be overriden in subClass")}//override this for custom value
    var interval:CGFloat{return floor(contentSize.w - maskSize.w)/itemSize.width}
    var progress:CGFloat{return SliderParser.progress(contentContainer!.x, maskSize.w, contentSize.w)}
    override func resolveSkin() {
        super.resolveSkin()
        contentContainer = addSubView(Container(width,height,self,"lable"))//was content, but we want to use old css
    }
}
/*extension ContainerView2:Scrollable2{
    override open func scrollWheel(with event: NSEvent) {
        Swift.print("ContainerView2.scrollWheel")
        scroll(event)
        super.scrollWheel(with: event)
    }
}
extension ContainerView2{
    func onScrollWheelEnter(){Swift.print("ContainerView2.must be overriden")/*fatalError("must be overriden")*/}
    func onScrollWheelExit(){Swift.print("ContainerView2.must be overriden")/*fatalError("must be overriden")*/}
    func onScrollWheelChange(_ event:NSEvent){Swift.print("ContainerView2.must be overriden")/*fatalError("must be overriden")*/}
}*/
